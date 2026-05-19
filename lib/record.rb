# frozen_string_literal: true

# Represents a dns record
class Record
  def initialize(name, type, detector)
    @name = name
    @type = type
    @detector = detector
  end

  def update
    return unless ip_changed?

    return unless inwx_record

    Nameserver.updateRecord(id: inwx_record['id'], content: ip_address)
  end

  private

  def ip_address
    @detector.detect
  end

  def ip_changed?
    true
  end

  def inwx_record
    inwx_records = Nameserver.info(roId: dns_domain['roId'])['record']
    inwx_records.find do |inwx_record|
      match?(inwx_record)
    end
  end

  def dns_domain
    raise 'no domainlist from inwx' unless domainlist

    domainlist['domains'].find do |entry|
      ace(@name).end_with?(ace(entry['domain']))
    end
  end

  def domainlist
    @domainlist ||= Nameserver.list
  end

  def match?(inwx_record)
    return false if ace(inwx_record['name']) != ace(@name)
    return false if inwx_record['type'] != @type

    true
  end

  def ace(string)
    SimpleIDN.to_ascii(string)
  end
end

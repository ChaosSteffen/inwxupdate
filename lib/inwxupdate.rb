# frozen_string_literal: true

require_relative 'inwx.rb'
require_relative 'detectors/detector.rb'
require_relative 'detectors/ifconfig.rb'
require_relative 'detectors/ipify.rb'
require_relative 'detectors/ruby.rb'

require 'simpleidn'

# Update inwx DNS records
class Inwxupdate
  def run
    find_config!

    login

    CONFIG[:jobs].each do |job|
      process_job(job)
    end
  end

  private

  def find_config!
    [
      '/etc/inwxupdate.config.rb',
      '/usr/local/etc/inwxupdate.config.rb',
      ENV['HOME'] + '/inwxupdate.config.rb',
      './inwxupdate.config.rb'
    ].each do |path|
      return require(path) if File.exist?(path)
      next
    end

    raise 'no config found'
  end

  def login
    Account.login(
      user: CONFIG[:inwx_user],
      pass: CONFIG[:inwx_pass],
      lang: 'en'
    )
  end

  def process_job(job)
    job[:records].each do |config_record|
      matching_record = get_dns_record(config_record)

      next unless matching_record

      ip = Detector.setup(job[:detector]).detect
      Nameserver.updateRecord(id: matching_record['id'], content: ip)
    end
  end

  def get_dns_record(config_record)
    domain = get_domain_from_name(config_record[:name])

    inwx_records = Nameserver.info(roId: domain['roId'])['record']
    inwx_records.find do |inwx_record|
      match?(inwx_record, config_record)
    end
  end

  def get_domain_from_name(name)
    domainlist = Nameserver.list

    raise 'no domainlist from inwx' unless domainlist

    domainlist['domains'].find do |entry|
      ace(name).end_with?(ace(entry['domain']))
    end
  end

  def match?(inwx_record, config_record)
    return false if ace(inwx_record['name']) != ace(config_record[:name])
    return false if inwx_record['type'] != config_record[:type]

    true
  end

  def ace(string)
    SimpleIDN.to_ascii(string)
  end
end

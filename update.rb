# frozen_string_literal: true

require './config.rb'

require './lib/inwx.rb'
require './lib/get_ip.rb'

Account.login(user: CONFIG[:inwx_user], pass: CONFIG[:inwx_pass], lang: 'en')

JOBS = CONFIG[:jobs]
JOBS.each do |job|
  records_to_update = job[:records]

  records_to_update.each do |record_to_update|
    domains = Nameserver.list['domains']
    domain = domains.find do |entry|
      record_to_update[:name].end_with?(entry['domain'])
    end

    records = Nameserver.info(roId: domain['roId'])['record']
    matching_record = records.find do |record|
      record['name'] == record_to_update[:name] && record['type'] == record_to_update[:type]
    end

    if matching_record
      ip = get_ip(job[:network_interface])
      Nameserver.updateRecord(id: matching_record['id'], content: ip)
    end
  end
end

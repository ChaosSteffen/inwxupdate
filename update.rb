# frozen_string_literal: true

require 'inwx/domrobot'
require 'yaml'
require './config.rb'
require './lib/wrapper.rb' # Api wrapper for more convient calls
require './lib/get_ip.rb'

DOMBOT = INWX::Domrobot.new('api.domrobot.com')
result = DOMBOT.login(CONFIG[:inwx_user], CONFIG[:inwx_pass])
puts YAML.dump(result) if CONFIG[:debug]

JOBS = CONFIG[:jobs]
JOBS.each do |job|
  records_to_update = job[:records]

  records_to_update.each do |record_to_update|
    domains = Nameserver.list['resData']['domains']
    domain = domains.find do |entry|
      record_to_update[:name].end_with?(entry['domain'])
    end

    records = Nameserver.info(roId:domain['roId'])['resData']['record']
    record = records.find do |record|
      record['name'] == record_to_update[:name] && record['type'] == record_to_update[:type]
    end

    if record
      ip = get_ip(job[:network_interface])
      Nameserver.updateRecord(id:record['id'], content:ip)
    end
  end
end

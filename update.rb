# frozen_string_literal: true

require 'inwx/domrobot'
require 'yaml'
require './config.rb'
require './lib/wrapper.rb' # Api wrapper for more convient calls
require './lib/get_ip.rb'

IP = get_ip()
DOMBOT = INWX::Domrobot.new('api.domrobot.com')

result = DOMBOT.login(CONFIG[:inwx_user], CONFIG[:inwx_pass])
puts YAML.dump(result) if CONFIG[:debug]

dns_entries = Array.new() << CONFIG[:inwx_dns_entries]
dns_entries.flatten!

dns_entries.each do |dns_entry|
  domains = Nameserver.list['resData']['domains']
  domain = domains.find do |entry|
    dns_entry.end_with?(entry['domain'])
  end

  records = Nameserver.info(roId:domain['roId'])['resData']['record']
  record = records.find do |record|
    record['name'] == dns_entry && record['type'] == 'AAAA'
  end

  Nameserver.updateRecord(id:record['id'], content:IP)
end

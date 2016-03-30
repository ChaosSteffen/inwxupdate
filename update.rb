# frozen_string_literal: true

require 'inwx/domrobot'
require 'yaml'
require './config.rb'

addr = 'api.domrobot.com'
user = CONFIG[:inwx_user]
pass = CONFIG[:inwx_pass]

domrobot = INWX::Domrobot.new(addr)

result = domrobot.login(user, pass)
puts YAML.dump(result) if CONFIG[:debug]

raw = `ifconfig #{CONFIG[:network_interface]} inet6 | grep inet6 | grep -v fe80 | grep -v deprecated`
v6ip = raw.lstrip.split(' ')[1]

raise 'no v6 ip detected' unless !!v6ip

dns_entries = Array.new() << CONFIG[:inwx_dns_entries]
dns_entries.flatten!

dns_entries.each do |dns_entry|
  result = domrobot.call('nameserver', 'updateRecord', { id: dns_entry, content: v6ip })
  puts YAML.dump(result) if CONFIG[:debug]
end

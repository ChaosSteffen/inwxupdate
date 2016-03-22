# frozen_string_literal: true

require 'inwx/Domrobot'
require 'yaml'

config = YAML.load(open('config.yml'))

addr = 'api.domrobot.com'
user = config['inwx_user']
pass = config['inwx_pass']

domrobot = INWX::Domrobot.new(addr)

result = domrobot.login(user, pass)
puts YAML.dump(result) if config['debug']

raw = `ifconfig #{config['network_interface']} inet6 | grep inet6 | grep -v fe80 | grep -v deprecated`
v6ip = raw.lstrip.split(' ')[1]

params = { id: config['inwx_dns_entry'], content: v6ip }

result = domrobot.call('nameserver', 'updateRecord', params)
puts YAML.dump(result) if config['debug']

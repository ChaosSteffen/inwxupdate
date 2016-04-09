# frozen_string_literal: true

def get_ip(network_interface)
  raw = `ifconfig #{network_interface} inet6 | grep inet6 | grep -v fe80 | grep -v deprecated`
  ip = raw.lstrip.split(' ')[1]

  raise 'no v6 ip detected' unless ip

  ip
end

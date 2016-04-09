def get_ip
  raw = `ifconfig #{CONFIG[:network_interface]} inet6 | grep inet6 | grep -v fe80 | grep -v deprecated`
  v6ip = raw.lstrip.split(' ')[1]

  raise 'no v6 ip detected' unless !!v6ip

  return v6ip
end

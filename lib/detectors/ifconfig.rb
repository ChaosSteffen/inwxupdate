# frozen_string_literal: true

# Detects your current IP via `ifconfig`
class Ifconfig
  def initialize(network_interface, _version)
    @network_interface = network_interface
  end

  def detect
    raw = `ifconfig #{@network_interface} inet6 | grep inet6 | grep -v fe80 | grep -v deprecated`
    ip = raw.lstrip.split(' ')[1]

    raise 'no ip detected' unless ip

    ip
  end
end

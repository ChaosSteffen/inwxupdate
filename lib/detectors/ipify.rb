# frozen_string_literal: true

# Detects your current IP via `ifconfig`
class Ipify
  def initialize(network_interface, version)
    @network_interface = network_interface
    @version = version == 6 ? 6 : 4

    raise 'Ipify supports only IPv4 yet' if version == 6
  end

  def detect
    command = [
      'curl',
      "-#{@version}",
      "--interface #{@network_interface}",
      "'https://api.ipify.org?format=text'",
      '-s'
    ].join(' ')

    ip = `#{command}`

    raise 'no ip detected' unless ip

    ip
  end
end

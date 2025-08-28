# frozen_string_literal: true

# Detects your current IP via ipify.org API
class Ipify
  def initialize(network_interface, version)
    @network_interface = network_interface
    @version = version == 6 ? 6 : 4
  end

  def detect
    api_url = @version == 6 ? 'https://api6.ipify.org?format=text' : 'https://api.ipify.org?format=text'
    
    command = [
      'curl',
      "-#{@version}",
      "--interface #{@network_interface}",
      "'#{api_url}'",
      '-s'
    ].join(' ')

    ip = `#{command}`

    raise 'no ip detected' unless ip

    ip
  end
end

# frozen_string_literal: true
require 'socket'

# Detects your current IP via Ruby Sockets
class Ruby
  def initialize(network_interface, version)
    @network_interface = network_interface
    @version = version == 6 ? 6 : 4
  end

  def detect
    ip_addresses =
      if version == 6
        Socket.ip_address_list.select(&:ipv6?).reject(&:ipv6_loopback?)
      else
        Socket.ip_address_list.select(&:ipv4?).reject(&:ipv4_loopback?)
      end

    ip = ip_addresses.first.ip_address

    raise 'no ip detected' unless ip

    ip
  end
end

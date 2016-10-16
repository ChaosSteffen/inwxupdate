# frozen_string_literal: true
require_relative 'inwx.rb'
require_relative 'detectors/detector.rb'
require_relative 'detectors/ifconfig.rb'
require_relative 'detectors/ipify.rb'

def find_config!
  [
    '/etc/inwxupdate.config.rb',
    '/usr/local/etc/inwxupdate.config.rb',
    '~/inwxupdate.config.rb',
    './inwxupdate.config.rb'
  ].each do |path|
    return require(path) if File.exist?(path)
    next
  end

  raise 'no config found'
end

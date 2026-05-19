# frozen_string_literal: true

require_relative 'inwx.rb'
require_relative 'job.rb'
require_relative 'record.rb'
require_relative 'detectors/detector.rb'
require_relative 'detectors/ifconfig.rb'
require_relative 'detectors/ipify.rb'
require_relative 'detectors/ruby.rb'
require_relative 'detectors/timestamp.rb'

require 'simpleidn'

# Update inwx DNS records
class Inwxupdate
  def initialize
    find_config
  end

  def run
    CONFIG[:jobs].each do |job_config|
      Job.new(job_config).process
    end
  end

  private

  def find_config
    [
      '/etc/inwxupdate.config.rb',
      '/usr/local/etc/inwxupdate.config.rb',
      ENV['HOME'] + '/inwxupdate.config.rb',
      './inwxupdate.config.rb'
    ].each do |path|
      return require(path) if File.exist?(path)
      next
    end

    raise 'no config found'
  end
end

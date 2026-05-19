# frozen_string_literal: true

# Represents a set of domains that share the same ip address
class Job
  def initialize(config)
    @config = config
  end

  def process
    records.each do |record|
      record.update
    end
  end

  private

  def records
    @records ||=
      @config[:records].map do |record_config|
        Record.new(record_config[:name], record_config[:type], detector)
      end
  end

  def detector
    @detector ||= Detector.setup(@config[:detector])
  end
end

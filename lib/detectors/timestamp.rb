# frozen_string_literal: true

# Detects your current date
class Timestamp
  def initialize; end

  def detect
    Time.now.to_s
  end
end

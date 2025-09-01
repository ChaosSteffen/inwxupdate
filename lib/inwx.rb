# frozen_string_literal: true

require 'singleton'
require 'inwx-domrobot'
require 'yaml'

# Wrapper for the INWX Official Domrobot Client
class InwxClient
  include Singleton

  def initialize
    @domrobot = nil
  end

  def client
    return @domrobot if @domrobot

    @domrobot = ::INWX::Domrobot.new
    @domrobot.use_live.use_xml.set_language('en')
    @domrobot.set_debug(CONFIG[:debug] || false)
    @domrobot
  end

  def call(object, method, params = {})
    result = client.call(object, method, params)
    puts YAML.dump(result) if CONFIG[:debug]
    result
  end

  def login(username, password)
    client.login(username, password)
  end
end

# Implements the convenience API wrapper to maintain backward compatibility
class APIObject
  # rubocop:disable Style/MethodMissing
  def self.method_missing(method_name, *args)
    object_name = name.downcase
    params = args.first || {}

    result = InwxClient.instance.call(object_name, method_name.to_s, params)
    result['resData']
  end
  # rubocop:enable Style/MethodMissing
end

class Account < APIObject; end
class Accounting < APIObject; end
class Application < APIObject; end
class Contact < APIObject; end
class Domain < APIObject; end
class Host < APIObject; end
class Hosting < APIObject; end
class Message < APIObject; end
class Nameserver < APIObject; end
class NameserverSet < APIObject; end
class Pdf < APIObject; end
class Tag < APIObject; end

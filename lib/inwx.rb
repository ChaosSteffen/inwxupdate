# frozen_string_literal: true

require 'singleton'
require 'xmlrpc/client'
require 'yaml'

# Wrapper for the INWX XMLRPC Client
class INWX
  include Singleton

  def initialize
    # Create a new client instance
    @client = XMLRPC::Client.new(CONFIG[:inwx_api], '/xmlrpc/', '443', nil, nil, nil, nil, true, 100)
  end

  def call(object, method, params = {})
    @client.call("#{object}.#{method}", params)
  end
end

# Implements the convienience
class APIObject
  def self.method_missing(*args)
    args = [name.downcase] + args

    result = INWX.instance.call(*args)

    puts YAML.dump(result) if CONFIG[:debug]

    result['resData']
  end
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

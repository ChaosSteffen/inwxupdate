class APIObject
  def self.method_missing(method_name, options=nil)
    result = if options
      DOMBOT.call(self.name.downcase, method_name.to_s, options)
    else
      DOMBOT.call(self.name.downcase, method_name.to_s)
    end
    puts YAML.dump(result) if CONFIG[:debug]

    return result
  end
end

class Nameserver < APIObject; end
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

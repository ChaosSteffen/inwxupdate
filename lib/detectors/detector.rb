# Wraps around different detector implementations
module Detector
  def self.setup(params)
    ifconfig(params) ||
      ipify(params) ||
      ruby_sockets(params) ||
      timestamp(params)
  end

  def self.ifconfig(params)
    return unless params[:type] == 'ifconfig' && params[:version] == 6

    Ifconfig.new(params[:network_interface], params[:version])
  end

  def self.ipify(params)
    return unless params[:type] == 'ipify'
    Ipify.new(params[:network_interface], params[:version])
  end

  def self.ruby_sockets(params)
    Ruby.new(params[:version]) if params[:type] == 'ruby'
  end

  def self.timestamp(params)
    Timestamp.new if params[:type] == 'timestamp'
  end
end

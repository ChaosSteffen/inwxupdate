class Detector
  def self.setup(paramters)
    if paramters[:type] == 'ifconfig' && paramters[:version] == 6
      return Ifconfig.new(paramters[:network_interface], paramters[:version])
    end

    if paramters[:type] == 'ipify'
      return Ipify.new(paramters[:network_interface], paramters[:version])
    end
  end
end

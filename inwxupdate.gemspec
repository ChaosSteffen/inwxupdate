Gem::Specification.new do |s|
  s.name        = 'inwxupdate'
  s.version     = '0.4.0.pre'
  s.executables << 'inwxupdate'
  s.date        = '2016-10-16'
  s.summary     = 'inwxupdate'
  s.description = 'Updates your inwx-DNS records with the local IPv4/v6 address'
  s.authors     = ['Steffen Schröder']
  s.email       = 'steffen@schröder.xyz'
  s.files       = [
    'lib/detectors/detector.rb',
    'lib/detectors/ifconfig.rb',
    'lib/detectors/ipify.rb',
    'lib/detectors/ruby.rb',
    'lib/detectors/timestamp.rb',
    'lib/inwx.rb',
    'lib/inwxupdate.rb'
  ]
  s.homepage    = 'https://github.com/ChaosSteffen/inwxupdate'
  s.license     = 'BSD'

  s.add_dependency 'simpleidn', '~> 0.0.7'
end

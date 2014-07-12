Gem::Specification.new do |s|
  s.name = 'sps-pub'
  s.version = '0.3.1'
  s.summary = 'A SimplePubSub client for publishing or subscribing to messages in 1 line of code.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_runtime_dependency('simplepubsub', '~> 1.1', '>=1.1.2')
  s.add_runtime_dependency('simpleblockingwebsocketclient', '~> 0.43', '>=0.43')
  s.signing_key = '../privatekeys/sps-pub.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/sps-pub'
  s.required_ruby_version = '>= 2.1.2'
end

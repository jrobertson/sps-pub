Gem::Specification.new do |s|
  s.name = 'sps-pub'
  s.version = '0.5.3'
  s.summary = 'A SimplePubSub client for publishing messages in 1 line of code.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/sps-pub.rb']
  s.add_runtime_dependency('websocket-client-simple', '~> 0.3', '>=0.3.0')
  s.signing_key = '../privatekeys/sps-pub.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/sps-pub'
  s.required_ruby_version = '>= 2.1.0'
end

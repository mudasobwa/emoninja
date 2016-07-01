# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emoninja/version'

Gem::Specification.new do |spec|
  spec.name          = 'emoninja'
  spec.version       = Emoninja::VERSION
  spec.authors       = ['Aleksei Matiushkin']
  spec.email         = ['aleksei.matiushkin@kantox.com']

  spec.summary       = 'Gem to substitute words with emojis in text'
  spec.description   = <<-DESC
  We parse up-to-date OMG standard for unicode emojis and replace words in texts
  with respective emojis when applicable.
  DESC
  spec.homepage      = 'https://github.com/mudasobwa/emoninja'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  fail 'RubyGems => 2.0 is required.' unless spec.respond_to?(:metadata)
  # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'awesome_print'

  spec.add_dependency 'hashie', '~> 3'
  spec.add_dependency 'kungfuig', '~> 0.7'
  spec.add_dependency 'forkforge'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'yandex-api'
end

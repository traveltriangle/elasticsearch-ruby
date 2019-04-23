# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elasticsearch6/dsl/version'

Gem::Specification.new do |s|
  s.name          = "elasticsearch6-dsl"
  s.version       = Elasticsearch6::DSL::VERSION
  s.authors       = ["Karel Minarik"]
  s.email         = ["karel.minarik@elasticsearch6.com"]
  s.description   = %q{A Ruby DSL builder for Elasticsearch6}
  s.summary       = s.description
  s.homepage      = "https://github.com/elasticsearch6/elasticsearch6-ruby/tree/master/elasticsearch6-dsl"
  s.license       = "Apache-2.0"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.extra_rdoc_files  = [ "README.md", "LICENSE.txt" ]
  s.rdoc_options      = [ "--charset=UTF-8" ]

  s.required_ruby_version = '>= 1.9'

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake", "~> 11.1"

  s.add_development_dependency "elasticsearch6"
  s.add_development_dependency "elasticsearch6-extensions"

  s.add_development_dependency 'shoulda-context'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-reporters'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'cane'
  s.add_development_dependency 'pry'

  if defined?(RUBY_VERSION) && RUBY_VERSION > '2.2'
    s.add_development_dependency "test-unit", '~> 2'
  end
end

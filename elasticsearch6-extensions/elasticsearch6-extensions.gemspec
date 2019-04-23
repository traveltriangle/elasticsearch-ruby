# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elasticsearch6/extensions/version'

Gem::Specification.new do |s|
  s.name          = "elasticsearch6-extensions"
  s.version       = Elasticsearch6::Extensions::VERSION
  s.authors       = ["Karel Minarik"]
  s.email         = ["karel.minarik@elasticsearch6.org"]
  s.description   = %q{Extensions for the Elasticsearch6 Rubygem}
  s.summary       = %q{Extensions for the Elasticsearch6 Rubygem}
  s.homepage      = "https://github.com/elasticsearch6/elasticsearch6-ruby/tree/master/elasticsearch6-extensions"
  s.license       = "Apache-2.0"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "ansi"
  s.add_dependency "elasticsearch6"

  if defined?(RUBY_VERSION) && RUBY_VERSION > '1.9'
    s.add_development_dependency "ruby-prof" unless defined?(JRUBY_VERSION) || defined?(Rubinius)
  end

  s.add_development_dependency "bundler"

  if defined?(RUBY_VERSION) && RUBY_VERSION > '1.9'
    s.add_development_dependency "rake", "~> 11.1"
  else
    s.add_development_dependency "rake", "< 11.0"
  end

  s.add_development_dependency "awesome_print"

  s.add_development_dependency 'shoulda-context'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-reporters'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'cane'
  s.add_development_dependency 'pry'

  unless defined?(JRUBY_VERSION)
    s.add_development_dependency 'oj'
    s.add_development_dependency 'patron'
  end

  if defined?(RUBY_VERSION) && RUBY_VERSION < '1.9'
    s.add_development_dependency "json", '~> 1.8'
  end
end
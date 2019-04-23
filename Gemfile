source 'https://rubygems.org'

gem 'elasticsearch6-api',        :path => File.expand_path("../elasticsearch6-api", __FILE__),        :require => false
gem 'elasticsearch6-transport',  :path => File.expand_path("../elasticsearch6-transport", __FILE__),  :require => false
gem 'elasticsearch6-extensions', :path => File.expand_path("../elasticsearch6-extensions", __FILE__), :require => false
gem 'elasticsearch6',            :path => File.expand_path("../elasticsearch6", __FILE__),            :require => false

gem "rake"
gem "pry"
gem "ansi"
gem "shoulda-context"
gem "mocha"
gem "turn"
gem "yard"

if defined?(RUBY_VERSION) && RUBY_VERSION > '1.9'
  gem "ruby-prof"    unless defined?(JRUBY_VERSION) || defined?(Rubinius)
  gem "require-prof" unless defined?(JRUBY_VERSION) || defined?(Rubinius)
  gem "simplecov"
  gem "simplecov-rcov"
  gem "cane"
end

if defined?(RUBY_VERSION) && RUBY_VERSION > '2.2'
  gem "test-unit", '~> 2'
end

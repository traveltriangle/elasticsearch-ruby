RUBY_1_8 = defined?(RUBY_VERSION) && RUBY_VERSION < '1.9'
JRUBY    = defined?(JRUBY_VERSION)

ELASTICSEARCH_HOSTS = if hosts = ENV['TEST_ES_SERVER'] || ENV['ELASTICSEARCH_HOSTS']
                        hosts.split(',').map do |host|
                          /(http\:\/\/)?(\S+)/.match(host)[2]
                        end
                      end.freeze

if RUBY_1_8 and not ENV['BUNDLE_GEMFILE']
  require 'rubygems'
  gem 'test-unit'
end

require 'rubygems' if RUBY_1_8

if ENV['COVERAGE'] && ENV['CI'].nil? && !RUBY_1_8
  require 'simplecov'
  SimpleCov.start { add_filter "/test|test_/" }
end

if ENV['CI'] && !RUBY_1_8
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start { add_filter "/test|test_" }
end

# Register `at_exit` handler for integration tests shutdown.
# MUST be called before requiring `test/unit`.
if defined?(RUBY_VERSION) && RUBY_VERSION > '1.9'
  at_exit { Elasticsearch6::Test::IntegrationTestCase.__run_at_exit_hooks }
end

require 'test/unit'
require 'shoulda-context'
require 'mocha/setup'
require 'ansi/code'
require 'turn' unless ENV["TM_FILEPATH"] || ENV["NOTURN"] || RUBY_1_8

require 'require-prof' if ENV["REQUIRE_PROF"]
require 'elasticsearch6-transport'
require 'logger'

require 'hashie'

RequireProf.print_timing_infos if ENV["REQUIRE_PROF"]

if defined?(RUBY_VERSION) && RUBY_VERSION > '1.9'
  require 'elasticsearch6/extensions/test/cluster'
  require 'elasticsearch6/extensions/test/startup_shutdown'
  require 'elasticsearch6/extensions/test/profiling' unless JRUBY
end

class Test::Unit::TestCase
  def setup
  end

  def teardown
  end
end

module Elasticsearch6
  module Test
    class IntegrationTestCase < ::Test::Unit::TestCase
      extend Elasticsearch6::Extensions::Test::StartupShutdown

      shutdown { Elasticsearch6::Extensions::Test::Cluster.stop if ENV['SERVER'] && started? && Elasticsearch6::Extensions::Test::Cluster.running? }
      context "IntegrationTest" do; should "noop on Ruby 1.8" do; end; end if RUBY_1_8
    end if defined?(RUBY_VERSION) && RUBY_VERSION > '1.9'
  end

  module Test
    class ProfilingTest < ::Test::Unit::TestCase
      extend Elasticsearch6::Extensions::Test::StartupShutdown
      extend Elasticsearch6::Extensions::Test::Profiling

      shutdown { Elasticsearch6::Extensions::Test::Cluster.stop if ENV['SERVER'] && started? && Elasticsearch6::Extensions::Test::Cluster.running? }
      context "IntegrationTest" do; should "noop on Ruby 1.8" do; end; end if RUBY_1_8
    end unless RUBY_1_8 || JRUBY
  end
end
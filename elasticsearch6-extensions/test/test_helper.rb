JRUBY    = defined?(JRUBY_VERSION)

ELASTICSEARCH_HOSTS = if hosts = ENV['TEST_ES_SERVER'] || ENV['ELASTICSEARCH_HOSTS']
                        hosts.split(',').map do |host|
                          /(http\:\/\/)?(\S+)/.match(host)[2]
                        end
                      end.freeze

TEST_HOST, TEST_PORT = ELASTICSEARCH_HOSTS.first.split(':') if ELASTICSEARCH_HOSTS

if ENV['COVERAGE'] && ENV['CI'].nil? && !RUBY_1_8
  require 'simplecov'
  SimpleCov.start { add_filter "/test|test_" }
end

require 'minitest/autorun'
require 'shoulda-context'
require 'mocha/setup'

require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'ansi/code'
require 'logger'

require 'elasticsearch6/extensions'
require 'elasticsearch6/extensions/test/startup_shutdown'
require 'elasticsearch6/extensions/test/cluster'

module Elasticsearch6
  module Test
    module Assertions
      def assert_nothing_raised(*)
        yield
      end
    end

    class UnitTestCase < ::Minitest::Test
      include Assertions
      alias_method :assert_not_nil, :refute_nil
      alias_method :assert_raise, :assert_raises
    end

    class IntegrationTestCase < ::Minitest::Test
      include Assertions
      alias_method :assert_not_nil, :refute_nil
      alias_method :assert_raise, :assert_raises

      include Elasticsearch6::Extensions::Test
      extend  StartupShutdown

      startup do
        Elasticsearch6::Extensions::Test::Cluster.start(number_of_nodes: 2) if ENV['SERVER'] and not Elasticsearch6::Extensions::Test::Cluster.running?(number_of_nodes: 2)
      end

      shutdown do
        Elasticsearch6::Extensions::Test::Cluster.stop(number_of_nodes: 2) if ENV['SERVER'] and Elasticsearch6::Extensions::Test::Cluster.running?(number_of_nodes: 2)
      end
    end
  end
end
JRUBY = defined?(JRUBY_VERSION)

if ENV['COVERAGE'] || ENV['CI']
  require 'simplecov'
  SimpleCov.start { add_filter "/test|test_" }
end

ELASTICSEARCH_HOSTS = if hosts = ENV['TEST_ES_SERVER'] || ENV['ELASTICSEARCH_HOSTS']
                        hosts.split(',').map do |host|
                          /(http\:\/\/)?(\S+)/.match(host)[2]
                        end
                      end.freeze

at_exit { Elasticsearch6::Test::IntegrationTestCase.__run_at_exit_hooks }

require 'minitest/autorun'
require 'shoulda-context'
require 'mocha/setup'

require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
# Minitest::Reporters.use! [ Minitest::Reporters::SpecReporter.new,
#                            Minitest::Reporters::JUnitReporter.new,
#                            Minitest::Reporters::HtmlReporter.new ]

require 'elasticsearch6'
require 'elasticsearch6/extensions/test/cluster'
require 'elasticsearch6/extensions/test/startup_shutdown'

require 'elasticsearch6/dsl'

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
        Cluster.start(number_of_nodes: 1) if ENV['SERVER'] \
                                && ! Elasticsearch6::Extensions::Test::Cluster.running?(number_of_nodes: 1)
      end

      shutdown do
        Cluster.stop if ENV['SERVER'] \
                     && started?      \
                     && Elasticsearch6::Extensions::Test::Cluster.running?
      end

      def setup

        @logger =  Logger.new(STDERR)
        @logger.formatter = proc do |severity, datetime, progname, msg|
          color = case severity
            when /INFO/ then :green
            when /ERROR|WARN|FATAL/ then :red
            when /DEBUG/ then :cyan
            else :white
          end
          ANSI.ansi(severity[0] + ' ', color, :faint) + ANSI.ansi(msg, :white, :faint) + "\n"
        end

        @client = Elasticsearch6::Client.new hosts: ELASTICSEARCH_HOSTS, logger: (ENV['QUIET'] ? nil : @logger)
        @version = @client.info['version']['number']
      end

      def teardown
        @client.indices.delete index: '_all'
      end
    end
  end
end
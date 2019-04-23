require 'elasticsearch6'
require 'elasticsearch6-transport'
require 'logger'
require 'ansi/code'
require 'hashie/mash'
require 'pry-nav'

# The hosts to use for creating a elasticsearch6 client.
#
# @since 7.0.0
ELASTICSEARCH_HOSTS = if hosts = ENV['TEST_ES_SERVER'] || ENV['ELASTICSEARCH_HOSTS']
                        hosts.split(',').map do |host|
                          /(http\:\/\/)?(\S+)/.match(host)[2]
                        end
                      end.freeze

# Are we testing on JRuby?
#
# @return [ true, false ] Whether JRuby is being used.
#
# @since 7.0.0
def jruby?
  RUBY_PLATFORM =~ /\bjava\b/
end

# The names of the connected nodes.
#
# @return [ Array<String> ] The node names.
#
# @since 7.0.0
def node_names
  $node_names ||= default_client.nodes.stats['nodes'].collect do |name, stats|
    stats['name']
  end
end

# The default client.
#
# @return [ Elasticsearch6::Client ] The default client.
#
# @since 7.0.0
def default_client
  $client ||= Elasticsearch6::Client.new(hosts: ELASTICSEARCH_HOSTS)
end

module Config

  def self.included(context)

    # Get the hosts to use to connect an elasticsearch6 client.
    #
    # @since 7.0.0
    context.let(:hosts) { ELASTICSEARCH_HOSTS }
  end
end

RSpec.configure do |config|
  config.include(Config)
  config.formatter = 'documentation'
  config.color = true
end

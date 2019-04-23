require 'elasticsearch6/dsl/version'

require 'elasticsearch6/dsl/utils'
require 'elasticsearch6/dsl/search/base_component'
require 'elasticsearch6/dsl/search/base_compound_filter_component'
require 'elasticsearch6/dsl/search/base_aggregation_component'
require 'elasticsearch6/dsl/search/query'
require 'elasticsearch6/dsl/search/filter'
require 'elasticsearch6/dsl/search/aggregation'
require 'elasticsearch6/dsl/search/highlight'
require 'elasticsearch6/dsl/search/sort'
require 'elasticsearch6/dsl/search/options'
require 'elasticsearch6/dsl/search/suggest'

Dir[ File.expand_path('../dsl/search/queries/**/*.rb', __FILE__) ].each        { |f| require f }
Dir[ File.expand_path('../dsl/search/filters/**/*.rb', __FILE__) ].each        { |f| require f }
Dir[ File.expand_path('../dsl/search/aggregations/**/*.rb', __FILE__) ].each   { |f| require f }

require 'elasticsearch6/dsl/search'

module Elasticsearch6

  # The main module, which can be included into your own class or namespace,
  # to provide the DSL methods.
  #
  # @example
  #
  #     include Elasticsearch6::DSL
  #
  #     definition = search do
  #       query do
  #         match title: 'test'
  #       end
  #     end
  #
  #     definition.to_hash
  #     # => { query: { match: { title: "test"} } }
  #
  # @see Search
  # @see http://www.elasticsearch6.org/guide/en/elasticsearch6/guide/current/query-dsl-intro.html
  #
  module DSL
    def self.included(base)
      base.__send__ :include, Elasticsearch6::DSL::Search
    end
  end
end

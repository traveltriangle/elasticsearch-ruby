module Elasticsearch6
  module DSL
    module Search
      module Queries

        # A query which returns documents matching a wildcard expression
        #
        # @note The expression is *not analyzed* (lowercased, stemmed, etc)
        #
        # @example
        #
        #     search do
        #       query do
        #        wildcard title: 'tw*'
        #       end
        #     end
        #
        # @see http://elasticsearch6.org/guide/en/elasticsearch6/reference/current/query-dsl-wildcard-query.html
        #
        class Wildcard
          include BaseComponent

          option_method :value
          option_method :boost
        end

      end
    end
  end
end

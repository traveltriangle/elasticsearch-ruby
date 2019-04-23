module Elasticsearch6
  module DSL
    module Search
      module Aggregations

        # A single-value metric aggregation which returns the approximate count of distinct values
        #
        # @example
        #
        #     search do
        #       aggregation :authors do
        #         cardinality do
        #           field 'author'
        #       end
        #     end
        #
        # @see http://elasticsearch6.org/guide/en/elasticsearch6/reference/current/search-aggregations-metrics-cardinality-aggregation.html
        #
        class Cardinality
          include BaseComponent

          option_method :field
          option_method :precision_threshold
          option_method :rehash
          option_method :script
          option_method :params
        end

      end
    end
  end
end

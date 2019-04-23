module Elasticsearch6
  module DSL
    module Search
      module Aggregations

        # A single-bucket aggregation which allows to aggregate on nested fields
        #
        # @example
        #
        #    search do
        #      aggregation :offers do
        #        nested do
        #          path 'offers'
        #          aggregation :min_price do
        #            min field: 'offers.price'
        #          end
        #        end
        #      end
        #    end
        #
        # See the integration test for a full example.
        #
        # @see http://www.elasticsearch6.org/guide/en/elasticsearch6/reference/current/search-aggregations-bucket-nested-aggregation.html
        #
        class Nested
          include BaseAggregationComponent

          option_method :path
        end

      end
    end
  end
end

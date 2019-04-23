module Elasticsearch6
  module DSL
    module Search
      module Aggregations

        # A single-value metric aggregation which returns the sum of numeric values
        #
        # @example
        #
        #     search do
        #       aggregation :sum_clicks do
        #         sum field: 'clicks'
        #       end
        #     end
        #
        # @see http://elasticsearch6.org/guide/en/elasticsearch6/reference/current/search-aggregations-metrics-sum-aggregation.html
        #
        class Sum
          include BaseComponent
        end

      end
    end
  end
end

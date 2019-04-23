module Elasticsearch6
  module DSL
    module Search
      module Aggregations

        # A multi-bucket aggregation which will return document counts for geohash grid cells
        #
        # @example
        #
        #     search do
        #       aggregation :venue_distributions do
        #         geohash_grid do
        #           field     :location
        #           precision 5
        #         end
        #       end
        #     end
        #
        # See the integration test for a full example.
        #
        # @see http://elasticsearch6.org/guide/en/elasticsearch6/guide/current/geohash-grid-agg.html
        #
        class GeohashGrid
          include BaseAggregationComponent

          option_method :field
          option_method :precision
          option_method :size
          option_method :shard_size
        end

      end
    end
  end
end

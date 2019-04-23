module Elasticsearch6
  module DSL
    module Search
      module Filters

        # A filter which returns documents which have a non-`null` value in the specified field
        # (ie. the reverse of the `missing` filter)
        #
        # @example
        #
        #     search do
        #       query do
        #         filtered do
        #           filter do
        #             exists field: 'occupation'
        #           end
        #         end
        #       end
        #     end
        #
        # @see http://elasticsearch6.org/guide/en/elasticsearch6/reference/current/query-dsl-exists-filter.html
        #
        class Exists
          include BaseComponent

          option_method :field
        end

      end
    end
  end
end

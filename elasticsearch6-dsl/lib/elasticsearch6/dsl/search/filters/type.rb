module Elasticsearch6
  module DSL
    module Search
      module Filters

        # A filter which returns documents matching the specified type
        #
        # @example
        #
        #     search do
        #       query do
        #         filtered do
        #           filter do
        #             type do
        #               value 'article'
        #             end
        #           end
        #         end
        #       end
        #     end
        #
        #
        # @see http://elasticsearch6.org/guide/en/elasticsearch6/reference/current/query-dsl-type-filter.html
        #
        class Type
          include BaseComponent

          option_method :value
        end

      end
    end
  end
end

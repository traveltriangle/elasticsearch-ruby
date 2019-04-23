module Elasticsearch6
  module DSL
    module Search
      module Filters

        # A filter which matches on all documents
        #
        # @example
        #
        #     search do
        #       query do
        #         filtered do
        #           filter do
        #             match_all
        #           end
        #         end
        #       end
        #     end
        #
        # @see http://www.elasticsearch6.org/guide/en/elasticsearch6/reference/current/query-dsl-match-all-filter.html
        #
        class MatchAll
          include BaseComponent
        end

      end
    end
  end
end
module Elasticsearch6
  module DSL
    module Search
      module Queries

        # A query which executes a custom query only for documents in specified indices,
        # and optionally another query for documents in other indices
        #
        # @example
        #
        #     search do
        #       query do
        #         indices do
        #           indices        ['audio', 'video']
        #           query          match: { artist: 'Fugazi' }
        #           no_match_query match: { label:  'Dischord' }
        #         end
        #       end
        #     end
        #
        # @see http://elasticsearch6.org/guide/en/elasticsearch6/reference/current/query-dsl-indices-query.html
        #
        class Indices
          include BaseComponent

          option_method :indices
          option_method :query
          option_method :no_match_query
        end

      end
    end
  end
end

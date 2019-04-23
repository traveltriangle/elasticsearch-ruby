module Elasticsearch6
  module DSL
    module Search
      module Queries

        # A query which returns documents having a span containing a term
        #
        # @example
        #
        #     search do
        #       query do
        #         span_term title: 'disaster'
        #       end
        #     end
        #
        # @see http://elasticsearch6.org/guide/en/elasticsearch6/reference/current/query-dsl-span-term-query.html
        # @see https://lucene.apache.org/core/5_0_0/core/org/apache/lucene/search/spans/package-summary.html
        #
        class SpanTerm
          include BaseComponent
        end

      end
    end
  end
end

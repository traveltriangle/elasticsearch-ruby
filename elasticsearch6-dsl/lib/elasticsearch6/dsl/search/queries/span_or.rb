module Elasticsearch6
  module DSL
    module Search
      module Queries

        # A query which returns documents matching the union of provided queries
        #
        # @example
        #
        #     search do
        #       query do
        #         span_or clauses: [ { span_term: { title: 'disaster' } }, { span_term: { title: 'health' } } ]
        #       end
        #     end
        #
        # @see http://elasticsearch6.org/guide/en/elasticsearch6/reference/current/query-dsl-span-or-query.html
        # @see https://lucene.apache.org/core/5_0_0/core/org/apache/lucene/search/spans/package-summary.html
        #
        class SpanOr
          include BaseComponent

          option_method :clauses
        end

      end
    end
  end
end

module Elasticsearch6
  module API
    module Actions

      # The value of requests_per_second can be changed on a running reindex using the _rethrottle
      #
      # @option arguments [String] :task_id The task id to rethrottle (*Required*)
      # @option arguments [Number] :requests_per_second The throttle to set on this request in floating sub-requests per second. -1 means set no throttle.
      #
      # @see https://www.elastic.co/guide/en/elasticsearch6/reference/current/docs-reindex.html
      #
      def reindex_rethrottle(arguments={})
        raise ArgumentError, "Required argument 'task_id' missing" unless arguments[:task_id]
        method = Elasticsearch6::API::HTTP_POST
        path   = "_reindex/#{arguments[:task_id]}/_rethrottle"
        params = Elasticsearch6::API::Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)
        body   = nil

        perform_request(method, path, params, body).body
      end

      # Register this action with its valid params when the module is loaded.
      #
      # @since 6.2.0
      ParamsRegistry.register(:reindex_rethrottle, [
          :requests_per_second ].freeze)
    end
  end
end

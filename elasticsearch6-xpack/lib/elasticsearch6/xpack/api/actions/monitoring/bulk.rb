module Elasticsearch6
  module XPack
    module API
      module Monitoring
        module Actions

          # Insert monitoring data in bulk
          #
          # @option arguments [String] :type Default document type for items which don't provide one
          # @option arguments [Hash] :body The operation definition and data (action-data pairs), separated by newlines (*Required*)
          # @option arguments [String] :system_id Identifier of the monitored system
          # @option arguments [String] :system_api_version API version of the monitored system
          # @option arguments [String] :system_version Version of the monitored system
          #
          # @see http://www.elastic.co/guide/en/monitoring/current/appendix-api-bulk.html
          #
          def bulk(arguments={})
            raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]

            valid_params = [
              :system_id,
              :system_api_version,
              :system_version,
              :interval ]

            arguments = arguments.clone
            type = arguments.delete(:type)
            body = arguments.delete(:body)

            method = Elasticsearch6::API::HTTP_POST
            path   = Elasticsearch6::API::Utils.__pathify '_xpack/monitoring', type, '_bulk'
            params = Elasticsearch6::API::Utils.__validate_and_extract_params arguments, valid_params

            if body.is_a? Array
              payload = Elasticsearch6::API::Utils.__bulkify(body)
            else
              payload = body
            end

            perform_request(method, path, params, payload).body
          end
        end
      end
    end
  end
end
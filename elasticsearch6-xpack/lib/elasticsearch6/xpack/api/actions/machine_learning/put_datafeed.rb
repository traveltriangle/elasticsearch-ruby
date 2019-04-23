module Elasticsearch6
  module XPack
    module API
      module MachineLearning
        module Actions

          # Create a new datafeed
          #
          # @option arguments [String] :datafeed_id The ID of the datafeed to create (*Required*)
          # @option arguments [Hash] :body The datafeed config (*Required*)
          #
          # @see http://www.elastic.co/guide/en/elasticsearch6/reference/current/ml-put-datafeed.html
          #
          def put_datafeed(arguments={})
            raise ArgumentError, "Required argument 'datafeed_id' missing" unless arguments[:datafeed_id]
            raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]
            method = Elasticsearch6::API::HTTP_PUT
            path   = "_xpack/ml/datafeeds/#{arguments[:datafeed_id]}"
            params = {}
            body   = arguments[:body]

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

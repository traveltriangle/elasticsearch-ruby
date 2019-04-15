module Elasticsearch6
  module XPack
    module API
      module MachineLearning
        module Actions

          # Update certain properties of a datafeed
          #
          # @option arguments [String] :datafeed_id The ID of the datafeed to update (*Required*)
          # @option arguments [Hash] :body The datafeed update settings (*Required*)
          #
          # @see http://www.elastic.co/guide/en/elasticsearch/reference/current/ml-update-datafeed.html
          #
          def update_datafeed(arguments={})
            raise ArgumentError, "Required argument 'datafeed_id' missing" unless arguments[:datafeed_id]
            raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]

            method = Elasticsearch6::API::HTTP_POST
            path   = "_xpack/ml/datafeeds/#{arguments[:datafeed_id]}/_update"
            params = {}
            body   = arguments[:body]

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

module Elasticsearch6
  module XPack
    module API
      module MachineLearning
        module Actions

          # TODO: Description
          #
          # @option arguments [String] :datafeed_id The ID of the datafeed to delete (*Required*)
          # @option arguments [Boolean] :force True if the datafeed should be forcefully deleted
          #
          # @see http://www.elastic.co/guide/en/elasticsearch6/reference/current/ml-delete-datafeed.html
          #
          def delete_datafeed(arguments={})
            raise ArgumentError, "Required argument 'datafeed_id' missing" unless arguments[:datafeed_id]
            valid_params = [
              :force ]
            method = Elasticsearch6::API::HTTP_DELETE
            path   = "_xpack/ml/datafeeds/#{arguments[:datafeed_id]}"
            params = Elasticsearch6::API::Utils.__validate_and_extract_params arguments, valid_params
            body   = nil

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

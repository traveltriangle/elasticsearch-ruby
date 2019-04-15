module Elasticsearch6
  module XPack
    module API
      module MachineLearning
        module Actions

          # @option arguments [String] :filter_id The ID of the filter to fetch
          # @option arguments [Int] :from skips a number of filters
          # @option arguments [Int] :size specifies a max number of filters to get
          #
          def get_filters(arguments={})
            valid_params = [
              :from,
              :size ]
            method = Elasticsearch6::API::HTTP_GET
            path   = Elasticsearch6::API::Utils.__pathify "_xpack/ml/filters", arguments[:filter_id]
            params = Elasticsearch6::API::Utils.__validate_and_extract_params arguments, valid_params
            body   = nil

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

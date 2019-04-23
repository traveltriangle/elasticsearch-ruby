module Elasticsearch6
  module XPack
    module API
      module MachineLearning
        module Actions

          # @option arguments [Hash] :body The job config (*Required*)
          #
          def validate(arguments={})
            raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]

            method = Elasticsearch6::API::HTTP_POST
            path   = "_xpack/ml/anomaly_detectors/_validate"
            params = {}
            body   = arguments[:body]

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

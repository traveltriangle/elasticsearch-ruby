module Elasticsearch6
  module XPack
    module API
      module MachineLearning
        module Actions

          # Retrieve configuration information for jobs
          #
          # @option arguments [String] :job_id The ID of the jobs to fetch
          # @option arguments [Boolean] :allow_no_jobs Whether to ignore if a wildcard expression matches no jobs. (This includes `_all` string or when no jobs have been specified)
          #
          # @see http://www.elastic.co/guide/en/elasticsearch/reference/current/ml-get-job.html
          #
          def get_jobs(arguments={})
            valid_params = [
              :allow_no_jobs ]

            method = Elasticsearch6::API::HTTP_GET
            path   = "_xpack/ml/anomaly_detectors/#{arguments[:job_id]}"
            params = Elasticsearch6::API::Utils.__validate_and_extract_params arguments, valid_params
            body   = nil

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

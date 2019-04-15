module Elasticsearch6
  module XPack
    module API
      module MachineLearning
        module Actions

          # TODO: Description
          #
          # @option arguments [String] :calendar_id The ID of the calendar to modify (*Required*)
          # @option arguments [String] :job_id The ID of the job to remove from the calendar (*Required*)
          #
          # @see [TODO]
          #
          def delete_calendar_job(arguments={})
            raise ArgumentError, "Required argument 'calendar_id' missing" unless arguments[:calendar_id]
            raise ArgumentError, "Required argument 'job_id' missing" unless arguments[:job_id]
            method = Elasticsearch6::API::HTTP_DELETE
            path   = "_xpack/ml/calendars/#{arguments[:calendar_id]}/jobs/#{arguments[:job_id]}"
            params = {}
            body   = nil

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

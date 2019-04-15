module Elasticsearch6
  module XPack
    module API
      module MachineLearning
        module Actions

          # TODO: Description
          #
          # @option arguments [String] :calendar_id The ID of the calendar to fetch
          # @option arguments [Int] :from skips a number of calendars
          # @option arguments [Int] :size specifies a max number of calendars to get
          #
          # @see [TODO]
          #
          def get_calendars(arguments={})
            valid_params = [
              :calendar_id,
              :from,
              :size ]

            arguments = arguments.clone
            calendar_id = arguments.delete(:calendar_id)

            method = Elasticsearch6::API::HTTP_GET
            path   = "_xpack/ml/calendars/#{calendar_id}"
            params = Elasticsearch6::API::Utils.__validate_and_extract_params arguments, valid_params
            body   = nil

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

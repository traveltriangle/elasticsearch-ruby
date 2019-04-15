module Elasticsearch6
  module XPack
    module API
      module Rollup
        module Actions

          # TODO: Description
          #
          # @option arguments [String] :id The ID of the job to stop (*Required*)
          #
          # @see
          #
          def stop_job(arguments={})
            raise ArgumentError, "Required argument 'id' missing" unless arguments[:id]
            method = Elasticsearch6::API::HTTP_POST
            path   = "_xpack/rollup/job/#{arguments[:id]}/_stop"
            params = {}
            body   = nil

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

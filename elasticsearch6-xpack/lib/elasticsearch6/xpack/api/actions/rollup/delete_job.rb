module Elasticsearch6
  module XPack
    module API
      module Rollup
        module Actions

          # TODO: Description
          #
          # @option arguments [String] :id The ID of the job to delete (*Required*)
          #
          # @see
          #
          def delete_job(arguments={})
            raise ArgumentError, "Required argument 'id' missing" unless arguments[:id]
            method = Elasticsearch6::API::HTTP_DELETE
            path   = "_xpack/rollup/job/#{arguments[:id]}"
            params = {}
            body   = nil

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

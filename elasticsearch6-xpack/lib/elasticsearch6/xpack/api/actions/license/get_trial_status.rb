module Elasticsearch6
  module XPack
    module API
      module License
        module Actions

          # TODO: Description
          #
          #
          # @see https://www.elastic.co/guide/en/x-pack/current/license-management.html
          #
          def get_trial_status(arguments={})
            method = Elasticsearch6::API::HTTP_GET
            path   = "_xpack/license/trial_status"
            params = {}
            body   = nil

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

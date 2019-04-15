module Elasticsearch6
  module XPack
    module API
      module Security
        module Actions

          # Get user privileges
          #
          def get_user_privileges(arguments={})
            method = Elasticsearch6::API::HTTP_GET
            params = {}
            body   = nil

            perform_request(method, '_xpack/security/user/_privileges', params, body).body
          end
        end
      end
    end
  end
end

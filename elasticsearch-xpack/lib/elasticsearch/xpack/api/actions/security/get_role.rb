module Elasticsearch6
  module XPack
    module API
      module Security
        module Actions

          # Retrieve one or more roles from the native realm
          #
          # @option arguments [String] :name Role name
          #
          # @see https://www.elastic.co/guide/en/x-pack/current/security-api-roles.html#security-api-get-role
          #
          def get_role(arguments={})
            method = Elasticsearch6::API::HTTP_GET
            path   = Elasticsearch6::API::Utils.__pathify "_xpack/security/role", Elasticsearch6::API::Utils.__listify(arguments[:name])
            params = {}
            body   = nil

            if Array(arguments[:ignore]).include?(404)
              Elasticsearch6::API::Utils.__rescue_from_not_found { perform_request(method, path, params, body).body }
            else
              perform_request(method, path, params, body).body
            end
          end
        end
      end
    end
  end
end

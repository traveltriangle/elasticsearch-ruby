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
          def get_privileges(arguments={})
            method = Elasticsearch6::API::HTTP_GET
            path   = Elasticsearch6::API::Utils.__pathify "_xpack/security/privilege",
                                                         arguments[:application],
                                                         Elasticsearch6::API::Utils.__listify(arguments[:name])
            params = {}
            body   = nil

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

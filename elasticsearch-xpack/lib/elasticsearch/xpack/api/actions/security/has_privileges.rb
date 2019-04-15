module Elasticsearch6
  module XPack
    module API
      module Security
        module Actions

          # Remove a role from the native realm
          #
          # @option arguments [String] :user Username
          # @option arguments [String] :body The privileges to test (*Required*)
          #
          # @see https://www.elastic.co/guide/en/elasticsearch/reference/current/security-api-has-privileges.html
          #
          def has_privileges(arguments={})
            raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]

            method = Elasticsearch6::API::HTTP_GET

            path   = Elasticsearch6::API::Utils.__pathify "_xpack/security/user", arguments[:user], "_has_privileges"

            perform_request(method, path, {}, arguments[:body]).body
          end
        end
      end
    end
  end
end

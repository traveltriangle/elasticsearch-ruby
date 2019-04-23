module Elasticsearch6
  module XPack
    module API
      module Security
        module Actions

          # Obtain a token for OAuth 2.0 auhentication
          #
          # @option arguments [Hash] :body The token request to get (*Required*)
          #
          # @see https://www.elastic.co/guide/en/x-pack/master/security-api-tokens.html#security-api-get-token
          #
          def get_token(arguments={})
            raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]
            method = Elasticsearch6::API::HTTP_POST
            path   = "_xpack/security/oauth2/token"
            params = {}
            body   = arguments[:body]

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

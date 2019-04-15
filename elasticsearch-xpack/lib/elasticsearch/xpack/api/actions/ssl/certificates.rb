module Elasticsearch6
  module XPack
    module API
      module SSL
        module Actions

          def certificates(arguments={})
            method = Elasticsearch6::API::HTTP_GET
            path   = "_xpack/ssl/certificates"
            params = {}
            body   = nil

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

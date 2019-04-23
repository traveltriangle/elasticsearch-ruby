module Elasticsearch6
  module XPack
    module API
      module SQL
        module Actions

          # TODO: Description
          #
          # @option arguments [Hash] :body Specify the query in the `query` element. (*Required*)
          #
          # @see Translate SQL into Elasticsearch6 queries
          #
          def translate(arguments={})
            raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]
            method = Elasticsearch6::API::HTTP_POST
            path   = "_xpack/sql/translate"
            params = {}
            body   = arguments[:body]

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

module Elasticsearch6
  module XPack
    module API
      module Watcher
        module Actions

          # Retrieve a watch
          #
          # @option arguments [String] :id Watch ID (*Required*)
          #
          # @see https://www.elastic.co/guide/en/x-pack/current/watcher-api-get-watch.html
          #
          def get_watch(arguments={})
            raise ArgumentError, "Required argument 'id' missing" unless arguments[:id]

            method = Elasticsearch6::API::HTTP_GET
            path   = "_xpack/watcher/watch/#{arguments[:id]}"
            params = {}
            body   = nil

            perform_request(method, path, params, body).body
          end
        end
      end
    end
  end
end

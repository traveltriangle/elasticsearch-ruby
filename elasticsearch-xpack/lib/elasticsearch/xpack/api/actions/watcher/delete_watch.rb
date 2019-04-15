module Elasticsearch6
  module XPack
    module API
      module Watcher
        module Actions

          # Remove a watch
          #
          # @option arguments [String] :id Watch ID (*Required*)
          # @option arguments [Duration] :master_timeout Specify timeout for watch write operation
          # @option arguments [Boolean] :force Specify if this request should be forced and ignore locks
          #
          # @see http://www.elastic.co/guide/en/x-pack/current/appendix-api-delete-watch.html
          #
          def delete_watch(arguments={})
            raise ArgumentError, "Required argument 'id' missing" unless arguments[:id]
            valid_params = [
              :master_timeout,
              :force ]
            method = Elasticsearch6::API::HTTP_DELETE
            path   = "_xpack/watcher/watch/#{arguments[:id]}"
            params = Elasticsearch6::API::Utils.__validate_and_extract_params arguments, valid_params
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

module Elasticsearch6
  module XPack
    module API
      module Watcher
        module Actions; end

        class WatcherClient
          include Elasticsearch6::API::Common::Client, Elasticsearch6::API::Common::Client::Base, Watcher::Actions
        end

        def watcher
          @watcher ||= WatcherClient.new(self)
        end

      end
    end
  end
end

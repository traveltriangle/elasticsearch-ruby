module Elasticsearch6
  module XPack
    module API
      module SSL
        module Actions; end

        class SSLClient
          include Elasticsearch6::API::Common::Client, Elasticsearch6::API::Common::Client::Base, SSL::Actions
        end

        def ssl
          @ssl ||= SSLClient.new(self)
        end

      end
    end
  end
end

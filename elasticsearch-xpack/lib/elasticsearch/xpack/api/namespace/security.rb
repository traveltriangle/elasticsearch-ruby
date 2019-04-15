module Elasticsearch6
  module XPack
    module API
      module Security
        module Actions; end

        class SecurityClient
          include Elasticsearch6::API::Common::Client, Elasticsearch6::API::Common::Client::Base, Security::Actions
        end

        def security
          @security ||= SecurityClient.new(self)
        end

      end
    end
  end
end

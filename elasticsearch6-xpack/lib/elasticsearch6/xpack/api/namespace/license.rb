module Elasticsearch6
  module XPack
    module API
      module License
        module Actions; end

        class LicenseClient
          include Elasticsearch6::API::Common::Client, Elasticsearch6::API::Common::Client::Base, License::Actions
        end

        def license
          @license ||= LicenseClient.new(self)
        end

      end
    end
  end
end

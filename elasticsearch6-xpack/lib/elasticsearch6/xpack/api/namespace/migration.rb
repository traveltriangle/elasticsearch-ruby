module Elasticsearch6
  module XPack
    module API
      module Migration
        module Actions; end

        class MigrationClient
          include Elasticsearch6::API::Common::Client, Elasticsearch6::API::Common::Client::Base, Migration::Actions
        end

        def migration
          @migration ||= MigrationClient.new(self)
        end

      end
    end
  end
end

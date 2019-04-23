module Elasticsearch6
  module XPack
    module API
      module SQL
        module Actions; end

        class SQLClient
          include Elasticsearch6::API::Common::Client, Elasticsearch6::API::Common::Client::Base, SQL::Actions
        end

        def sql
          @sql ||= SQLClient.new(self)
        end

      end
    end
  end
end

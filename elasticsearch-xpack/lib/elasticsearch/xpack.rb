require "elasticsearch/api"
require "elasticsearch/xpack/version"

Dir[ File.expand_path('../xpack/api/actions/**/*.rb', __FILE__) ].each   { |f| require f }
Dir[ File.expand_path('../xpack/api/namespace/**/*.rb', __FILE__) ].each { |f| require f }

module Elasticsearch6
  module XPack
    module API
      def self.included(base)
        Elasticsearch6::XPack::API.constants.reject {|c| c == :Client }.each do |m|
          base.__send__ :include, Elasticsearch6::XPack::API.const_get(m)
        end
      end

      class Client
        include Elasticsearch6::API::Common::Client, Elasticsearch6::API::Common::Client::Base
        include Elasticsearch6::XPack::API
      end
    end
  end
end

Elasticsearch6::API::COMMON_PARAMS.push :job_id, :datafeed_id, :filter_id, :snapshot_id, :category_id

module Elasticsearch6
  module Transport
    class Client
      def xpack
        @xpack_client ||= Elasticsearch6::XPack::API::Client.new(self)
      end

      def security
        @security ||= xpack.security
      end

      def ml
        @ml ||= xpack.ml
      end
    end
  end
end if defined?(Elasticsearch6::Transport::Client)

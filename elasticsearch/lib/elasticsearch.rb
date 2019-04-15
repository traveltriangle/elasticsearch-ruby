require "elasticsearch/version"

require 'elasticsearch/transport'
require 'elasticsearch/api'

module Elasticsearch6
  module Transport
    class Client
      include Elasticsearch6::API
    end
  end
end

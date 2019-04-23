require "elasticsearch6/version"

require 'elasticsearch6/transport'
require 'elasticsearch6/api'

module Elasticsearch6
  module Transport
    class Client
      include Elasticsearch6::API
    end
  end
end

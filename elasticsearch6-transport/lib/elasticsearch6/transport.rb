require "uri"
require "time"
require "timeout"
require "multi_json"
require "faraday"

require "elasticsearch6/transport/transport/serializer/multi_json"
require "elasticsearch6/transport/transport/sniffer"
require "elasticsearch6/transport/transport/response"
require "elasticsearch6/transport/transport/errors"
require "elasticsearch6/transport/transport/base"
require "elasticsearch6/transport/transport/connections/selector"
require "elasticsearch6/transport/transport/connections/connection"
require "elasticsearch6/transport/transport/connections/collection"
require "elasticsearch6/transport/transport/http/faraday"
require "elasticsearch6/transport/client"
require "elasticsearch6/transport/redacted"

require "elasticsearch6/transport/version"

module Elasticsearch6
  module Client

    # A convenience wrapper for {::Elasticsearch6::Transport::Client#initialize}.
    #
    def new(arguments={}, &block)
      Elasticsearch6::Transport::Client.new(arguments, &block)
    end
    extend self
  end
end

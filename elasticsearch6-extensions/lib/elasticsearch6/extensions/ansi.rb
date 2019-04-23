# encoding: utf-8

require 'elasticsearch6/extensions'

require 'ansi'
require 'ansi/table'
require 'ansi/terminal'

require 'delegate'
require 'elasticsearch6/transport/transport/response'

require 'elasticsearch6/extensions/ansi/helpers'
require 'elasticsearch6/extensions/ansi/actions'
require 'elasticsearch6/extensions/ansi/response'

module Elasticsearch6
  module Extensions

    # This extension provides a {ResponseBody#to_ansi} method for the Elasticsearch6 response body,
    # which colorizes and formats the output with the `ansi` gem.
    #
    # @example Display formatted search results
    #
    #     require 'elasticsearch6/extensions/ansi'
    #     puts Elasticsearch6::Client.new.search.to_ansi
    #
    # @example Display a table with the output of the `_analyze` API
    #
    #     require 'elasticsearch6/extensions/ansi'
    #     puts Elasticsearch6::Client.new.indices.analyze(text: 'Quick Brown Fox Jumped').to_ansi
    #
    module ANSI
    end

  end
end

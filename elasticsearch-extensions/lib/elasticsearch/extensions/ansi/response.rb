module Elasticsearch6
  module Extensions
    module ANSI

      # Wrapper for the Elasticsearch6 response body, which adds a {#to_ansi} method
      #
      class ResponseBody < DelegateClass(Hash)
        def initialize(body)
          super(body)
        end

        # Return a [colorized and formatted](http://en.wikipedia.org/wiki/ANSI_escape_code)
        # representation of the Elasticsearch6 response for:
        #
        # * Search results (hits and highlights)
        # * Facets (terms, statistical, histogram, date_histogram)
        # * Analyze API output
        # * Shard allocation
        #
        # @example Display formatted search results
        #
        #     require 'elasticsearch/extensions/ansi'
        #     puts Elasticsearch6::Client.new.search.to_ansi
        #
        # @todo Add all facets and handlers for remaining response parts / types
        #
        def to_ansi(options={})
          output = Actions.public_methods.select do |m|
            m.to_s =~ /^display_/
          end.map do |m|
            Actions.send(m, self, options)
          end

          unless output.compact.empty?
            output.compact.join("\n")
          else
            self.respond_to?(:awesome_inspect) ? self.awesome_inspect : self.inspect
          end
        end
      end

    end
  end
end

module Elasticsearch6
  module Transport
    module Transport

      class Response
        # Wrap the response body in the {Extensions::ANSI::ResponseBody} class
        #
        def body_to_ansi
          Extensions::ANSI::ResponseBody.new @body
        end

        alias_method :body_original, :body
        alias_method :body, :body_to_ansi
      end

    end
  end
end

require 'test_helper'

module Elasticsearch6
  module Test
    class WrapperGemTest < ::Test::Unit::TestCase

      context "Wrapper gem" do

        should "require all neccessary subgems" do
          assert defined? Elasticsearch6::Client
          assert defined? Elasticsearch6::API
        end

        should "mix the API into the client" do
          client = Elasticsearch6::Client.new

          assert_respond_to client, :search
          assert_respond_to client, :cluster
          assert_respond_to client, :indices
        end

      end

    end
  end
end

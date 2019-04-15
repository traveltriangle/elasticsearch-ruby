require 'test_helper'

module Elasticsearch6
  module Test
    class DSLTest < ::Elasticsearch6::Test::UnitTestCase
      context "The DSL" do
        class DummyDSLReceiver
          include Elasticsearch6::DSL
        end

        should "include the module in receiver" do
          assert_contains DummyDSLReceiver.included_modules, Elasticsearch6::DSL
          assert_contains DummyDSLReceiver.included_modules, Elasticsearch6::DSL::Search
        end
      end
    end
  end
end

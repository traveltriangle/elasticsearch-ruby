require 'test_helper'

module Elasticsearch6
  module Test
    class UtilsTest < ::Elasticsearch6::Test::UnitTestCase
      context "Utils" do
        should "convert a string to camelcase" do
          assert_equal 'Foo', Elasticsearch6::DSL::Utils.__camelize('foo')
        end

        should "convert an underscored string to camelcase" do
          assert_equal 'FooBar', Elasticsearch6::DSL::Utils.__camelize('foo_bar')
        end

        should "convert a symbol" do
          assert_equal 'FooBar', Elasticsearch6::DSL::Utils.__camelize(:foo_bar)
        end
      end
    end
  end
end

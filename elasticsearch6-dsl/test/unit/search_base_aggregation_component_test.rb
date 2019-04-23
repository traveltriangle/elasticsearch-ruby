require 'test_helper'

module Elasticsearch6
  module Test
    class BaseAggregationComponentTest < ::Elasticsearch6::Test::UnitTestCase
      context "BaseAggregationComponent" do

        class DummyAggregationComponent
          include ::Elasticsearch6::DSL::Search::BaseAggregationComponent
        end

        class ::Elasticsearch6::DSL::Search::Aggregations::Dummy
          include ::Elasticsearch6::DSL::Search::BaseAggregationComponent
        end

        subject { DummyAggregationComponent.new }

        should "return an instance of the aggregation by name" do
          assert_instance_of ::Elasticsearch6::DSL::Search::Aggregations::Dummy, subject.dummy
        end

        should "raise an exception when unknown aggregation is called" do
          assert_raise(NoMethodError) { subject.foobar }
        end

        should "add a nested aggregation" do
          subject.aggregation :inner do
            dummy field: 'foo'
          end

          assert ! subject.aggregations.empty?, "#{subject.aggregations.inspect} is empty"

          assert_instance_of Elasticsearch6::DSL::Search::Aggregation, subject.aggregations[:inner]
          assert_equal( {:dummy=>{:field=>"foo"}}, subject.aggregations[:inner].to_hash )

          assert_equal 'foo', subject.to_hash[:aggregations][:inner][:dummy][:field]
        end
      end
    end
  end
end

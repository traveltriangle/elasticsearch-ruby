require 'test_helper'

module Elasticsearch6
  module Test
    class XPackMlPutDatafeedTest < Minitest::Test

      context "XPack MachineLearning: Put datafeed" do
        subject { FakeClient.new }

        should "perform correct request" do
          subject.expects(:perform_request).with do |method, url, params, body|
            assert_equal 'PUT', method
            assert_equal "_xpack/ml/datafeeds/foo", url
            assert_equal Hash.new, params
            assert_equal Hash.new, body
            true
          end.returns(FakeResponse.new)

          subject.xpack.ml.put_datafeed :datafeed_id => 'foo', body: {}
        end

      end

    end
  end
end

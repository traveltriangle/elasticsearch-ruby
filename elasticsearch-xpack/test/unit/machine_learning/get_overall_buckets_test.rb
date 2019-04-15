require 'test_helper'

module Elasticsearch6
  module Test
    class XPackMlGetOverallBucketsTest < Minitest::Test

      context "XPack MachineLearning: Get overall buckets" do
        subject { FakeClient.new }

        should "perform correct request" do
          subject.expects(:perform_request).with do |method, url, params, body|
            assert_equal 'GET', method
            assert_equal '_xpack/ml/anomaly_detectors/foo/results/overall_buckets', url
            assert_equal Hash.new, params
            assert_equal nil, body
            true
          end.returns(FakeResponse.new)

          subject.xpack.ml.get_overall_buckets :job_id => 'foo'
        end

      end

    end
  end
end

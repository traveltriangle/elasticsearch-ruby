require 'test_helper'

module Elasticsearch6
  module Test
    class XPackMlFlushJobTest < Minitest::Test

      context "XPack MachineLearning: Flush job" do
        subject { FakeClient.new }

        should "perform correct request" do
          subject.expects(:perform_request).with do |method, url, params, body|
            assert_equal 'POST', method
            assert_equal "_xpack/ml/anomaly_detectors/foo/_flush", url
            assert_equal Hash.new, params
            assert_equal nil, body
            true
          end.returns(FakeResponse.new)

          subject.xpack.ml.flush_job :job_id => 'foo'
        end

      end

    end
  end
end

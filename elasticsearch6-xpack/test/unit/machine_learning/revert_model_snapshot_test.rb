require 'test_helper'

module Elasticsearch6
  module Test
    class XPackMlRevertModelSnapshotTest < Minitest::Test

      context "XPack MachineLearning: Revert model snapshot" do
        subject { FakeClient.new }

        should "perform correct request" do
          subject.expects(:perform_request).with do |method, url, params, body|
            assert_equal 'POST', method
            assert_equal "_xpack/ml/anomaly_detectors/foo/model_snapshots/bar/_revert", url
            assert_equal Hash.new, params
            assert_equal nil, body
            true
          end.returns(FakeResponse.new)

          subject.xpack.ml.revert_model_snapshot :job_id => 'foo', :snapshot_id => 'bar'
        end

      end

    end
  end
end

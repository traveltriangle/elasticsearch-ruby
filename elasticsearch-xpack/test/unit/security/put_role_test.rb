require 'test_helper'

module Elasticsearch6
  module Test
    class XPackSecurityPutRoleTest < Minitest::Test

      context "XPack Security: Put role" do
        subject { FakeClient.new }

        should "perform correct request" do
          subject.expects(:perform_request).with do |method, url, params, body|
            assert_equal 'PUT', method
            assert_equal '_xpack/security/role/foo', url
            assert_equal Hash.new, params
            assert_equal Hash.new, body
            true
          end.returns(FakeResponse.new)

          subject.xpack.security.put_role :name => 'foo', body: {}
        end

      end

    end
  end
end

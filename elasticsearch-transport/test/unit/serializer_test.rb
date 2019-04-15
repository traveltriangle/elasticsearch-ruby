require 'test_helper'

class Elasticsearch6::Transport::Transport::SerializerTest < Test::Unit::TestCase

  context "Serializer" do

    should "use MultiJson by default" do
      ::MultiJson.expects(:load)
      ::MultiJson.expects(:dump)
      Elasticsearch6::Transport::Transport::Serializer::MultiJson.new.load('{}')
      Elasticsearch6::Transport::Transport::Serializer::MultiJson.new.dump({})
    end

  end

end

module Elasticsearch6
  module XPack
    module API
      module MachineLearning
        module Actions; end

        class MachineLearningClient
          include Elasticsearch6::API::Common::Client, Elasticsearch6::API::Common::Client::Base, MachineLearning::Actions
        end

        def machine_learning
          @machine_learning ||= MachineLearningClient.new(self)
        end

        alias :ml :machine_learning

      end
    end
  end
end

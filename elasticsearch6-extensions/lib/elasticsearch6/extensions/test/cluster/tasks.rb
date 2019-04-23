require 'elasticsearch6/extensions/test/cluster'

namespace :elasticsearch6 do
  desc "Start Elasticsearch6 cluster for tests"
  task :start do
    Elasticsearch6::Extensions::Test::Cluster.start
  end

  desc "Stop Elasticsearch6 cluster for tests"
  task :stop do
    Elasticsearch6::Extensions::Test::Cluster.stop
  end
end

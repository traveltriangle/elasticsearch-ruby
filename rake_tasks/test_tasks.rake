UNIT_TESTED_PROJECTS = [ 'elasticsearch6',
                         'elasticsearch6-transport',
                         'elasticsearch6-dsl',
                         'elasticsearch6-api',
                         'elasticsearch6-extensions' ].freeze

INTEGRATION_TESTED_PROJECTS = (UNIT_TESTED_PROJECTS - ['elasticsearch6-api']).freeze

namespace :test do
  task :bundle => 'bundle:install'

  desc "Run all tests in all subprojects"
  task :client => [ :unit, :integration ]

  desc "Run unit tests in all subprojects"
  task :unit do
    UNIT_TESTED_PROJECTS.each do |project|
      puts '-'*80
      sh "cd #{CURRENT_PATH.join(project)} && unset BUNDLE_GEMFILE && unset BUNDLE_PATH && unset BUNDLE_BIN && bundle exec rake test:unit"
      puts "\n"
    end
  end

  desc "Run integration tests in all subprojects"
  task :integration do
    INTEGRATION_TESTED_PROJECTS.each do |project|
      puts '-'*80
      sh "cd #{CURRENT_PATH.join(project)} && unset BUNDLE_GEMFILE && bundle exec rake test:integration"
      puts "\n"
    end
  end

  desc "Run rest api tests"
  task :rest_api => 'elasticsearch6:update' do
    puts '-' * 80
    sh "cd #{CURRENT_PATH.join('elasticsearch6-api')} && unset BUNDLE_GEMFILE && bundle exec rake test:integration"
    puts "\n"
  end

  desc "Run security (Platinum) rest api yaml tests"
  task :security => 'elasticsearch6:update' do
    Rake::Task['elasticsearch6:wait_for_green'].invoke
    Rake::Task['elasticsearch6:checkout_build'].invoke
    puts '-' * 80
    sh "cd #{CURRENT_PATH.join('elasticsearch6-xpack')} && unset BUNDLE_GEMFILE && bundle exec rake test:rest_api"
    puts "\n"
  end

  namespace :cluster do
    desc "Start Elasticsearch6 nodes for tests"
    task :start do
      require 'elasticsearch6/extensions/test/cluster'
      Elasticsearch6::Extensions::Test::Cluster.start
    end

    desc "Stop Elasticsearch6 nodes for tests"
    task :stop do
      require 'elasticsearch6/extensions/test/cluster'
      Elasticsearch6::Extensions::Test::Cluster.stop
    end

    task :status do
      require 'elasticsearch6/extensions/test/cluster'
      (puts "\e[31m[!] Test cluster not running\e[0m"; exit(1)) unless Elasticsearch6::Extensions::Test::Cluster.running?
      Elasticsearch6::Extensions::Test::Cluster.__print_cluster_info(ENV['TEST_CLUSTER_PORT'] || 9250)
    end
  end
end

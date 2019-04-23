ELASTICSEARCH_PATH = "#{CURRENT_PATH}/tmp/elasticsearch6"

desc "Clone elasticsearch6 into the ./tmp directory"
task :setup do
  unless File.exist?('./tmp/elasticsearch6')
    sh "git clone https://github.com/elasticsearch6/elasticsearch6.git tmp/elasticsearch6"
  end
end

namespace :elasticsearch6 do

  desc "Wait for elasticsearch6 cluster to be in green state"
  task :wait_for_green do
    require 'elasticsearch6'

    ready = nil
    5.times do |i|
      begin
        puts "Attempting to wait for green status: #{i + 1}"
        if admin_client.cluster.health(wait_for_status: 'green', timeout: '50s')
          ready = true
          puts 'Connected to Elasticsearch6'
          break
        end
      rescue Elasticsearch6::Transport::Transport::Errors::RequestTimeout => ex
        puts "Couldn't confirm green status.\n#{ex.inspect}."
      rescue Faraday::ConnectionFailed => ex
        puts "Couldn't connect to Elasticsearch6.\n#{ex.inspect}."
        sleep(30)
      end
    end
    unless ready
      puts "Couldn't connect to Elasticsearch6, aborting program."
      exit(1)
    end
  end

  desc "Update the submodule with Elasticsearch6 core repository"
  task :update => :setup do
    sh "git --git-dir=#{CURRENT_PATH.join('tmp/elasticsearch6/.git')} --work-tree=#{CURRENT_PATH.join('tmp/elasticsearch6')} fetch origin --quiet"
    begin
      %x[git --git-dir=#{CURRENT_PATH.join('tmp/elasticsearch6/.git')} --work-tree=#{CURRENT_PATH.join('tmp/elasticsearch6')} pull]
    rescue Exception => @exception
      @failed = true
    end

    if @failed || !$?.success?
      STDERR.puts "", "[!] Error while pulling -- #{@exception}"
    end

    puts "\n", "CHANGES:", '-'*80
    sh "git --git-dir=#{CURRENT_PATH.join('tmp/elasticsearch6/.git')} --work-tree=#{CURRENT_PATH.join('tmp/elasticsearch6')} log --oneline ORIG_HEAD..HEAD | cat", :verbose => false
  end

  desc <<-DESC
    Build Elasticsearch6 for the specified branch ('origin/master' by default)"

    Build a specific branch:

        $ rake elasticsearch6:build[origin/1.x]

    The task will execute `git fetch` to synchronize remote branches.
  DESC
  task :build, :branch do |task, args|
    Rake::Task['elasticsearch6:status'].invoke
    puts '-'*80

    gitref = args[:branch] || 'origin/master'
    es_version = gitref.gsub(/^v|origin\/(\d\.+)/, '\1').to_f

    current_branch = `git --git-dir=#{CURRENT_PATH.join('tmp/elasticsearch6/.git')} --work-tree=#{CURRENT_PATH.join('tmp/elasticsearch6')} branch --no-color`.split("\n").select { |b| b =~ /^\*/ }.first.gsub(/^\*\s*/, '')

    STDOUT.puts "Building version [#{es_version}] from [#{gitref}]:", ""

    case es_version
    when 0.0, 5..1000
      path_to_build   = CURRENT_PATH.join('tmp/elasticsearch6/distribution/tar/build/distributions/elasticsearch6-*.tar.gz')
      build_command   = "cd #{CURRENT_PATH.join('tmp/elasticsearch6/distribution/tar')} && gradle clean assemble;"
      extract_command = <<-CODE.gsub(/          /, '')
          build=`ls #{path_to_build} | xargs -0 basename | sed s/\.tar\.gz//`
          if [[ $build ]]; then
            rm -rf "#{CURRENT_PATH.join('tmp/builds')}/$build";
          else
            echo "Cannot determine build, exiting..."
            exit 1
          fi
          tar xvf #{path_to_build} -C #{CURRENT_PATH.join('tmp/builds')};
      CODE
    when 1.8..4
      path_to_build   = CURRENT_PATH.join('tmp/elasticsearch6/distribution/tar/target/releases/elasticsearch6-*.tar.gz')
      build_command = "cd #{CURRENT_PATH.join('tmp/elasticsearch6')} && MAVEN_OPTS=-Xmx1g mvn --projects core,distribution/tar clean package -DskipTests -Dskip.integ.tests;"
      extract_command = <<-CODE.gsub(/          /, '')
          build=`ls #{path_to_build} | xargs -0 basename | sed s/\.tar\.gz//`
          if [[ $build ]]; then
            rm -rf "#{CURRENT_PATH.join('tmp/builds')}/$build";
          else
            echo "Cannot determine build, exiting..."
            exit 1
          fi
          tar xvf #{path_to_build} -C #{CURRENT_PATH.join('tmp/builds')};
      CODE
    when 0.1..1.7
      path_to_build   = CURRENT_PATH.join('tmp/elasticsearch6/target/releases/elasticsearch6-*.tar.gz')
      build_command = "cd #{CURRENT_PATH.join('tmp/elasticsearch6')} && MAVEN_OPTS=-Xmx1g mvn clean package -DskipTests"
      extract_command = <<-CODE.gsub(/          /, '')
          build=`ls #{path_to_build} | xargs -0 basename | sed s/\.tar\.gz//`
          if [[ $build ]]; then
            rm -rf "#{CURRENT_PATH.join('tmp/builds')}/$build";
          else
            echo "Cannot determine build, exiting..."
            exit 1
          fi
          tar xvf #{path_to_build} -C #{CURRENT_PATH.join('tmp/builds')};
      CODE
    else
      STDERR.puts "", "[!] Cannot determine a compatible version of the build (gitref: #{gitref}, es_version: #{es_version})"
      exit(1)
    end

    sh <<-CODE.gsub(/      /, '')
      mkdir -p #{CURRENT_PATH.join('tmp/builds')};
      rm -rf '#{CURRENT_PATH.join('tmp/elasticsearch6/distribution/tar/target/')}';
      cd #{CURRENT_PATH.join('tmp/elasticsearch6')} && git fetch origin --quiet;
      cd #{CURRENT_PATH.join('tmp/elasticsearch6')} && git checkout #{gitref};
      #{build_command}
    #{extract_command}
      echo; echo; echo "Built: $build"
    CODE

    puts "", '-'*80, ""
    Rake::Task['elasticsearch6:builds'].invoke
  end

  desc "Display the info for all branches in the Elasticsearch6 submodule"
  task :status do
    sh "git --git-dir=#{CURRENT_PATH.join('tmp/elasticsearch6/.git')} --work-tree=#{CURRENT_PATH.join('tmp/elasticsearch6')} branch -v -v", :verbose => false
  end

  desc "Display the list of builds"
  task :builds do
    system "mkdir -p #{CURRENT_PATH.join('tmp/builds')};"
    puts "Builds:"
    Dir.entries(CURRENT_PATH.join('tmp/builds')).reject { |f| f =~ /^\./ }.each do |build|
      puts "* #{build}"
    end
  end

  desc "Display the history of the 'rest-api-spec' repo"
  task :changes do
    STDERR.puts "Log: #{CURRENT_PATH.join('tmp/elasticsearch6')}/rest-api-spec", ""
    sh "git --git-dir=#{CURRENT_PATH.join('tmp/elasticsearch6/.git')} --work-tree=#{CURRENT_PATH.join('tmp/elasticsearch6')} log --pretty=format:'%C(yellow)%h%Creset %s \e[2m[%ar by %an]\e[0m' -- rest-api-spec", :verbose => false
  end

  desc "Checkout the build hash from the running Elasticsearch6 server"
  task :checkout_build do
    require 'elasticsearch6'

    branches = `git --git-dir=#{ELASTICSEARCH_PATH}/.git --work-tree=#{ELASTICSEARCH_PATH} branch --no-color`
    current_branch = branches.
        split("\n").
        select { |b| b =~ /^\*/ }.
        reject { |b| b =~ /no branch|detached/ }.
        map    { |b| b.gsub(/^\*\s*/, '') }.
        first

    unless current_branch
      STDERR.puts "[!] Unable to determine current branch, defaulting to 'master'"
      current_branch = 'master'
    end

    es_version_info = admin_client.info['version']
    unless build_hash = es_version_info['build_hash']
      STDERR.puts "[!] Cannot determine checkout build hash -- server not running"
      exit(1)
    end

    name = ENV['CI'] ? build_hash : "[\e[1m#{build_hash}\e[0m]"
    STDERR.puts '-'*80, "YAML tests: Switching to #{name} from #{current_branch}", '-'*80
    git_specs("checkout #{build_hash} --force --quiet")
  end
end

def git_specs(command, options={})
  sh "git --git-dir=#{ELASTICSEARCH_PATH}/.git --work-tree=#{ELASTICSEARCH_PATH} #{command}", options
end

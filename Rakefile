require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
Dir['tasks/*.rake'].each { |rakefile| load rakefile }

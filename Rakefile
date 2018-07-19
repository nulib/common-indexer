# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
Dir['tasks/*.rake'].each { |rakefile| load rakefile }

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
end

task :ci do
  Rake::Task[:rubocop].invoke
  Rake::Task[:spec].invoke
end

task default: :ci

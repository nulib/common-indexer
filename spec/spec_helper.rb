# frozen_string_literal: true

require 'bundler/setup'
require 'simplecov'
require 'coveralls'
require 'rspec'
require 'active-fedora'
require 'active_support/core_ext'
require 'rdf'

Coveralls.wear!

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
)

SimpleCov.start do
  add_filter 'spec'
  add_filter 'vendor'
end

require 'common_indexer'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

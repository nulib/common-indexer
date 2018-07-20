# frozen_string_literal: true

require 'bundler/setup'
require 'common_indexer'
require 'config'
require 'rspec'
require 'active-fedora'
require 'active_support/core_ext'
require 'rdf'

Config.load_and_set_settings(File.expand_path('../config/settings.yml', __FILE__))

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

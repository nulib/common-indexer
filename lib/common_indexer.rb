# frozen_string_literal: true

require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'elasticsearch'
require 'common_indexer/version'
require 'common_indexer/base'
require 'common_indexer/config'

module CommonIndexer # :nodoc:
  class Error < StandardError; end

  def self.client
    @client ||= Elasticsearch::Client.new(hosts: config.endpoint)
  end

  def self.index_name
    config.index_name
  end

  def self.sanitize(input)
    input.select do |key, _value|
      config.allowed_keys.include?(key.to_s)
    end
  end

  def self.config
    (@config ||= Config.new).tap { |c| yield c if block_given? }
  end
end

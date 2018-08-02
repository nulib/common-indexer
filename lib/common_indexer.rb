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

  def self.config
    (@config ||= Config.new).tap { |c| yield c if block_given? }
  end

  def self.configure_index!
    unless client.indices.exists(index: index_name)
      client.indices.create(index: index_name)
    end

    client.indices.put_mapping(
      index: index_name,
      type: '_doc',
      body: { _doc: config.schema }
    )
  end
end

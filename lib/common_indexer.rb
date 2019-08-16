# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'
require 'dry-configurable'
require 'json'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'elasticsearch'
require 'common_indexer/version'
require 'common_indexer/base'

module CommonIndexer # :nodoc:
  class Error < StandardError; end

  extend Dry::Configurable

  setting :endpoint, 'http://localhost:9200/'
  setting :index_name, 'common'
  setting :schema, JSON.parse(File.read(File.expand_path('../../config/schema.json', __FILE__)))

  class << self
    delegate :index_name, to: :config

    def client
      @client ||= Elasticsearch::Client.new(hosts: config.endpoint)
    end

    def configure_client(&block)
      @client = Elasticsearch::Client.new(hosts: config.endpoint, &block)
    end

    def configure_index!
      new_index = [index_name, Time.now.utc.strftime('%Y%m%d%H%M%S%3N')].join('_')
      client.indices.create(index: new_index)
      client.indices.put_mapping(index: new_index, type: '_doc', body: { _doc: config.schema })
      reindex_into(new_index) if client.indices.exists(index: index_name)
      client.indices.put_alias(index: new_index, name: index_name)
    end

    private

    def reindex_into(new_index)
      existing_index = client.indices.get(index: index_name).keys.first
      raise ArgumentError, "Cannot reindex #{index_name} into itself" if existing_index == new_index
      client.reindex(body: { source: { index: existing_index }, dest: { index: new_index } })
      client.indices.delete(index: existing_index)
    end
  end
end

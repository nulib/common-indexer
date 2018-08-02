# frozen_string_literal: true

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
    def client
      @client ||= Elasticsearch::Client.new(hosts: config.endpoint)
    end

    def index_name
      config.index_name
    end

    def configure_index!
      client.indices.create(index: index_name) unless client.indices.exists(index: index_name)

      client.indices.put_mapping(
        index: index_name,
        type: '_doc',
        body: { _doc: config.schema }
      )
    end
  end
end

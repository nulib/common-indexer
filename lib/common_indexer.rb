# frozen_string_literal: true

require 'elasticsearch'
require 'rails'
require 'common_indexer/engine'
require 'common_indexer/version'
require 'common_indexer/base'

module CommonIndexer # :nodoc:
  def self.client
    @client ||= Elasticsearch::Client.new(hosts: Settings.common_indexer.endpoint)
  end

  def self.index_name
    @index ||= Settings.common_indexer.index_name
  end
end

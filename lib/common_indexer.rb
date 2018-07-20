# frozen_string_literal: true

require 'elasticsearch'
require 'common_indexer/version'
require 'common_indexer/base'

module CommonIndexer # :nodoc:
  class Error < StandardError; end

  DEFAULT_KEYS = ['title'].freeze

  def self.client
    @client ||= Elasticsearch::Client.new(hosts: Settings.common_indexer.endpoint)
  end

  def self.index_name
    @index ||= Settings.common_indexer.index_name
  end

  def self.sanitize(input)
    valid_keys = Settings.common_index&.valid_keys || DEFAULT_KEYS
    input.select do |key, _value|
      valid_keys.include?(key.to_s)
    end
  end
end

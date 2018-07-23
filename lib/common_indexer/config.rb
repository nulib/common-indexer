# frozen_string_literal: true

module CommonIndexer
  DEFAULT_KEYS       = ['title'].freeze
  DEFAULT_ENDPOINT   = 'http://localhost:9200/'
  DEFAULT_INDEX_NAME = 'common'

  Config = Struct.new(:endpoint, :index_name, :allowed_keys) do
    def initialize(endpoint = DEFAULT_ENDPOINT, index_name = DEFAULT_INDEX_NAME, allowed_keys = DEFAULT_KEYS)
      super
    end
  end
end

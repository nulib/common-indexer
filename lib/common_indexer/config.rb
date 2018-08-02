# frozen_string_literal: true

module CommonIndexer
  DEFAULT_ENDPOINT   = 'http://localhost:9200/'
  DEFAULT_INDEX_NAME = 'common'
  DEFAULT_SCHEMA     = JSON.parse(File.read(File.expand_path('../../../config/schema.json', __FILE__)))

  Config = Struct.new(:endpoint, :index_name, :schema) do
    def initialize(endpoint = DEFAULT_ENDPOINT, index_name = DEFAULT_INDEX_NAME, schema = DEFAULT_SCHEMA)
      super
    end
  end
end

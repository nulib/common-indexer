# frozen_string_literal: true
require 'active_support/concern'

module CommonIndexer # :nodoc:
  module Base
    extend ActiveSupport::Concern

    included do
      after_save :update_common_index
      after_destroy :delete_document
    end

    # Override to_common_index in the including model and return a hash of common index attributes
    def to_common_index
      raise CommonIndexer::Error, "Index Error: #{self.class.name} does not implement #to_common_index!"
    end

    def delete_document
      CommonIndexer.client.delete index: CommonIndexer.index_name,
                                  id: id,
                                  type: '_doc'
    end

    def update_common_index
      begin
        CommonIndexer.client.index index: CommonIndexer.index_name,
                                   id: id,
                                   type: '_doc',
                                   body: to_common_index
      rescue Elasticsearch::Transport::Transport::Error => err
        Rails.logger.warn("Common Indexing failure: #{err.message}")
      end
    end
  end
end

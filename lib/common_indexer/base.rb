# frozen_string_literal: true
require 'active_support/concern'

module CommonIndexer # :nodoc:
  module Base
    extend ActiveSupport::Concern

    included do
      extend ActiveModel::Callbacks
      define_model_callbacks :delete_common_index, :update_common_index

      after_save :update_common_index
      after_destroy :delete_document
    end

    # Override to_common_index in the including model and return a hash of common index attributes
    def to_common_index
      raise CommonIndexer::Error, "Index Error: #{self.class.name} does not implement #to_common_index!"
    end

    def delete_document
      _run_delete_common_index_callbacks do
        CommonIndexer.client.delete index: CommonIndexer.index_name,
                                    id: id,
                                    type: '_doc'
      end
    rescue Elasticsearch::Transport::Transport::Error => err
      Rails.logger.warn("Common Index delete failure: #{err.message}")
    end

    def update_common_index
      _run_update_common_index_callbacks do
        CommonIndexer.client.index index: CommonIndexer.index_name,
                                   id: id,
                                   type: '_doc',
                                   body: to_common_index
      end
    rescue Elasticsearch::Transport::Transport::Error => err
      Rails.logger.warn("Common Indexing failure: #{err.message}")
    end
  end
end

# frozen_string_literal: true
require 'active_support/concern'

module CommonIndexer # :nodoc:
  module Base
    extend ActiveSupport::Concern

    included do
      after_save :update_common_index
    end

    # Override to_common_index in the including model and return a hash of common index attributes
    def to_common_index
      raise CommonIndexer::Error, "Index Error: #{self.class.name} does not implement #to_common_index!"
    end

    def update_common_index
      CommonIndexer.client.index index: CommonIndexer.index_name,
                                 id: id,
                                 type: self.class.name.underscore,
                                 body: CommonIndexer.sanitize(to_common_index)
    end
  end
end

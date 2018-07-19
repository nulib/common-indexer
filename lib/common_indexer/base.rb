# frozen_string_literal: true

module CommonIndexer # :nodoc:
  module Base
    extend ActiveSupport::Concern

    included do
    end

    def to_common_index
      {}
    end

    def update_common_index
      CommonIndexer.client index: CommonIndexer.index_name, id: id, type: self.class.name.underscore, body: to_common_index
    end
  end
end

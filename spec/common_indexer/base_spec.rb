# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CommonIndexer::Base do
  let(:resource) { TestModel.new }

  context 'not implemented' do
    before do
      class TestModel < ActiveFedora::Base
        include CommonIndexer::Base
      end
    end

    after do
      Object.send(:remove_const, :TestModel)
    end

    it '#to_common_index' do
      expect { resource.to_common_index }.to raise_error(CommonIndexer::Error)
    end
  end

  context 'implemented' do
    before do
      class TestModel < ActiveFedora::Base
        include CommonIndexer::Base

        property :title, predicate: ::RDF::URI('http://example.org/ns#title')
        property :description, predicate: ::RDF::URI('http://example.org/ns#description')
        property :collection, predicate: ::RDF::URI('http://example.org/ns#collection')
        property :thumbnail, predicate: ::RDF::URI('http://example.org/ns#thumbnail')
        property :poster, predicate: ::RDF::URI('http://example.org/ns#poster')
        property :resource_type, predicate: ::RDF::URI('http://example.org/ns#resource_type')

        def to_common_index
          {}
        end
      end
    end

    after do
      Object.send(:remove_const, :TestModel)
    end

    it 'includes CommonIndexer::Base' do
      expect(TestModel.ancestors).to include(described_class)
    end

    context 'common index' do
      it '#to_common_index' do
        expect(resource.to_common_index).to be_a(Hash)
      end
    end
  end
end

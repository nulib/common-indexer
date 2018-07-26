# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CommonIndexer::Base do
  let(:resource) { TestModel.new(title: ['Main Title'], description: ['Short Description']) }
  let(:index)    { resource.to_common_index }

  before do
    class TestModel < ActiveFedora::Base
      include CommonIndexer::Base

      property :title, predicate: ::RDF::URI('http://example.org/ns#title')
      property :description, predicate: ::RDF::URI('http://example.org/ns#description')
      property :collection, predicate: ::RDF::URI('http://example.org/ns#collection')
      property :thumbnail, predicate: ::RDF::URI('http://example.org/ns#thumbnail')
      property :poster, predicate: ::RDF::URI('http://example.org/ns#poster')
      property :resource_type, predicate: ::RDF::URI('http://example.org/ns#resource_type')
    end
  end

  after do
    Object.send(:remove_const, :TestModel)
  end

  it 'includes CommonIndexer::Base' do
    expect(TestModel.ancestors).to include(described_class)
  end

  context 'not implemented' do
    it '#to_common_index' do
      expect { index }.to raise_error(CommonIndexer::Error)
    end
  end

  context 'implemented' do
    before do
      class TestModel
        def to_common_index
          {
            title: title
          }
        end
      end
    end

    it '#to_common_index' do
      expect(index).to eq(title: ['Main Title'])
    end
  end
end

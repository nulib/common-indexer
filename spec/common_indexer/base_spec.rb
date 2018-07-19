# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CommonIndexer::Base do
  before do
    class CommonIndexerTest < ActiveFedora::Base
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
    Object.send(:remove_const, :CommonIndexerTest)
  end

  it 'includes CommonIndexer::Base' do
    expect(CommonIndexerTest.ancestors).to include(described_class)
  end

  context 'common index' do
    let(:resource) { CommonIndexerTest.new }

    it '#to_common_index' do
      expect(resource.to_common_index).to be_a(Hash)
    end
  end
end

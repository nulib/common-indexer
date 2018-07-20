# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CommonIndexer::Config do
  let(:config) { described_class.new }
  context 'defaults' do
    it 'sets a default endpoint' do
      expect(config.endpoint).to eq CommonIndexer::DEFAULT_ENDPOINT
    end

    it 'sets a default index name' do
      expect(config.index_name).to eq CommonIndexer::DEFAULT_INDEX_NAME
    end

    it 'sets default allowed keys' do
      expect(config.keys).to eq CommonIndexer::DEFAULT_KEYS
    end
  end
end

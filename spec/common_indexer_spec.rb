# frozen_string_literal: true

RSpec.describe CommonIndexer do
  it 'has a version number' do
    expect(CommonIndexer::VERSION).not_to be nil
  end

  it 'has a client' do
    expect(described_class.client).to be_a(Elasticsearch::Transport::Client)
  end

  it 'knows its index name' do
    expect(described_class.index_name).to eq('common')
  end

  context 'configuration' do
    it 'has a default endpoint' do
      expect(described_class.config.endpoint).to eq 'http://localhost:9200/'
    end

    it 'has a default index name' do
      expect(described_class.config.index_name).to eq 'common'
    end

    it 'has a default schema' do
      expect(described_class.config.schema).to have_key('properties')
    end
  end

  context 'client configuration' do
    let(:foo) { instance_double(Object, object_id: 0xffff) }

    it 'can be configured' do
      described_class.configure_client do |f|
        expect(f).to respond_to(:request)
        foo.object_id
      end
      expect(foo).to have_received(:object_id)
    end
  end
end

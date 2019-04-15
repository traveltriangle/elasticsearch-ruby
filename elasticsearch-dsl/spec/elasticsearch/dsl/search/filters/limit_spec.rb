require 'spec_helper'

describe Elasticsearch6::DSL::Search::Filters::Limit do

  let(:search) do
    described_class.new
  end

  describe '#to_hash' do

    it 'can be converted to a hash' do
      expect(search.to_hash).to eq(limit: {})
    end
  end

  context 'when options methods are called' do

    let(:search) do
      described_class.new(:foo)
    end

    describe '#value' do

      before do
        search.value('bar')
      end

      it 'applies the option' do
        expect(search.to_hash[:limit][:foo][:value]).to eq('bar')
      end
    end
  end

  describe '#initialize' do

    context 'when a block is provided' do

      let(:search) do
        described_class.new do
          value 'bar'
        end
      end

      it 'executes the block' do
        expect(search.to_hash).to eq(limit: { value: 'bar' })
      end
    end
  end
end

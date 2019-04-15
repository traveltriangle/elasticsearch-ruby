require 'spec_helper'

describe Elasticsearch6::DSL::Search::Queries::MatchAll do

  describe '#to_hash' do

    let(:search) do
      described_class.new
    end

    it 'can be converted to a hash' do
      expect(search.to_hash).to eq(match_all: {})
    end
  end

  context 'when options methods are called' do

    let(:search) do
      described_class.new
    end

    describe '#boost' do

      before do
        search.boost('bar')
      end

      it 'applies the option' do
        expect(search.to_hash[:match_all][:boost]).to eq('bar')
      end
    end
  end

  describe '#initialize' do

    context 'when a block is provided' do

      let(:search) do
        described_class.new do
          boost 'bar'
        end
      end

      it 'executes the block' do
        expect(search.to_hash).to eq(match_all: { boost: 'bar' })
      end
    end
  end
end

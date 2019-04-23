require 'spec_helper'

describe Elasticsearch6::DSL::Search::Queries::Terms do

  describe '#to_hash' do

    let(:search) do
      described_class.new
    end

    it 'can be converted to a hash' do
      expect(search.to_hash).to eq(terms: {})
    end
  end

  describe '#initialize' do

    context 'when a hash is provided' do

      let(:search) do
        described_class.new(foo: ['abc', 'xyz'])
      end

      it 'sets the value' do
        expect(search.to_hash[:terms]).to eq(foo: ['abc', 'xyz'])
      end
    end
  end
end
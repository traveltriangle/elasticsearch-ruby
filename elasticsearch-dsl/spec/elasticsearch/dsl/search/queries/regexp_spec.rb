require 'spec_helper'

describe Elasticsearch6::DSL::Search::Queries::Regexp do

  describe '#to_hash' do

    let(:search) do
      described_class.new
    end

    it 'can be converted to a hash' do
      expect(search.to_hash).to eq(regexp: {})
    end
  end

  context 'when options methods are called' do

    let(:search) do
      described_class.new
    end

    [ 'value',
      'boost',
      'flags'].each do |option|

      describe "##{option}" do

        before do
          search.send(option, 'bar')
        end

        it 'applies the option' do
          expect(search.to_hash[:regexp][option.to_sym]).to eq('bar')
        end
      end
    end
  end

  describe '#initialize' do

    context 'when a hash is provided' do

      let(:search) do
        described_class.new(foo: 'b.*r')
      end

      it 'sets the value' do
        expect(search.to_hash[:regexp][:foo]).to eq('b.*r')
      end
    end

    context 'when a block is provided' do

      let(:search) do
        described_class.new(:foo) do
          value 'bar'
        end
      end

      it 'executes the block' do
        expect(search.to_hash[:regexp][:foo][:value]).to eq('bar')
      end
    end
  end
end

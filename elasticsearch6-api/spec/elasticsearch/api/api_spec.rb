require 'spec_helper'

describe Elasticsearch6::API do

  describe '#settings' do

    it 'allows access to settings' do
      expect(described_class.settings).not_to be_nil
    end

    it 'has a default serializer' do
      expect(Elasticsearch6::API.serializer).to eq(MultiJson)
    end

    context 'when settings are changed' do

      before do
        Elasticsearch6::API.settings[:foo] = 'bar'
      end

      it 'changes the settings' do
        expect(Elasticsearch6::API.settings[:foo]).to eq('bar')
      end
    end
  end
end

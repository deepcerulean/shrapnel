require 'spec_helper'
require 'shrapnel/core/lexer'

describe Shrapnel::Core::Lexer do
  subject(:lexer) { described_class.new(test_string) }

  context 'pattern matching' do
    describe 'numeric literals' do
      let(:test_string) { '12345' }
      it 'finds 12345' do
        expect(lexer.peek).to eq(num: '12345')
        expect(lexer.consume).to eq(num: '12345')
        expect(lexer.consume).to be_nil
      end
    end

    describe 'alphabetic identifiers' do
      let(:test_string) { 'speed' }
      it 'finds speed' do
        expect(lexer.peek).to eq(id: 'speed')
        expect(lexer.consume).to eq(id: 'speed')
      end
    end

    describe 'arithmetical operators' do
      context '*' do
        let(:test_string) { '*' }
        it 'finds times' do
          expect(lexer.peek).to eq(op: '*')
          expect(lexer.consume).to eq(op: '*')
        end
      end
    end

    describe 'whitespace' do
      context 'is ignored' do
        let(:test_string) { ' ' }
        it 'does not find space' do
          expect(lexer.peek).to eq space: ' '
          expect(lexer.consume).to eq space: ' '
        end
      end
    end
  end

  context 'instance methods' do
    describe 'consume' do
      let(:test_string) { '123+ abc' }
      it 'hard-scans for successive matches' do
        expect(lexer.consume).to eq num: '123'
        expect(lexer.consume).to eq op: '+'
        expect(lexer.consume).to eq space: ' '
        expect(lexer.consume).to eq id: 'abc'
        expect(lexer.consume).to be_nil
      end
    end
  end
end

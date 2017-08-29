require 'spec_helper'
require 'shrapnel/core/lexer'
require 'shrapnel/core/parser'

describe Shrapnel::Core::Parser do
  subject(:parser) do
    described_class.new(lexer)
  end

  context 'parsing simple values' do
    let(:lexer) do
      instance_double(Shrapnel::Core::Lexer,
                      peek: next_sym,
                      consume: next_sym)
    end

    describe 'number literal' do
      let(:next_sym) { { num: '123' } }
      it 'builds a value node' do
        expect(parser.tree).to eq(123)
      end
    end

    describe 'id literal' do
      let(:next_sym) { { id: 'abc' } }
      it 'builds an id node' do
        expect(parser.tree).to eq(:abc)
      end
    end
  end

  context 'parsing arithmetic expressions' do
    let(:lexer) do
      Shrapnel::Core::Lexer.new(input_string)
    end

    describe '1+2' do
      let(:input_string) { "1+2" }
      it 'parses' do
        expect(parser.tree).to eq(['+', 1, 2])
      end
    end

    describe '3*4' do
      let(:input_string) { "3*4" }
      it 'parses' do
        expect(parser.tree).to eq(['*', 3, 4])
      end
    end

    describe '1+2*3' do
      let(:input_string) { '1+2*3' }
      it 'parses' do
        expect(parser.tree).to eq(['+', 1, ['*', 2, 3]])
      end
    end

    describe '4-6/3+1' do
      let(:input_string) { '4-6/3+1' }
      it 'parses' do
        expect(parser.tree).to eq(
          ['+',
           ['-', 4,
            ['/', 6,3]
           ],
          1]
        )
      end
    end
  end
end

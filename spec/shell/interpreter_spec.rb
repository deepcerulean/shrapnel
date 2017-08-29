require 'spec_helper'
require 'shrapnel'

describe Shrapnel::Shell::Interpreter do
  context 'collaboration' do
    subject(:interpreter) do
      described_class.new(lexing_engine: lexer_class, parsing_engine: parser_class)
    end

    let(:lexer_class) { class_double(Shrapnel::Core::Lexer, new: lexer) }
    let(:parser_class) { class_double(Shrapnel::Core::Parser, new: parser) }
    let(:lexer) { instance_double(Shrapnel::Core::Lexer) }
    let(:parser) { instance_double(Shrapnel::Core::Parser) }

    it 'evalutes a statement' do
      expect(lexer_class).to receive(:new).with('hello shrapnel')
      expect(parser_class).to receive(:new).with(lexer)

      ast = [ :a, [ :fake, :tree ]]
      expect(parser).to receive(:tree) { ast }

      expect(interpreter).to receive(:reduce).with(ast) { 'hello user' }

      response = interpreter.evaluate('hello shrapnel')
      expect(response).to eq('hello user')
    end
  end

  context 'evaluation' do
    subject(:interpreter) do
      described_class.new
    end

    it 'evaluate a string' do
      expect(interpreter.evaluate('1+2')).to eq(3)
      expect(interpreter.evaluate('2+4*5')).to eq(22)
    end
  end
end

require 'spec_helper'
require 'shrapnel'

describe Shrapnel do
  it "should have a VERSION constant" do
    expect(subject.const_get('VERSION')).to_not be_empty
  end
end

describe Shrapnel::VM do
  subject(:vm) { described_class.new }

  let(:repl)       { instance_double(Shrapnel::Shell::Repl) }
  let(:repl_class) { class_double(Shrapnel::Shell::Repl, new: repl) }

  let(:interpreter)       { instance_double(Shrapnel::Shell::Interpreter) }
  let(:interpreter_class) { class_double(Shrapnel::Shell::Interpreter, new: interpreter) }

  before do
    vm.setup_shrapnel interpreter_engine: interpreter_class
    vm.repl provider: repl_class
  end


  it 'boots a repl' do
    expect(repl).to receive(:interact!).with(interpreter: interpreter)
    vm.repl!
  end
end



require 'shrapnel/version'
require 'shrapnel/core'
require 'shrapnel/shell'
require 'readline'

module Shrapnel
  class VM
    def initialize
      setup_shrapnel(
        interpreter_engine: Shell::Interpreter
      )
    end

    def setup_shrapnel(interpreter_engine:)
      @interpreter = interpreter_engine.new
    end

    def repl!
      repl.interact!(interpreter: @interpreter)
    end

    def repl(provider: Shell::Repl)
      @repl ||= provider.new
    end
  end
end

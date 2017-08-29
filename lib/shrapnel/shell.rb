module Shrapnel
  module Shell
    class Interpreter
      def initialize(lexing_engine: Core::Lexer, parsing_engine: Core::Parser)
        @lexing_engine = lexing_engine
        @parsing_engine = parsing_engine
      end

      def evaluate(str)
        lexer = @lexing_engine.new(str)
        parser = @parsing_engine.new(lexer)
        ast = parser.tree
        reduce(ast)
      end

      def reduce(ast)
        op,left,right=ast
        if left && right
          left=reduce(left)
          right=reduce(right)
          perform_binary op, left, right
        elsif left # unary op?
          raise "Unknown unary op #{op}"
        else # nonary op [ a value or id ]
          op
        end
      end

      private
      def perform_binary(op,left,right)
        case op
        when '+' then left+right
        when '-' then left-right
        when '*' then left*right
        when '/' then left/right
        else raise "Unknown binary op #{op}"
        end
      end
    end

    class Repl
      def interact!(interpreter:)
        while buf = Readline.readline("> ", true)
          print("-> ", interpreter.evaluate(buf), "\n")
        end
      end
    end
  end
end

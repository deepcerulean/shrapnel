module Shrapnel
  module Core
    class Parser
      def initialize(lexer)
        @lexer = lexer
      end

      def tree
        @ast = expression
      end

      def expression
        tree = term
        while check && check.has_key?(:op) && (check[:op] == '+' || check[:op] == '-')

          tree = [ accept[:op], tree, term ]
        end
        tree
      end

      def term
        tree = factor
        while check && check.has_key?(:op) && (check[:op] == '/' || check[:op] == '*')
          tree = [ accept[:op], tree, factor ]
        end
        tree
      end

      def factor
        value
      end

      def value
        return unless check
        if check.has_key?(:num)
          accept[:num].to_i
        elsif check.has_key?(:id)
          accept[:id].to_sym
        end
      end

      private
      def check
        @lexer.peek
      end

      def accept
        @lexer.consume
      end
    end
  end
end

require 'strscan'
module Shrapnel
  module Core
    class Lexer
      def initialize(str)
        @input_string = str.gsub(' ', '')
        @scanner = StringScanner.new(@input_string)
      end

      def peek
        match
      end

      def consume
        match(scan_method: @scanner.method(:scan))
      end

      protected
      def match(scan_method: @scanner.method(:match?))
        patterns.each do |type, pattern|
          if scan_method.call(pattern)
            return { type => @scanner.matched } unless ignored?(pattern)
          end
        end
        nil
      end

      def patterns
        {
          # :space => /\s+/,
          :num => /\d+/,
          :id  => /\w+/,
          :op  => /[+-\/*]/,
          # :parens => /\(\)/,
        }
      end

      def ignored?(pat)
        pat == :space
      end

      # def ignored_patterns
      #   {
      #   }
      # end
    end
  end
end

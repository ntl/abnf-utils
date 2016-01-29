module ABNF
  module Controls
    module TokenStreams
      def self.example(*tokens, element: nil)
        tokens = [Terminal.example] if tokens.empty?
        element ||= Elements.example

        tokens = [Tokens.rulename, Tokens.assignment, *tokens, Tokens.newline]

        return tokens, element
      end

      def self.alternation
        strings = Values.alternation.first 2

        tokens = [
          Tokens::Terminal.char_val(strings[0]),
          Tokens.alternative_delimiter,
          Tokens::Terminal.char_val(strings[1]),
        ]

        elements = strings.map do |string|
          Elements::Terminal.char_val string
        end

        element = Elements.alternation elements

        example *tokens, element: element
      end

      def self.concatenation
        strings = Values.concatenation.first 2

        tokens = [
          Tokens::Terminal.char_val(strings[0]),
          Tokens.whitespace,
          Tokens::Terminal.char_val(strings[1]),
        ]

        elements = strings.map do |string|
          Elements::Terminal.char_val string
        end
        element = Elements.concatenation elements

        example *tokens, element: element
      end

      def self.group
        tokens = [Tokens.group_start, Tokens::Terminal.example, Tokens.group_stop]

        terminal_element = Controls::Elements::Terminal.example
        element = Controls::Elements.group terminal_element

        example *tokens, element: element
      end

      def self.option
        tokens = [Tokens.option_start, Terminal.char_val, Tokens.option_stop]

        terminal_element = Controls::Elements::Terminal.char_val
        element = Controls::Elements.optional terminal_element

        example *tokens, element: element
      end

      def self.reference rulename=nil
        rulename ||= Values.rulename

        token = Tokens.rulename rulename
        element = Controls::Elements.reference rulename

        example token, element: element
      end

      module Repetition
        def self.any_number
          tokens = [Tokens::Repeat.any_number, Tokens::Terminal.example]

          terminal_element = Controls::Elements::Terminal.example
          element = Controls::Elements::Repetition.any_number terminal_element

          TokenStreams.example *tokens, element: element
        end

        def self.fixed
          tokens = [Tokens::Repeat.fixed, Tokens::Terminal.example]

          terminal_element = Elements::Terminal.example
          element = Elements::Repetition.fixed terminal_element

          TokenStreams.example *tokens, element: element
        end

        def self.bounded_range
          tokens = [Tokens::Repeat.bounded_range, Tokens::Terminal.example]

          terminal_element = Elements::Terminal.example
          element = Elements::Repetition.bounded_range terminal_element

          TokenStreams.example *tokens, element: element
        end
      end
    end
  end
end

module ABNF
  module Controls
    module Tokens
      module Scenarios
        def self.example(*tokens, element: nil)
          tokens = [Terminal.example] if tokens.empty?
          element ||= Elements.example

          tokens = [Tokens.rulename, Tokens.assignment, *tokens, Tokens.newline]

          return tokens, element
        end

        def self.alternation
          strings = Values.alternation.first 2

          tokens = [
            Terminal.char_val(strings[0]),
            Tokens.alternative_delimiter,
            Terminal.char_val(strings[1]),
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
            Terminal.char_val(strings[0]),
            Tokens.whitespace,
            Terminal.char_val(strings[1]),
          ]

          elements = strings.map do |string|
            Elements::Terminal.char_val string
          end
          element = Elements.concatenation elements

          example *tokens, element: element
        end

        def self.group
          tokens = [Tokens.group_start, Terminal.example, Tokens.group_stop]

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

        module Repetition
          def self.any_number
            tokens = [Repeat.any_number, Terminal.example]

            terminal_element = Controls::Elements::Terminal.example
            element = Controls::Elements::Repetition.any_number terminal_element

            Scenarios.example *tokens, element: element
          end

          def self.fixed
            tokens = [Repeat.fixed, Terminal.example]

            terminal_element = Elements::Terminal.example
            element = Elements::Repetition.fixed terminal_element

            Scenarios.example *tokens, element: element
          end

          def self.bounded_range
            tokens = [Repeat.bounded_range, Terminal.example]

            terminal_element = Elements::Terminal.example
            element = Elements::Repetition.bounded_range terminal_element

            Scenarios.example *tokens, element: element
          end
        end
      end
    end
  end
end

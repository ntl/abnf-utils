module ABNF
  module Controls
    module TokenStreams
      def self.example(*tokens, node: nil)
        tokens = [Terminal.example] if tokens.empty?
        node ||= Nodes.example

        tokens = [Tokens.rulename, Tokens.assignment, *tokens, Tokens.newline]

        return tokens, node
      end

      def self.alternation
        strings = Values.alternation.first 2

        tokens = [
          Tokens::Terminal.char_val(strings[0]),
          Tokens.alternative_delimiter,
          Tokens::Terminal.char_val(strings[1]),
        ]

        nodes = strings.map do |string|
          Nodes::Terminal.char_val string
        end

        node = Nodes.alternation nodes

        example *tokens, node: node
      end

      def self.concatenation
        strings = Values.concatenation.first 2

        tokens = [
          Tokens::Terminal.char_val(strings[0]),
          Tokens.whitespace,
          Tokens::Terminal.char_val(strings[1]),
        ]

        nodes = strings.map do |string|
          Nodes::Terminal.char_val string
        end
        node = Nodes.concatenation nodes

        example *tokens, node: node
      end

      def self.group
        tokens = [Tokens.group_start, Tokens::Terminal.example, Tokens.group_stop]

        terminal_node = Controls::Nodes::Terminal.example
        node = Controls::Nodes.group terminal_node

        example *tokens, node: node
      end

      def self.option
        tokens = [Tokens.option_start, Terminal.char_val, Tokens.option_stop]

        terminal_node = Controls::Nodes::Terminal.char_val
        node = Controls::Nodes.optional terminal_node

        example *tokens, node: node
      end

      def self.reference rulename=nil
        rulename ||= Values.rulename

        token = Tokens.rulename rulename
        node = Controls::Nodes.reference rulename

        example token, node: node
      end

      module Repetition
        def self.any_number
          tokens = [Tokens::Repeat.any_number, Tokens::Terminal.example]

          terminal_node = Controls::Nodes::Terminal.example
          node = Controls::Nodes::Repetition.any_number terminal_node

          TokenStreams.example *tokens, node: node
        end

        def self.fixed
          tokens = [Tokens::Repeat.fixed, Tokens::Terminal.example]

          terminal_node = Nodes::Terminal.example
          node = Nodes::Repetition.fixed terminal_node

          TokenStreams.example *tokens, node: node
        end

        def self.bounded_range
          tokens = [Tokens::Repeat.bounded_range, Tokens::Terminal.example]

          terminal_node = Nodes::Terminal.example
          node = Nodes::Repetition.bounded_range terminal_node

          TokenStreams.example *tokens, node: node
        end
      end
    end
  end
end

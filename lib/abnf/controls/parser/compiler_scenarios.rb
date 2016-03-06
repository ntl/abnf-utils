module ABNF
  module Controls
    module Parser
      module CompilerScenarios
        def self.example
          tokens = [Terminal.example]
          node = Nodes.example

          Factory.(tokens, node)
        end

        def self.alternation
          strings = Values.alternation.first 2

          tokens = [
            Tokens.char_val(strings[0]),
            Tokens.alternative_delimiter,
            Tokens.char_val(strings[1]),
          ]

          nodes = strings.map do |string|
            AST::Nodes::Terminal.char_val string
          end

          node = AST::Nodes.alternation nodes

          Factory.(tokens, node)
        end

        def self.concatenation
          strings = Values.concatenation.first 2

          tokens = [
            Tokens.char_val(strings[0]),
            Tokens.whitespace,
            Tokens.char_val(strings[1]),
          ]

          nodes = strings.map do |string|
            AST::Nodes::Terminal.char_val string
          end
          node = AST::Nodes.concatenation nodes

          Factory.(tokens, node)
        end

        def self.group
          tokens = [Tokens.group_start, Tokens.char_val, Tokens.group_stop]

          terminal_node = AST::Nodes::Terminal.example
          node = AST::Nodes.group terminal_node

          Factory.(tokens, node)
        end

        def self.option
          tokens = [Tokens.option_start, Terminal.char_val, Tokens.option_stop]

          terminal_node = AST::Nodes::Terminal.char_val
          node = AST::Nodes.optional terminal_node

          Factory.(tokens, node)
        end

        def self.reference rulename=nil
          rulename ||= Values.rulename

          tokens = [Tokens.rulename(rulename)]
          node = AST::Nodes.reference rulename

          Factory.(tokens, node)
        end
      end
    end
  end
end

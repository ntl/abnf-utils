module ABNF
  module Controls
    module Parser
      module CompilerScenarios
        module Repetition
          def self.any_number
            tokens = [Tokens::Repeat.any_number, Tokens.char_val]

            terminal_node = Controls::AST::Nodes::Terminal.example
            node = Controls::AST::Nodes::Repetition.any_number terminal_node

            Factory.(tokens, node)
          end

          def self.fixed
            tokens = [Tokens::Repeat.fixed, Tokens.char_val]

            terminal_node = AST::Nodes::Terminal.example
            node = AST::Nodes::Repetition.fixed terminal_node

            Factory.(tokens, node)
          end

          def self.bounded_range
            tokens = [Tokens::Repeat.bounded_range, Tokens.char_val]

            terminal_node = AST::Nodes::Terminal.example
            node = AST::Nodes::Repetition.bounded_range terminal_node

            Factory.(tokens, node)
          end
        end
      end
    end
  end
end

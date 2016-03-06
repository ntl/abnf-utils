module ABNF
  module Controls
    module Parser
      module CompilerScenarios
        module Repetition
          def self.any_number
            tokens = [Tokens::Repeat.any_number, Tokens.char_val]
            node = AST::Nodes::Repetition.any_number

            Factory.(tokens, node)
          end

          def self.bounded_range
            tokens = [Tokens::Repeat.bounded_range, Tokens.char_val]
            node = AST::Nodes::Repetition.bounded_range

            Factory.(tokens, node)
          end

          def self.fixed
            tokens = [Tokens::Repeat.fixed, Tokens.char_val]
            node = AST::Nodes::Repetition.fixed

            Factory.(tokens, node)
          end
        end
      end
    end
  end
end

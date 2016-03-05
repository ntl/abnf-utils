module ABNF
  module Controls
    module Parser
      module CompilerScenarios
        module Factory
          def self.call tokens, node
            rule = [
              Tokens.rulename,
              Tokens.assignment,
              *tokens,
              Tokens.newline,
            ]

            return rule, node
          end
        end
      end
    end
  end
end

module ABNF
  module Controls
    module Parser
      module CompilerScenarios
        module Terminal
          def self.char_val
            token = Tokens.char_val
            expected_node = AST::Nodes::Terminal.char_val

            Factory.([token], expected_node)
          end

          def self.num_val
            NumVal.example
          end

          def self.prose_val
            token = Tokens.prose_val
            expected_node = AST::Nodes::Terminal.prose_val

            Factory.([token], expected_node)
          end

          module NumVal
            def self.example base=nil, variant=nil
              base ||= 'HexVal'
              variant ||= 'Sequence'

              method_name = variant.downcase

              token = Tokens::NumVal.example base, variant
              expected_node = AST::Nodes::Terminal::NumVal.get base, variant

              Factory.([token], expected_node)
            end
          end
        end
      end
    end
  end
end

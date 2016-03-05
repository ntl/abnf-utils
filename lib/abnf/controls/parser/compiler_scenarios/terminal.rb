module ABNF
  module Controls
    module Parser
      module CompilerScenarios
        module Terminal
          def self.char_val
            token = Tokens::Terminal.char_val
            expected_node = AST::Nodes::Terminal.char_val

            Factory.([token], expected_node)
          end

          def self.num_val
            NumVal.example
          end

          def self.prose_val
            token = Tokens::Terminal.prose_val
            expected_node = AST::Nodes::Terminal.prose_val

            Factory.([token], expected_node)
          end

          module NumVal
            def self.example base=nil, variant=nil
              base ||= 'HexVal'
              variant ||= 'Sequence'

              method_name = variant.downcase

              token = Tokens::Terminal::NumVal.get base, method_name
              expected_node = AST::Nodes::Terminal::NumVal.get base, method_name

              Factory.([token], expected_node)
            end
          end
        end
      end
    end
  end
end

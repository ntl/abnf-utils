module ABNF
  module Controls
    module Parser
      module CompilerScenarios
        def self.alternation
          first_string, second_string = Values.alternation

          tokens = [
            Tokens.char_val(first_string),
            Tokens.alternative_delimiter,
            Tokens.char_val(second_string),
          ]

          Factory.(tokens, AST::Nodes.alternation)
        end

        def self.char_val
          token = Tokens.char_val
          expected_node = AST::Nodes.char_val

          Factory.([token], expected_node)
        end

        def self.concatenation
          first_string, second_string = Values.concatenation

          tokens = [
            Tokens.char_val(first_string),
            Tokens.whitespace,
            Tokens.char_val(second_string),
          ]

          Factory.(tokens, AST::Nodes.concatenation)
        end

        def self.group
          tokens = [Tokens.group_start, Tokens.char_val, Tokens.group_stop]
          node = AST::Nodes.group

          Factory.(tokens, node)
        end

        def self.num_val base=nil, variant=nil
          token = Tokens::NumVal.example base, variant
          expected_node = AST::Nodes::NumVal.example base, variant

          Factory.([token], expected_node)
        end

        def self.option
          tokens = [Tokens.option_start, Tokens.char_val, Tokens.option_stop]
          node = AST::Nodes.option

          Factory.(tokens, node)
        end

        def self.prose_val
          token = Tokens.prose_val
          expected_node = AST::Nodes.prose_val

          Factory.([token], expected_node)
        end

        def self.reference
          tokens = [Tokens.rulename]
          node = AST::Nodes.reference

          Factory.(tokens, node)
        end
      end
    end
  end
end

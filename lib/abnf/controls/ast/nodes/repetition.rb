module ABNF
  module Controls
    module AST
      module Nodes
        module Repetition
          def self.example
            any_number
          end

          def self.any_number
            char_val = Nodes.char_val

            abnf = "#{Source::Repeat.any_number}#{char_val.abnf}"
            range = Values::Repetition.any_number

            ABNF::Parser::Node::Repetition.new abnf, range, char_val
          end

          def self.fixed
            char_val = Nodes.char_val

            abnf = "#{Source::Repeat.fixed}#{char_val.abnf}"
            range = Values::Repetition.fixed

            ABNF::Parser::Node::Repetition.new abnf, range, char_val
          end

          def self.bounded_range
            char_val = Nodes.char_val

            abnf = "#{Source::Repeat.bounded_range}#{char_val.abnf}"
            range = Values::Repetition.bounded_range

            ABNF::Parser::Node::Repetition.new abnf, range, char_val
          end
        end
      end
    end
  end
end

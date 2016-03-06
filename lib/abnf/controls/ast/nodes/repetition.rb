module ABNF
  module Controls
    module AST
      module Nodes
        module Repetition
          def self.example
            any_number
          end

          def self.any_number element=nil
            element ||= Terminal.char_val

            abnf = "#{Source::Repeat.any_number}#{element.abnf}"
            range = Values::Repetition.any_number

            ::ABNF::Parser::Node::Repetition.new abnf, range, element
          end

          def self.fixed element=nil
            element ||= Terminal.char_val

            abnf = "#{Source::Repeat.fixed}#{element.abnf}"
            count = Values::Repetition.fixed
            range = (count..count)

            ::ABNF::Parser::Node::Repetition.new abnf, range, element
          end

          def self.bounded_range element=nil
            element ||= Terminal.char_val

            abnf = "#{Source::Repeat.bounded_range}#{element.abnf}"
            range = Values::Repetition.bounded_range

            ::ABNF::Parser::Node::Repetition.new abnf, range, element
          end
        end
      end
    end
  end
end

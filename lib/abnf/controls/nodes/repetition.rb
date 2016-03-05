module ABNF
  module Controls
    module Nodes
      module Repetition
        def self.example
          any_number
        end

        def self.any_number element=nil
          element ||= Terminal.char_val

          abnf = "#{Controls::ABNF::Repeat.any_number}#{element.abnf}"
          range = Values::Repetition.any_number

          Parser::Node::Repetition.new abnf, range, element
        end

        def self.fixed element=nil
          element ||= Terminal.char_val

          abnf = "#{Controls::ABNF::Repeat.fixed}#{element.abnf}"
          count = Values::Repetition.fixed
          range = (count..count)

          Parser::Node::Repetition.new abnf, range, element
        end

        def self.bounded_range element=nil
          element ||= Terminal.char_val

          abnf = "#{Controls::ABNF::Repeat.bounded_range}#{element.abnf}"
          range = Values::Repetition.bounded_range

          Parser::Node::Repetition.new abnf, range, element
        end
      end
    end
  end
end

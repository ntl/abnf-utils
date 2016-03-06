module ABNF
  module Controls
    module AST
      module Nodes
        def self.example
          Terminal.example
        end

        def self.alternation elements=nil
          abnf = String.new

          elements ||= Values.alternation.map do |string|
            Terminal.char_val string
          end

          delimiter = Source.alternative_delimiter
          abnf = elements.map(&:abnf) * delimiter

          ::ABNF::Parser::Node::Alternation.new abnf, elements
        end

        def self.concatenation elements=nil
          abnf = String.new

          elements ||= Values.concatenation.map do |string|
            Terminal.char_val string
          end

          whitespace = Source.whitespace
          abnf = elements.map(&:abnf) * whitespace

          ::ABNF::Parser::Node::Concatenation.new abnf, elements
        end

        def self.group element=nil
          element ||= Terminal.char_val

          abnf = [
            Source.group_start,
            element.abnf,
            Source.group_stop,
          ].join

          element.abnf = abnf
          element
        end

        def self.optional element=nil
          element ||= Terminal.char_val

          abnf = [
            Source.option_start,
            element.abnf,
            Source.option_stop,
          ].join

          range = (0..1)

          ::ABNF::Parser::Node::Repetition.new abnf, range, element
        end

        def self.reference rulename=nil
          rulename ||= Values.rulename
          ::ABNF::Parser::Node::Reference.new rulename
        end
      end
    end
  end
end

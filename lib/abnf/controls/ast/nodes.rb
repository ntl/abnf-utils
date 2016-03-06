module ABNF
  module Controls
    module AST
      module Nodes
        def self.example
          char_val
        end

        def self.alternation
          abnf = String.new
          alternatives = []

          Values.alternation.each do |string|
            alternative = char_val string

            abnf << Source.alternative_delimiter unless abnf.empty?
            abnf << alternative.abnf
            alternatives << alternative
          end

          ABNF::Parser::Node::Alternation.new abnf, alternatives
        end

        def self.char_val character_sequence=nil
          character_sequence ||= Controls::Values.character_sequence
          abnf = Source.char_val character_sequence

          ABNF::Parser::Node::Terminal::Sequence.new abnf, character_sequence
        end

        def self.concatenation
          abnf = String.new
          repetitions = []

          Values.concatenation.each do |string|
            repetition = char_val string

            abnf << Source.whitespace unless abnf.empty?
            abnf << repetition.abnf
            repetitions << repetition
          end

          ABNF::Parser::Node::Concatenation.new abnf, repetitions
        end

        def self.group
          element = char_val

          abnf = [
            Source.group_start,
            element.abnf,
            Source.group_stop,
          ].join

          element.abnf = abnf
          element
        end

        def self.num_val
          NumVal.example
        end

        def self.option
          element = char_val

          abnf = [
            Source.option_start,
            element.abnf,
            Source.option_stop,
          ].join

          range = (0..1)

          ABNF::Parser::Node::Repetition.new abnf, range, element
        end

        def self.prose_val
          prose = Values.prose

          ABNF::Parser::Node::Terminal::ProseVal.new prose
        end

        def self.reference
          rulename = Values.rulename

          ABNF::Parser::Node::Reference.new rulename
        end
      end
    end
  end
end

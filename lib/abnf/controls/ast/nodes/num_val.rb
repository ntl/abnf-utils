module ABNF
  module Controls
    module AST
      module Nodes
        module NumVal
          def self.example base=nil, variant=nil
            base ||= 16
            variant ||= 'sequence'

            public_send variant, base
          end

          def self.range base=nil
            base ||= 16

            character_range = Values.character_range
            abnf = Source::NumVal.range base

            ABNF::Parser::Node::Terminal::Range.new abnf, character_range
          end

          def self.sequence base=nil
            base ||= 16

            character_sequence = Values.character_sequence
            abnf = Source::NumVal.sequence base

            ABNF::Parser::Node::Terminal::Sequence.new abnf, character_sequence
          end

          def self.single base=nil
            base ||= 16

            character = Values.single_character
            abnf = Source::NumVal.single base

            ABNF::Parser::Node::Terminal::Sequence.new abnf, character
          end
        end
      end
    end
  end
end

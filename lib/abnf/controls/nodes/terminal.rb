module ABNF
  module Controls
    module Nodes
      module Terminal
        def self.example
          char_val
        end

        def self.char_val character_sequence=nil
          character_sequence ||= Controls::Values::Terminal.character_sequence
          abnf = Controls::ABNF::Terminal.char_val character_sequence
          Parser::Node::Terminal::Sequence.new abnf, character_sequence
        end

        def self.prose_val prose=nil
          prose ||= Values::Terminal.prose
          Parser::Node::Terminal::ProseVal.new prose
        end

        module NumVal
          def self.get base, method_name
            mod = const_get base
            mod.public_send method_name
          end

          module BinVal
            def self.range character_range=nil
              character_range ||= Values::Terminal.character_range
              abnf = ABNF::Terminal::NumVal::BinVal.range character_range
              Parser::Node::Terminal::Range.new abnf, character_range
            end

            def self.sequence character_sequence=nil
              character_sequence ||= Values::Terminal.character_sequence
              abnf = ABNF::Terminal::NumVal::BinVal.sequence character_sequence
              Parser::Node::Terminal::Sequence.new abnf, character_sequence
            end

            def self.single character=nil
              character ||= Values::Terminal.single_character
              abnf = ABNF::Terminal::NumVal::BinVal.single character
              Parser::Node::Terminal::Sequence.new abnf, character
            end
          end

          module DecVal
            def self.range character_range=nil
              character_range ||= Values::Terminal.character_range
              abnf = ABNF::Terminal::NumVal::DecVal.range character_range
              Parser::Node::Terminal::Range.new abnf, character_range
            end

            def self.sequence character_sequence=nil
              character_sequence ||= Values::Terminal.character_sequence
              abnf = ABNF::Terminal::NumVal::DecVal.sequence character_sequence
              Parser::Node::Terminal::Sequence.new abnf, character_sequence
            end

            def self.single character=nil
              character ||= Values::Terminal.single_character
              abnf = ABNF::Terminal::NumVal::DecVal.single character
              Parser::Node::Terminal::Sequence.new abnf, character
            end
          end

          module HexVal
            def self.range character_range=nil
              character_range ||= Values::Terminal.character_range
              abnf = ABNF::Terminal::NumVal::HexVal.range character_range
              Parser::Node::Terminal::Range.new abnf, character_range
            end

            def self.sequence character_sequence=nil
              character_sequence ||= Values::Terminal.character_sequence
              abnf = ABNF::Terminal::NumVal::HexVal.sequence character_sequence
              Parser::Node::Terminal::Sequence.new abnf, character_sequence
            end

            def self.single character=nil
              character ||= Values::Terminal.single_character
              abnf = ABNF::Terminal::NumVal::HexVal.single character
              Parser::Node::Terminal::Sequence.new abnf, character
            end
          end
        end
      end
    end
  end
end

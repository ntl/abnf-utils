module ABNF
  module Controls
    module Tokens
      module Terminal
        def self.example
          char_val
        end

        def self.char_val character_sequence=nil
          character_sequence ||= Values::Terminal.character_sequence
          abnf = Controls::ABNF::Terminal.char_val character_sequence

          Parser::Tokens::CharVal.new abnf, 'characters' => character_sequence
        end

        def self.prose_val prose=nil
          prose ||= Values::Terminal.prose
          abnf = Controls::ABNF::Terminal.prose_val prose

          Parser::Tokens::ProseVal.new abnf, 'prose' => prose
        end

        module NumVal
          def self.example
            HexVal.sequence
          end

          module BinVal
            def self.range character_range=nil
              character_range ||= Values::Terminal.character_range
              abnf = Controls::ABNF::Terminal::NumVal::BinVal.range character_range

              characters = NumVal.extract_characters abnf

              Parser::Tokens::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end

            def self.sequence character_sequence=nil
              character_sequence ||= Values::Terminal.character_sequence
              abnf = Controls::ABNF::Terminal::NumVal::BinVal.sequence character_sequence

              characters = NumVal.extract_characters abnf

              Parser::Tokens::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end

            def self.single character=nil
              character ||= Values::Terminal.single_character
              abnf = Controls::ABNF::Terminal::NumVal::BinVal.single character

              characters = NumVal.extract_characters abnf

              Parser::Tokens::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end
          end

          module DecVal
            def self.range character_range=nil
              character_range ||= Values::Terminal.character_range
              abnf = Controls::ABNF::Terminal::NumVal::DecVal.range character_range

              characters = NumVal.extract_characters abnf

              Parser::Tokens::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end

            def self.sequence character_sequence=nil
              character_sequence ||= Values::Terminal.character_sequence
              abnf = Controls::ABNF::Terminal::NumVal::DecVal.sequence character_sequence

              characters = NumVal.extract_characters abnf

              Parser::Tokens::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end

            def self.single character=nil
              character ||= Values::Terminal.single_character
              abnf = Controls::ABNF::Terminal::NumVal::DecVal.single character

              characters = NumVal.extract_characters abnf

              Parser::Tokens::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end
          end

          module HexVal
            def self.range character_range=nil
              character_range ||= Values::Terminal.character_range
              abnf = Controls::ABNF::Terminal::NumVal::HexVal.range character_range

              characters = NumVal.extract_characters abnf

              Parser::Tokens::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end

            def self.sequence character_sequence=nil
              character_sequence ||= Values::Terminal.character_sequence
              abnf = Controls::ABNF::Terminal::NumVal::HexVal.sequence character_sequence

              characters = NumVal.extract_characters abnf

              Parser::Tokens::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end

            def self.single character=nil
              character ||= Values::Terminal.single_character
              abnf = Controls::ABNF::Terminal::NumVal::HexVal.single character

              characters = NumVal.extract_characters abnf

              Parser::Tokens::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end
          end

          def self.extract_characters abnf
            abnf[2..-1]
          end

          def self.get base, variant
            mod = const_get base
            token = mod.public_send variant
            token
          end
        end
      end
    end
  end
end

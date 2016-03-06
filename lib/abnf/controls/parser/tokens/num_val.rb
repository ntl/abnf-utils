module ABNF
  module Controls
    module Parser
      module Tokens
        module NumVal
          def self.example base=nil, variant=nil
            base ||= 'HexVal'
            variant ||= 'sequence'

            method_name = variant.downcase
            namespace = const_get base

            namespace.public_send method_name
          end

          def self.extract_characters abnf
            abnf[2..-1]
          end

          module BinVal
            def self.range
              character_range = Values.character_range
              abnf = Source::NumVal::BinVal.range character_range

              characters = NumVal.extract_characters abnf

              ::ABNF::Parser::Token::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end

            def self.sequence
              character_sequence = Values.character_sequence
              abnf = Source::NumVal::BinVal.sequence character_sequence

              characters = NumVal.extract_characters abnf

              ::ABNF::Parser::Token::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end

            def self.single
              character = Values.single_character
              abnf = Source::NumVal::BinVal.single character

              characters = NumVal.extract_characters abnf

              ::ABNF::Parser::Token::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end
          end

          module DecVal
            def self.range
              character_range = Values.character_range
              abnf = Source::NumVal::DecVal.range character_range

              characters = NumVal.extract_characters abnf

              ::ABNF::Parser::Token::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end

            def self.sequence
              character_sequence = Values.character_sequence
              abnf = Source::NumVal::DecVal.sequence character_sequence

              characters = NumVal.extract_characters abnf

              ::ABNF::Parser::Token::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end

            def self.single
              character = Values.single_character
              abnf = Source::NumVal::DecVal.single character

              characters = NumVal.extract_characters abnf

              ::ABNF::Parser::Token::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end
          end

          module HexVal
            def self.range
              character_range = Values.character_range
              abnf = Source::NumVal::HexVal.range character_range

              characters = NumVal.extract_characters abnf

              ::ABNF::Parser::Token::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end

            def self.sequence
              character_sequence = Values.character_sequence
              abnf = Source::NumVal::HexVal.sequence character_sequence

              characters = NumVal.extract_characters abnf

              ::ABNF::Parser::Token::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end

            def self.single
              character = Values.single_character
              abnf = Source::NumVal::HexVal.single character

              characters = NumVal.extract_characters abnf

              ::ABNF::Parser::Token::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end
          end
        end
      end
    end
  end
end

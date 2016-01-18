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
          def self.pair base, variant
            mod = const_get base
            mod = mod.const_get variant

            token = mod.value

            return token.abnf, token
          end

          def self.value
            HexVal::Sequence.value
          end

          module BinVal
            Range = Value.define do
              abnf = Controls::ABNF::Terminal::NumVal::BinVal.range
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end

            Sequence = Value.define do
              abnf = Controls::ABNF::Terminal::NumVal::BinVal.sequence
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end

            Single = Value.define do
              abnf = Controls::ABNF::Terminal::NumVal::BinVal.single
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end
          end

          module DecVal
            Range = Value.define do
              abnf = Controls::ABNF::Terminal::NumVal::DecVal.range
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end

            Sequence = Value.define do
              abnf = Controls::ABNF::Terminal::NumVal::DecVal.sequence
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end

            Single = Value.define do
              abnf = Controls::ABNF::Terminal::NumVal::DecVal.single
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end
          end

          module HexVal
            Range = Value.define do
              abnf = Controls::ABNF::Terminal::NumVal::HexVal.range
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end

            Sequence = Value.define do
              abnf = Controls::ABNF::Terminal::NumVal::HexVal.sequence
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end

            Single = Value.define do
              abnf = Controls::ABNF::Terminal::NumVal::HexVal.single
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end
          end
        end
      end
    end
  end
end

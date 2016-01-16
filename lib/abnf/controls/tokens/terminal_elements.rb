module ABNF
  module Controls
    module Tokens
      module TerminalElements
        def self.example
          CharVal.value
        end

        module NumVal
          def self.pair base, variant
            mod = const_get base
            mod = mod.const_get variant

            token = mod.value

            return token.abnf, token
          end

          module BinVal
            Range = Value.define do
              abnf = Controls::ABNF::Elements::NumVal::BinVal::Range.value
              characters = abnf[2..-1]

              Parser::Token::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end

            Sequence = Value.define do
              abnf = Controls::ABNF::Elements::NumVal::BinVal::Sequence.value
              characters = abnf[2..-1]

              Parser::Token::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end

            Single = Value.define do
              abnf = Controls::ABNF::Elements::NumVal::BinVal::Single.value
              characters = abnf[2..-1]

              Parser::Token::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end
          end

          module DecVal
            Range = Value.define do
              abnf = Controls::ABNF::Elements::NumVal::DecVal::Range.value
              characters = abnf[2..-1]

              Parser::Token::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end

            Sequence = Value.define do
              abnf = Controls::ABNF::Elements::NumVal::DecVal::Sequence.value
              characters = abnf[2..-1]

              Parser::Token::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end

            Single = Value.define do
              abnf = Controls::ABNF::Elements::NumVal::DecVal::Single.value
              characters = abnf[2..-1]

              Parser::Token::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end
          end

          module HexVal
            Range = Value.define do
              abnf = Controls::ABNF::Elements::NumVal::HexVal::Range.value
              characters = abnf[2..-1]

              Parser::Token::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end

            Sequence = Value.define do
              abnf = Controls::ABNF::Elements::NumVal::HexVal::Sequence.value
              characters = abnf[2..-1]

              Parser::Token::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end

            Single = Value.define do
              abnf = Controls::ABNF::Elements::NumVal::HexVal::Single.value
              characters = abnf[2..-1]

              Parser::Token::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end
          end
        end

        CharVal = Value.define do
          abnf = Controls::ABNF::Elements::CharVal.value
          characters = abnf[1...-1]

          Parser::Token::CharVal.new abnf, 'characters' => characters
        end

        ProseVal = Value.define do
          abnf = Controls::ABNF::Elements::ProseVal.value
          prose = abnf[1...-1]

          Parser::Token::ProseVal.new abnf, 'prose' => prose
        end

        Terminal = CharVal
      end
    end
  end
end

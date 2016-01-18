module ABNF
  module Controls
    module Tokens
      module TerminalElements
        def self.example
          CharVal.value
        end

        def self.foo
          CharVal.value
        end

        module NumVal
          def self.pair base, variant
            mod = const_get base
            mod = mod.const_get variant

            token = mod.value

            return token.abnf, token
          end

          def self.range
            ('A'..'Z')
          end

          def self.sequence
            'foo'
          end

          def self.single
            '!'
          end

          def self.value
            HexVal::Sequence.value
          end

          module BinVal
            Range = Value.define do
              abnf = Controls::ABNF::NumVal::BinVal::Range.value
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end

            Sequence = Value.define do
              abnf = Controls::ABNF::NumVal::BinVal::Sequence.value
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end

            Single = Value.define do
              abnf = Controls::ABNF::NumVal::BinVal::Single.value
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'b', 'characters' => characters
            end
          end

          module DecVal
            Range = Value.define do
              abnf = Controls::ABNF::NumVal::DecVal::Range.value
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end

            Sequence = Value.define do
              abnf = Controls::ABNF::NumVal::DecVal::Sequence.value
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end

            Single = Value.define do
              abnf = Controls::ABNF::NumVal::DecVal::Single.value
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'd', 'characters' => characters
            end
          end

          module HexVal
            Range = Value.define do
              abnf = Controls::ABNF::NumVal::HexVal::Range.value
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end

            Sequence = Value.define do
              abnf = Controls::ABNF::NumVal::HexVal::Sequence.value
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end

            Single = Value.define do
              abnf = Controls::ABNF::NumVal::HexVal::Single.value
              characters = abnf[2..-1]

              Parser::Tokens::NumVal.new abnf, 'base' => 'x', 'characters' => characters
            end
          end
        end

        CharVal = Value.define do
          abnf = Controls::ABNF::CharVal.value
          characters = abnf[1...-1]

          Parser::Tokens::CharVal.new abnf, 'characters' => characters
        end

        ProseVal = Value.define do
          abnf = Controls::ABNF::ProseVal.value
          prose = abnf[1...-1]

          Parser::Tokens::ProseVal.new abnf, 'prose' => prose
        end
      end
    end
  end
end

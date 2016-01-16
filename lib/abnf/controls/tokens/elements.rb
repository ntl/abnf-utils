module ABNF
  module Controls
    module Tokens
      module Elements
        module NumVal
          def self.pair base, variant
            mod = const_get base
            mod = mod.const_get variant

            token = mod.value

            return token.abnf, token
          end

          module BinVal
            module Range
              def self.value
                abnf = Controls::ABNF::Elements::NumVal::BinVal::Range.value
                characters = abnf[2..-1]

                Parser::Token::NumVal.new abnf, 'base' => 'b', 'characters' => characters
              end
            end

            module Sequence
              def self.value
                abnf = Controls::ABNF::Elements::NumVal::BinVal::Sequence.value
                characters = abnf[2..-1]

                Parser::Token::NumVal.new abnf, 'base' => 'b', 'characters' => characters
              end
            end

            module Single
              def self.value
                abnf = Controls::ABNF::Elements::NumVal::BinVal::Single.value
                characters = abnf[2..-1]

                Parser::Token::NumVal.new abnf, 'base' => 'b', 'characters' => characters
              end
            end
          end

          module DecVal
            module Range
              def self.value
                abnf = Controls::ABNF::Elements::NumVal::DecVal::Range.value
                characters = abnf[2..-1]

                Parser::Token::NumVal.new abnf, 'base' => 'd', 'characters' => characters
              end
            end

            module Sequence
              def self.value
                abnf = Controls::ABNF::Elements::NumVal::DecVal::Sequence.value
                characters = abnf[2..-1]

                Parser::Token::NumVal.new abnf, 'base' => 'd', 'characters' => characters
              end
            end

            module Single
              def self.value
                abnf = Controls::ABNF::Elements::NumVal::DecVal::Single.value
                characters = abnf[2..-1]

                Parser::Token::NumVal.new abnf, 'base' => 'd', 'characters' => characters
              end
            end
          end

          module HexVal
            module Range
              def self.value
                abnf = Controls::ABNF::Elements::NumVal::HexVal::Range.value
                characters = abnf[2..-1]

                Parser::Token::NumVal.new abnf, 'base' => 'x', 'characters' => characters
              end
            end

            module Sequence
              def self.value
                abnf = Controls::ABNF::Elements::NumVal::HexVal::Sequence.value
                characters = abnf[2..-1]

                Parser::Token::NumVal.new abnf, 'base' => 'x', 'characters' => characters
              end
            end

            module Single
              def self.value
                abnf = Controls::ABNF::Elements::NumVal::HexVal::Single.value
                characters = abnf[2..-1]

                Parser::Token::NumVal.new abnf, 'base' => 'x', 'characters' => characters
              end
            end
          end
        end

        module CharVal
          def self.value
            Parser::Token::CharVal.new '"foo"', 'characters' => 'foo'
          end
        end

        Terminal = CharVal
      end
    end
  end
end

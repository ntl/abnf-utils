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

          def self.range
            ('A'..'Z')
          end

          def self.single
            '!'
          end

          def self.sequence
            'foo'
          end

          module BinVal
            module Range
              def self.value
                Parser::Token::NumVal.new '%b1000001-1011010', 'base' => 'b', 'characters' => '1000001-1011010'
              end
            end

            module Sequence
              def self.value
                Parser::Token::NumVal.new '%b1100110.1101111.1101111', 'base' => 'b', 'characters' => '1100110.1101111.1101111'
              end
            end

            module Single
              def self.value
                Parser::Token::NumVal.new '%b100001', 'base' => 'b', 'characters' => '100001'
              end
            end
          end

          module DecVal
            module Range
              def self.value
                Parser::Token::NumVal.new '%d65-90', 'base' => 'd', 'characters' => '65-90'
              end
            end

            module Sequence
              def self.value
                Parser::Token::NumVal.new '%d102.111.111', 'base' => 'd', 'characters' => '102.111.111'
              end
            end

            module Single
              def self.value
                Parser::Token::NumVal.new '%d33', 'base' => 'd', 'characters' => '33'
              end
            end
          end

          module HexVal
            module Range
              def self.value
                Parser::Token::NumVal.new '%x41-5A', 'base' => 'x', 'characters' => '41-5A'
              end
            end

            module Sequence
              def self.value
                Parser::Token::NumVal.new '%x66.6F.6F', 'base' => 'x', 'characters' => '66.6F.6F'
              end
            end

            module Single
              def self.value
                Parser::Token::NumVal.new '%x21', 'base' => 'x', 'characters' => '21'
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

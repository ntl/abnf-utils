module ABNF
  module Controls
    module Parser
      module Tokens
        module NumVal
          def self.example base=nil, variant=nil
            base ||= 16
            variant ||= 'sequence'

            public_send variant, base
          end

          def self.range base=nil
            base ||= 16
            abnf = Source::NumVal.range base

            ABNF::Parser::Token::NumVal.new(
              abnf,
              'base' => abnf[1],
              'characters' => abnf[2..-1],
            )
          end

          def self.sequence base=nil
            base ||= 16
            abnf = Source::NumVal.sequence base

            ABNF::Parser::Token::NumVal.new(
              abnf,
              'base' => abnf[1],
              'characters' => abnf[2..-1],
            )
          end

          def self.single base=nil
            base ||= 16
            abnf = Source::NumVal.single base

            ABNF::Parser::Token::NumVal.new(
              abnf,
              'base' => abnf[1],
              'characters' => abnf[2..-1],
            )
          end
        end
      end
    end
  end
end

module ABNF
  module Controls
    module Parser
      module Tokens
        module Repeat
          def self.example
            any_number
          end

          def self.any_number
            abnf = ABNF::Repeat.any_number
            ::ABNF::Parser::Token::Repeat.new abnf, 'minimum' => '', 'maximum' => ''
          end

          def self.fixed
            abnf = ABNF::Repeat.fixed
            ::ABNF::Parser::Token::Repeat.new abnf, 'minimum' => '2', 'maximum' => '2'
          end

          def self.bounded_range
            abnf = ABNF::Repeat.bounded_range
            ::ABNF::Parser::Token::Repeat.new abnf, 'minimum' => '1', 'maximum' => '2'
          end
        end
      end
    end
  end
end

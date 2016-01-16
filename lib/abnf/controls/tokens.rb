module ABNF
  module Controls
    module Tokens
      module C_NL
        def self.value
          Parser::Token::C_NL.new "\r\n", Hash.new
        end

        module Comment
          def self.value
            Parser::Token::C_NL.new " ; some-comment \r\n", Hash.new
          end
        end
      end

      module DefinedAs
        def self.value
          Parser::Token::DefinedAs.new ' = ', 'operator' => '='
        end

        module IncrementalAssignment
          def self.value
            Parser::Token::DefinedAs.new ' =/ ', 'operator' => '=/'
          end
        end
      end

      module Rulename
        def self.value
          Parser::Token::Rulename.new 'some-rule', Hash.new
        end
      end
    end
  end
end

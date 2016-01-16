module ABNF
  module Controls
    module Tokens
      C_NL = Value.define do
        Parser::Token::C_NL.new "\r\n", Hash.new
      end

      DefinedAs = Value.define do
        Parser::Token::DefinedAs.new ' = ', 'operator' => '='
      end

      OptionStart = Value.define do
        abnf = Controls::ABNF::OptionStart.value
        Parser::Token::OptionStart.new abnf, Hash.new
      end

      OptionStop = Value.define do
        abnf = Controls::ABNF::OptionStop.value
        Parser::Token::OptionStop.new abnf, Hash.new
      end

      GroupStart = Value.define do
        abnf = Controls::ABNF::GroupStart.value
        Parser::Token::GroupStart.new abnf, Hash.new
      end

      GroupStop = Value.define do
        abnf = Controls::ABNF::GroupStop.value
        Parser::Token::GroupStop.new abnf, Hash.new
      end

      Rulename = Value.define do
        Parser::Token::Rulename.new 'some-rule', Hash.new
      end
    end
  end
end

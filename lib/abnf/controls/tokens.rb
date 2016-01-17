module ABNF
  module Controls
    module Tokens
      AlternativeDelimiter = Value.define do
        Parser::Tokens::AlternativeDelimiter.new ' / ', Hash.new
      end

      Newline = Value.define do
        Parser::Tokens::Newline.new "\r\n", Hash.new
      end

      DefinedAs = Value.define do
        Parser::Tokens::DefinedAs.new ' = ', 'operator' => '='
      end

      OptionStart = Value.define do
        abnf = Controls::ABNF::OptionStart.value
        Parser::Tokens::OptionStart.new abnf, Hash.new
      end

      OptionStop = Value.define do
        abnf = Controls::ABNF::OptionStop.value
        Parser::Tokens::OptionStop.new abnf, Hash.new
      end

      GroupStart = Value.define do
        abnf = Controls::ABNF::GroupStart.value
        Parser::Tokens::GroupStart.new abnf, Hash.new
      end

      GroupStop = Value.define do
        abnf = Controls::ABNF::GroupStop.value
        Parser::Tokens::GroupStop.new abnf, Hash.new
      end

      module Repeat
        def self.value
          Any.value
        end

        Any = Value.define do
          abnf = Controls::ABNF::Repeat::Any.value
          Parser::Tokens::Repeat.new abnf, 'low' => '', 'high' => ''
        end

        Fixed = Value.define do
          abnf = Controls::ABNF::Repeat::Fixed.value
          Parser::Tokens::Repeat.new abnf, 'low' => '1', 'high' => '1'
        end

        Range = Value.define do
          abnf = Controls::ABNF::Repeat::Range.value
          Parser::Tokens::Repeat.new abnf, 'low' => '1', 'high' => '2'
        end
      end

      Rulename = Value.define do
        Parser::Tokens::Rulename.new 'some-rule', Hash.new
      end
    end
  end
end

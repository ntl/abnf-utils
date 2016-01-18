module ABNF
  module Controls
    module Tokens
      AlternativeDelimiter = Value.define do
        abnf = Controls::ABNF.alternative_delimiter
        Parser::Tokens::AlternativeDelimiter.new abnf, Hash.new
      end

      Newline = Value.define do
        Parser::Tokens::Newline.new "\r\n", Hash.new
      end

      DefinedAs = Value.define do
        Parser::Tokens::DefinedAs.new ' = ', 'operator' => '='
      end

      OptionStart = Value.define do
        abnf = Controls::ABNF.option_start
        Parser::Tokens::OptionStart.new abnf, Hash.new
      end

      OptionStop = Value.define do
        abnf = Controls::ABNF.option_stop
        Parser::Tokens::OptionStop.new abnf, Hash.new
      end

      GroupStart = Value.define do
        abnf = Controls::ABNF.group_start
        Parser::Tokens::GroupStart.new abnf, Hash.new
      end

      GroupStop = Value.define do
        abnf = Controls::ABNF.group_stop
        Parser::Tokens::GroupStop.new abnf, Hash.new
      end

      module Repeat
        def self.value
          Any.value
        end

        Any = Value.define do
          abnf = Controls::ABNF::Repeat.any
          Parser::Tokens::Repeat.new abnf, 'low' => '', 'high' => ''
        end

        Fixed = Value.define do
          abnf = Controls::ABNF::Repeat.fixed
          Parser::Tokens::Repeat.new abnf, 'low' => '2', 'high' => '2'
        end

        Range = Value.define do
          abnf = Controls::ABNF::Repeat.range
          Parser::Tokens::Repeat.new abnf, 'low' => '1', 'high' => '2'
        end
      end

      Rulename = Value.define do |value=nil|
        value ||= 'some-rule'
        Parser::Tokens::Rulename.new value, Hash.new
      end
    end
  end
end

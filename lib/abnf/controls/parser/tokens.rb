module ABNF
  module Controls
    module Parser
      module Tokens
        def self.alternative_delimiter
          abnf = Controls::ABNF.alternative_delimiter
          ::ABNF::Parser::Token::AlternativeDelimiter.new abnf, Hash.new
        end

        def self.newline
          ::ABNF::Parser::Token::Newline.new "\r\n", Hash.new
        end

        def self.assignment
          ::ABNF::Parser::Token::DefinedAs.new ' = ', 'operator' => '='
        end

        def self.option_start
          abnf = Controls::ABNF.option_start
          ::ABNF::Parser::Token::OptionStart.new abnf, Hash.new
        end

        def self.option_stop
          abnf = Controls::ABNF.option_stop
          ::ABNF::Parser::Token::OptionStop.new abnf, Hash.new
        end

        def self.group_start
          abnf = Controls::ABNF.group_start
          ::ABNF::Parser::Token::GroupStart.new abnf, Hash.new
        end

        def self.group_stop
          abnf = Controls::ABNF.group_stop
          ::ABNF::Parser::Token::GroupStop.new abnf, Hash.new
        end

        def self.rulename value=nil
          value ||= 'some-rule'
          ::ABNF::Parser::Token::Rulename.new value, Hash.new
        end

        def self.whitespace whitespace=nil
          whitespace ||= Controls::ABNF.whitespace
          ::ABNF::Parser::Token::Whitespace.new whitespace, Hash.new
        end
      end
    end
  end
end

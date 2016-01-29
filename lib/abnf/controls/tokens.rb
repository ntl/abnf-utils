module ABNF
  module Controls
    module Tokens
      def self.alternative_delimiter
        abnf = Controls::ABNF.alternative_delimiter
        Parser::Tokens::AlternativeDelimiter.new abnf, Hash.new
      end

      def self.newline
        Parser::Tokens::Newline.new "\r\n", Hash.new
      end

      def self.assignment
        Parser::Tokens::DefinedAs.new ' = ', 'operator' => '='
      end

      def self.option_start
        abnf = Controls::ABNF.option_start
        Parser::Tokens::OptionStart.new abnf, Hash.new
      end

      def self.option_stop
        abnf = Controls::ABNF.option_stop
        Parser::Tokens::OptionStop.new abnf, Hash.new
      end

      def self.group_start
        abnf = Controls::ABNF.group_start
        Parser::Tokens::GroupStart.new abnf, Hash.new
      end

      def self.group_stop
        abnf = Controls::ABNF.group_stop
        Parser::Tokens::GroupStop.new abnf, Hash.new
      end

      def self.rulename
        value = 'some-rule'
        Parser::Tokens::Rulename.new value, Hash.new
      end

      def self.whitespace whitespace=nil
        whitespace ||= Controls::ABNF.whitespace
        Parser::Tokens::Whitespace.new whitespace, Hash.new
      end
    end
  end
end

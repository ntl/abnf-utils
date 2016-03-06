module ABNF
  module Controls
    module Parser
      module Tokens
        def self.alternative_delimiter
          abnf = ABNF.alternative_delimiter
          ::ABNF::Parser::Token::AlternativeDelimiter.new abnf, Hash.new
        end

        def self.assignment
          ::ABNF::Parser::Token::DefinedAs.new ' = ', 'operator' => '='
        end

        def self.char_val character_sequence=nil
          character_sequence ||= Values::Terminal.character_sequence
          abnf = ABNF::Terminal.char_val character_sequence
          ::ABNF::Parser::Token::CharVal.new abnf, 'characters' => character_sequence
        end

        def self.group_start
          abnf = ABNF.group_start
          ::ABNF::Parser::Token::GroupStart.new abnf, Hash.new
        end

        def self.group_stop
          abnf = ABNF.group_stop
          ::ABNF::Parser::Token::GroupStop.new abnf, Hash.new
        end

        def self.newline
          ::ABNF::Parser::Token::Newline.new "\r\n", Hash.new
        end

        def self.num_val
          NumVal.example
        end

        def self.option_start
          abnf = ABNF.option_start
          ::ABNF::Parser::Token::OptionStart.new abnf, Hash.new
        end

        def self.option_stop
          abnf = ABNF.option_stop
          ::ABNF::Parser::Token::OptionStop.new abnf, Hash.new
        end

        def self.prose_val prose=nil
          prose ||= Values::Terminal.prose
          abnf = ABNF::Terminal.prose_val prose
          ::ABNF::Parser::Token::ProseVal.new abnf, 'prose' => prose
        end

        def self.repeat
          Repeat.example
        end

        def self.rulename value=nil
          value ||= 'some-rule'
          ::ABNF::Parser::Token::Rulename.new value, Hash.new
        end

        def self.whitespace whitespace=nil
          whitespace ||= ABNF.whitespace
          ::ABNF::Parser::Token::Whitespace.new whitespace, Hash.new
        end
      end
    end
  end
end

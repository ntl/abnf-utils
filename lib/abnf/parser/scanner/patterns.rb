module ABNF
  module Parser
    class Scanner
      module Patterns
        def self.each &block
          Table.each &block
        end

        C_NL = /(?:;[[:blank:]\x21-\x7E]*)?\r\n/n

        C_WSP = /#{C_NL}?[[:blank:]]/n

        Table = {
          /\A<(?<prose>[\x20-\x3D\x3F-\x7E]*)>/n => Token::ProseVal,
          /\A%(?<base>x)(?<characters>[[:xdigit:]]+(?:-[[:xdigit:]]+|(?:\.[[:xdigit:]]+)+)?)/n => Token::NumVal,
          /\A%(?<base>d)(?<characters>[[:digit:]]+(?:-[[:digit:]]+|(?:\.[[:digit:]]+)+)?)/n => Token::NumVal,
          /\A%(?<base>b)(?<characters>[01]+(?:-[01]+|(?:\.[01]+)+)?)/n => Token::NumVal,
          /\A"(?<characters>[\x20-\x21\x23-\x7E]*)"/n => Token::CharVal,

          /\A(?<low>(?<high>[[:digit:]]+))(?!\*)/n => Token::Repeat,
          /\A(?<low>[[:digit:]]*)\*(?<high>[[:digit:]]*)/n => Token::Repeat,

          /\A\[#{C_WSP}*/n => Token::OptionStart,
          /\A#{C_WSP}*\]/n => Token::OptionStop,

          /\A\(#{C_WSP}*/n => Token::GroupStart,
          /\A#{C_WSP}*\)/n => Token::GroupStop,

          /\A[[:alpha:]][-[:alnum:]]*/n => Token::Rulename,
          /\A#{C_WSP}*(?<operator>=\/?)#{C_WSP}*/n => Token::DefinedAs,

          /\A#{C_WSP}*\/#{C_WSP}*/n => Token::AlternativeDelimiter,

          /\A#{C_WSP}+/n => Token::C_WSP,
          /\A#{C_NL}+/n => Token::C_NL,
        }
      end
    end
  end
end

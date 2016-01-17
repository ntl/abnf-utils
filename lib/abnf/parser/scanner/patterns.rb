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
          /\A<(?<prose>[\x20-\x3D\x3F-\x7E]*)>/n => Tokens::ProseVal,
          /\A%(?<base>x)(?<characters>[[:xdigit:]]+(?:-[[:xdigit:]]+|(?:\.[[:xdigit:]]+)+)?)/n => Tokens::NumVal,
          /\A%(?<base>d)(?<characters>[[:digit:]]+(?:-[[:digit:]]+|(?:\.[[:digit:]]+)+)?)/n => Tokens::NumVal,
          /\A%(?<base>b)(?<characters>[01]+(?:-[01]+|(?:\.[01]+)+)?)/n => Tokens::NumVal,
          /\A"(?<characters>[\x20-\x21\x23-\x7E]*)"/n => Tokens::CharVal,

          /\A(?<low>(?<high>[[:digit:]]+))(?!\*)/n => Tokens::Repeat,
          /\A(?<low>[[:digit:]]*)\*(?<high>[[:digit:]]*)/n => Tokens::Repeat,

          /\A\[#{C_WSP}*/n => Tokens::OptionStart,
          /\A#{C_WSP}*\]/n => Tokens::OptionStop,

          /\A\(#{C_WSP}*/n => Tokens::GroupStart,
          /\A#{C_WSP}*\)/n => Tokens::GroupStop,

          /\A[[:alpha:]][-[:alnum:]]*/n => Tokens::Rulename,
          /\A#{C_WSP}*(?<operator>=\/?)#{C_WSP}*/n => Tokens::DefinedAs,

          /\A#{C_WSP}*\/#{C_WSP}*/n => Tokens::AlternativeDelimiter,

          /\A#{C_WSP}+/n => Tokens::Whitespace,
          /\A#{C_NL}+/n => Tokens::Newline,
        }
      end
    end
  end
end

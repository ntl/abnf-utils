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
          /\A<(?<prose>[\x20-\x3D\x3F-\x7E]*)>/n => ProseVal,
          /\A%(?<base>x)(?<characters>[[:xdigit:]]+(?:-[[:xdigit:]]+|(?:\.[[:xdigit:]]+)+)?)/n => NumVal,
          /\A%(?<base>d)(?<characters>[[:digit:]]+(?:-[[:digit:]]+|(?:\.[[:digit:]]+)+)?)/n => NumVal,
          /\A%(?<base>b)(?<characters>[01]+(?:-[01]+|(?:\.[01]+)+)?)/n => NumVal,
          /\A"(?<characters>[\x20-\x21\x23-\x7E]*)"/n => CharVal,

          /\A(?<low>(?<high>[[:digit:]]+))(?!\*)/n => Repeat,
          /\A(?<low>[[:digit:]]*)\*(?<high>[[:digit:]]*)/n => Repeat,

          /\A\[#{C_WSP}*/n => OptionStart,
          /\A#{C_WSP}*\]/n => OptionStop,

          /\A\(#{C_WSP}*/n => GroupStart,
          /\A#{C_WSP}*\)/n => GroupStop,

          /\A[[:alpha:]][-[:alnum:]]*/n => Rulename,
          /\A#{C_WSP}*(?<operator>=\/?)#{C_WSP}*/n => DefinedAs,

          /\A#{C_WSP}*\/#{C_WSP}*/n => AlternativeDelimiter,

          /\A#{C_WSP}+/n => Parser::C_WSP,
          /\A#{C_NL}+/n => Parser::C_NL,
        }
      end
    end
  end
end

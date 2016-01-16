module ABNF
  module Parser
    class Scanner
      module Patterns
        def self.each &block
          Table.each &block
        end

        C_NL = /(?:;[[:blank:]\x21-\x7E]*)?\r\n/n

        C_WSP = /#{C_NL}?[[:blank:]]+/n

        Table = {
          /\A<(?<prose>[\x20-\x3D\x3F-\x7E]*)>/n => 'prose-val',
          /\A%(?<base>x)(?<characters>[[:xdigit:]]+(?:-[[:xdigit:]]+|(?:\.[[:xdigit:]]+)+)?)/n => 'num-val',
          /\A%(?<base>d)(?<characters>[[:digit:]]+(?:-[[:digit:]]+|(?:\.[[:digit:]]+)+)?)/n => 'num-val',
          /\A%(?<base>b)(?<characters>[01]+(?:-[01]+|(?:\.[01]+)+)?)/n => 'num-val',
          /\A"(?<characters>[\x20-\x21\x23-\x7E]*)"/n => 'char-val',

          /\A(?<low>(?<high>[[:digit:]]+))(?!\*)/n => 'repeat',
          /\A(?<low>[[:digit:]]*)\*(?<high>[[:digit:]]*)/n => 'repeat',

          /\A#{C_WSP}*\/#{C_WSP}*/n => 'alternation-DELIMITER',

          /\A\[#{C_WSP}*/n => 'option-START',
          /\A#{C_WSP}*\]/n => 'option-STOP',

          /\A\(#{C_WSP}*/n => 'group-START',
          /\A#{C_WSP}*\)/n => 'group-STOP',

          /\A[[:alpha:]][-[:alnum:]]*/n => 'rulename',
          /\A#{C_WSP}*(?<operator>=\/?)#{C_WSP}*/n => 'defined-as',

          /\A#{C_WSP}+/n => '*c-wsp',
          /\A#{C_NL}/n => 'c-nl',
        }
      end
    end
  end
end

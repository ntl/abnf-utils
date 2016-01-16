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
          'char-val' => /\A"(?<characters>[\x20-\x21\x23-\x7E]*)"/,
          'hex-val' => /\A%(?<base>x)(?<characters>[[:xdigit:]]+(?:-[[:xdigit:]]+|(?:\.[[:xdigit:]]+)+)?)/n,
          'dec-val' => /\A%(?<base>d)(?<characters>[[:digit:]]+(?:-[[:digit:]]+|(?:\.[[:digit:]]+)+)?)/n,
          'bin-val' => /\A%(?<base>b)(?<characters>[01]+(?:-[01]+|(?:\.[01]+)+)?)/n,

          'rulename' => /\A[[:alpha:]][-[:alnum:]]*/n,
          'defined-as' => /\A#{C_WSP}*(?<operator>=\/?)#{C_WSP}*/n,

          '*c-wsp' => /\A#{C_WSP}/n,
          'c-nl' => /\A#{C_NL}/n,
        }
      end
    end
  end
end

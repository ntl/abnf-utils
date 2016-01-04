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
          'hex-val' => /\A%x[[:xdigit:]]+(?:-[[:xdigit:]]+|(?:\.[[:xdigit:]]+)+)?/n,

          'rulename' => /\A[[:alpha:]][-[:alnum:]]*/n,
          'defined-as' => /\A#{C_WSP}*=\/?#{C_WSP}*/n,

          '*c-wsp' => /\A#{C_WSP}/n,
          'c-nl' => /\A#{C_NL}/n,
        }
      end
    end
  end
end

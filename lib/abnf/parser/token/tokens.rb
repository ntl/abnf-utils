module ABNF
  module Parser
    class Token
      class C_NL < Token
        def self.types
          %w(c-nl)
        end
      end

      class C_WSP < Token
        def self.types
          %w(*c-wsp)
        end
      end

      class CharVal < Token
        def self.types
          %w(char-val)
        end
      end

      class DefinedAs < Token
        def self.types
          %w(defined-as)
        end
      end

      class NumVal < Token
        def self.types
          %w(bin-val dec-val hex-val)
        end
      end

      class Rulename < Token
        def self.types
          %w(rulename)
        end
      end
    end
  end
end

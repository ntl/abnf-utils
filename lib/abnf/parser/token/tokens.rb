module ABNF
  module Parser
    class Token
      class C_NL < Token
        def self.type
          'c-nl'
        end
      end

      class C_WSP < Token
        def self.type
          '*c-wsp'
        end
      end

      class DefinedAs < Token
        def self.type
          'defined-as'
        end
      end

      class HexVal < Token
        def self.type
          'hex-val'
        end
      end

      class Rulename < Token
        def self.type
          'rulename'
        end
      end
    end
  end
end

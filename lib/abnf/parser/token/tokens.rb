module ABNF
  module Parser
    class Token
      class AlternativeDelimiter < Token
      end

      class C_NL < Token
      end

      class C_WSP < Token
      end

      class CharVal < Token
      end

      class DefinedAs < Token
      end

      class GroupStart < Token
      end

      class GroupStop < Token
      end

      class NumVal < Token
      end

      class OptionStart < Token
      end

      class OptionStop < Token
      end

      class ProseVal < Token
      end

      class Repeat < Token
      end

      class Rulename < Token
      end
    end
  end
end

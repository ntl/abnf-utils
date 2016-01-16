module ABNF
  module Parser
    class Token
      class AlternativeDelimiter < Token
        def self.type
          %{alternation-DELIMITER}
        end
      end

      class C_NL < Token
        def self.type
          %{c-nl}
        end
      end

      class C_WSP < Token
        def self.type
          %{*c-wsp}
        end
      end

      class CharVal < Token
        def self.type
          %{char-val}
        end
      end

      class DefinedAs < Token
        def self.type
          %{defined-as}
        end
      end

      class GroupStart < Token
        def self.type
          %{group-START}
        end
      end

      class GroupStop < Token
        def self.type
          %{group-STOP}
        end
      end

      class NumVal < Token
        def self.type
          %{num-val}
        end
      end

      class OptionStart < Token
        def self.type
          %{option-START}
        end
      end

      class OptionStop < Token
        def self.type
          %{option-STOP}
        end
      end

      class ProseVal < Token
        def self.type
          %{prose-val}
        end
      end

      class Repeat < Token
        def self.type
          %{repeat}
        end
      end

      class Rulename < Token
        def self.type
          %{rulename}
        end
      end
    end
  end
end

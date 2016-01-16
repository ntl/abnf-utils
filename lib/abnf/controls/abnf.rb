module ABNF
  module Controls
    module ABNF
      AlternativeDelimiter = Value.define %{ / }

      BadSyntax = Value.define %{!invalid-abnf}

      CharVal = Value.define %{"foo"}

      GroupStart = Value.define %{( }
      GroupStop = Value.define %{ )}

      module NumVal
        module BinVal
          Range = Value.define %{%b1000001-1011010}
          Sequence = Value.define %{%b1100110.1101111.1101111}
          Single = Value.define %{%b100001}
        end

        module DecVal
          Range = Value.define %{%d65-90}
          Sequence = Value.define %{%d102.111.111}
          Single = Value.define %{%d33}
        end

        module HexVal
          Range = Value.define %{%x41-5A}
          Sequence = Value.define %{%x66.6F.6F}
          Single = Value.define %{%x21}
        end
      end

      OptionStart = Value.define %{[ }
      OptionStop = Value.define %{ ]}

      ProseVal = Value.define %{<Some Prose>}

      module Repeat
        def self.value
          Any.value
        end

        Any = Value.define %{*}
        Fixed = Value.define %{1}
        Range = Value.define %{1*2}
      end

      SingleTerminal = Value.define %{some-rule = #{CharVal.value}\r\n}

      Example = SingleTerminal
    end
  end
end

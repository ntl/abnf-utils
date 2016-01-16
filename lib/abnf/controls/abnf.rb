module ABNF
  module Controls
    module ABNF
      module SingleTerminal
        def self.value
          %{some-rule = "foo"\r\n}
        end
      end

      module BadSyntax
        def self.value
          %{!not-a-rule}
        end
      end

      Example = SingleTerminal
    end
  end
end

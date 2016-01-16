module ABNF
  module Controls
    module ABNF
      module BadSyntax
        def self.value
          %{!not-a-rule}
        end
      end

      module Elements
        module NumVal
          module BinVal
            module Range
              def self.value
                %{%b1000001-1011010}
              end
            end

            module Sequence
              def self.value
                %{%b1100110.1101111.1101111}
              end
            end

            module Single
              def self.value
                %{%b100001}
              end
            end
          end

          module DecVal
            module Range
              def self.value
                %{%d65-90}
              end
            end

            module Sequence
              def self.value
                %{%d102.111.111}
              end
            end

            module Single
              def self.value
                %{%d33}
              end
            end
          end

          module HexVal
            module Range
              def self.value
                %{%x41-5A}
              end
            end

            module Sequence
              def self.value
                %{%x66.6F.6F}
              end
            end

            module Single
              def self.value
                %{%x21}
              end
            end
          end
        end

        module CharVal
          def self.value
            %{"foo"}
          end
        end
      end

      module SingleTerminal
        def self.value
          %{some-rule = "foo"\r\n}
        end
      end

      Example = SingleTerminal
    end
  end
end

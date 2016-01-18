module ABNF
  module Controls
    module ABNF
      def self.alternative_delimiter
        ' / '
      end

      def self.bad_syntax
        '!invalid-abnf'
      end

      def self.char_val string=nil
        string ||= 'foo'
        %{"#{string}"}
      end

      def self.group_start
        '( '
      end

      def self.group_stop
        ' )'
      end

      module NumVal
        def self.range base=nil
          base ||= 16

          first, *, last = Values.character_range.to_a

          prefix, first, last = convert "#{first}#{last}", base

          "%#{prefix}#{first}-#{last}"
        end

        def self.sequence base=nil
          base ||= 16

          character_sequence = Values.character_sequence

          prefix, *character_codes = convert character_sequence, base

          "%#{prefix}#{character_codes * '.'}"
        end

        def self.single base=nil
          single_character = Values.single_character

          prefix, character_code = convert single_character, base

          "%#{prefix}#{character_code}"
        end

        def self.convert string, base
          prefix = { 2 => 'b', 10 => 'd', 16 => 'x' }.fetch base

          characters = string.unpack 'C*'

          characters.map! do |character|
            character.to_s base
          end

          return prefix, *characters
        end

        module BinVal
          def self.range
            NumVal.range 2
          end

          def self.sequence
            NumVal.sequence 2
          end

          def self.single
            NumVal.single 2
          end
        end

        module DecVal
          def self.range
            NumVal.range 10
          end

          def self.sequence
            NumVal.sequence 10
          end

          def self.single
            NumVal.single 10
          end
        end

        module HexVal
          def self.range
            NumVal.range 16
          end

          def self.sequence
            NumVal.sequence 16
          end

          def self.single
            NumVal.single 16
          end
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

      SingleTerminal = Value.define %{some-rule = #{char_val}\r\n}

      Example = SingleTerminal
    end
  end
end

module ABNF
  module Controls
    module ABNF
      module Terminal
        def self.example
          char_val
        end

        def self.char_val string=nil
          string ||= Values::Terminal.character_sequence
          %{"#{string}"}
        end

        module NumVal
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

          def self.range base=nil, character_range: nil
            base ||= 16
            character_range ||= Values::Terminal.character_range

            first, *, last = character_range.to_a

            prefix, first, last = convert "#{first}#{last}", base

            "%#{prefix}#{first}-#{last}"
          end

          def self.sequence base=nil, character_sequence: nil
            base ||= 16
            character_sequence ||= Values::Terminal.character_sequence

            prefix, *character_codes = convert character_sequence, base

            "%#{prefix}#{character_codes * '.'}"
          end

          def self.single base=nil, character: nil
            character ||= Values::Terminal.single_character

            prefix, character_code = convert character, base

            "%#{prefix}#{character_code}"
          end

          def self.example
            sequence
          end

          def self.convert string, base
            prefix = { 2 => 'b', 10 => 'd', 16 => 'x' }.fetch base

            characters = string.unpack 'C*'

            characters.map! do |character|
              character.to_s base
            end

            return prefix, *characters
          end
        end
      end
    end
  end
end

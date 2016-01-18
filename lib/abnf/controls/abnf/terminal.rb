module ABNF
  module Controls
    module ABNF
      module Terminal
        def self.example
          char_val
        end

        def self.char_val character_sequence=nil
          character_sequence ||= Values::Terminal.character_sequence
          %{"#{character_sequence}"}
        end

        def self.prose_val prose=nil
          prose ||= Values::Terminal.prose
          "<#{prose}>"
        end

        module NumVal
          module BinVal
            def self.range character_range=nil
              NumVal.range character_range, base: 2
            end

            def self.sequence character_sequence=nil
              NumVal.sequence character_sequence, base: 2
            end

            def self.single character=nil
              NumVal.single character, base: 2
            end
          end

          module DecVal
            def self.range character_range=nil
              NumVal.range character_range, base: 10
            end

            def self.sequence character_sequence=nil
              NumVal.sequence character_sequence, base: 10
            end

            def self.single character=nil
              NumVal.single character, base: 10
            end
          end

          module HexVal
            def self.range character_range=nil
              NumVal.range character_range, base: 16
            end

            def self.sequence character_sequence=nil
              NumVal.sequence character_sequence, base: 16
            end

            def self.single character=nil
              NumVal.single character, base: 16
            end
          end

          def self.range character_range=nil, base: nil
            base ||= 16
            character_range ||= Values::Terminal.character_range

            first, *, last = character_range.to_a

            prefix, first, last = convert "#{first}#{last}", base

            "%#{prefix}#{first}-#{last}"
          end

          def self.sequence character_sequence=nil, base: nil
            base ||= 16
            character_sequence ||= Values::Terminal.character_sequence

            prefix, *character_codes = convert character_sequence, base

            "%#{prefix}#{character_codes * '.'}"
          end

          def self.single character=nil, base: nil
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

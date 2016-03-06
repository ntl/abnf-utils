module ABNF
  module Controls
    module Source
      module NumVal
        def self.example
          sequence
        end

        def self.range base=nil
          base ||= 16
          character_range = Values.character_range

          first, *, last = character_range.to_a
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
          base ||= 16
          character = Values.single_character

          prefix, character_code = convert character, base

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
      end
    end
  end
end

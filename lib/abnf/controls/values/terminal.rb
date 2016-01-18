module ABNF
  module Controls
    module Values
      module Terminal
        def self.example
          character_sequence
        end

        def self.character_range
          ('A'..'Z')
        end

        def self.character_sequence
          'some-string'
        end

        def self.prose
          'Some Prose'
        end

        def self.single_character
          '#'
        end
      end
    end
  end
end

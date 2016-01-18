module ABNF
  module Controls
    module Values
      def self.alternation
        %w(first-choice second-choice)
      end

      def self.concatenation
        %w(first-element second-element)
      end

      def self.option
        'optional-string'
      end

      def self.repetition
        Repetition.value
      end

      def self.rulename
        'some-rule'
      end

      def self.terminal
        Terminal.example
      end

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

      module Repetition
        def self.example
          any
        end

        def self.any
          (0..Float::INFINITY)
        end

        def self.fixed
          2
        end

        def self.bounded_range
          (1..2)
        end
      end
    end
  end
end

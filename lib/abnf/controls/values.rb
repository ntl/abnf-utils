module ABNF
  module Controls
    module Values
      def self.alternation
        %w(first-choice second-choice)
      end

      def self.character_range
        ('A'..'Z')
      end

      def self.character_sequence
        'some-string'
      end

      def self.concatenation
        %w(first-element second-element)
      end

      def self.option
        'optional-string'
      end

      def self.prose
        'Some Prose'
      end

      def self.repetition
        Repetition.example
      end

      def self.rulename
        'some-rule'
      end

      def self.single_character
        '#'
      end

      def self.whitespace
        ' '
      end
    end
  end
end

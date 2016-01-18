module ABNF
  module Controls
    module Values
      def self.alternation
        %W(first-choice second-choice)
      end

      def self.character_range
        ('A'..'Z')
      end

      def self.character_sequence
        'some-string'
      end

      def self.concatenation
        %W(first-element second-element)
      end

      def self.option
        'optional-string'
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

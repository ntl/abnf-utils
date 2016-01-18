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
    end
  end
end

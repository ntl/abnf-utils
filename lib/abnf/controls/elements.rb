module ABNF
  module Controls
    module Elements
      def self.example
        Terminal.example
      end

      def self.alternation elements=nil
        abnf = String.new

        elements ||= Values.alternation.map do |string|
          Terminal.char_val string
        end

        delimiter = Controls::ABNF.alternative_delimiter
        abnf = elements.map(&:abnf) * delimiter

        Element::Alternation.new abnf, elements
      end

      def self.concatenation elements=nil
        abnf = String.new

        elements ||= Values.concatenation.map do |string|
          Terminal.char_val string
        end

        whitespace = Controls::ABNF.whitespace
        abnf = elements.map(&:abnf) * whitespace

        Element::Concatenation.new abnf, elements
      end

      def self.group element=nil
        element ||= Terminal.char_val

        abnf = [
          Controls::ABNF.group_start,
          element.abnf,
          Controls::ABNF.group_stop,
        ].join

        element.abnf = abnf
        element
      end

      def self.optional element=nil
        element ||= Terminal.char_val

        abnf = [
          Controls::ABNF.option_start,
          element.abnf,
          Controls::ABNF.option_stop,
        ].join

        range = (0..1)

        Element::Repetition.new abnf, range, element
      end

      def self.reference rulename=nil
        rulename ||= Values.rulename
        Element::Reference.new rulename
      end
    end
  end
end

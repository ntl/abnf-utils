module ABNF
  module Controls
    module Elements
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

      module Repetition
        def self.example
          any_number
        end

        def self.any_number element=nil
          element ||= Terminal.char_val

          abnf = "#{Controls::ABNF::Repeat.any_number}#{element.abnf}"
          range = Values::Repetition.any_number

          Element::Repetition.new abnf, range, element
        end

        def self.fixed element=nil
          element ||= Terminal.char_val

          abnf = "#{Controls::ABNF::Repeat.fixed}#{element.abnf}"
          count = Values::Repetition.fixed
          range = (count..count)

          Element::Repetition.new abnf, range, element
        end

        def self.bounded_range element=nil
          element ||= Terminal.char_val

          abnf = "#{Controls::ABNF::Repeat.bounded_range}#{element.abnf}"
          range = Values::Repetition.bounded_range

          Element::Repetition.new abnf, range, element
        end
      end
    end
  end
end

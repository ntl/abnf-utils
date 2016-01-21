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
    end
  end
end

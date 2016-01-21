module ABNF
  module Controls
    module Elements
      def self.optional element=nil
        element ||= Terminal.char_val

        abnf = "[ #{element.abnf} ]"
        range = (0..1)

        Element::Repetition.new abnf, range, element
      end
    end
  end
end

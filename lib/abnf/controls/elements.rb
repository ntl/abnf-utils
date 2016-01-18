module ABNF
  module Controls
    module Elements
      CharVal = Value.define do
        abnf = Controls::ABNF.char_val
        characters = abnf[1...-1]
        Element::Terminal::Sequence.new abnf, characters
      end
      Terminal = CharVal

      module NumVal
        Range = Value.define do
          abnf = ABNF::NumVal::BinVal.range
          range = Values.character_range
          Element::Terminal::Range.new abnf, range
        end

        Sequence = Value.define do
          abnf = ABNF::NumVal::DecVal.sequence
          characters = Values.character_sequence
          Element::Terminal::Sequence.new abnf, characters
        end

        Single = Value.define do
          abnf = ABNF::NumVal::HexVal.single
          characters = Values.single_character
          Element::Terminal::Sequence.new abnf, characters
        end
      end

      ProseVal = Value.define do
        abnf = Controls::ABNF::ProseVal.value
        prose = abnf[1...-1]
        Element::Terminal::ProseVal.new prose
      end
    end
  end
end

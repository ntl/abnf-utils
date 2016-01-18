module ABNF
  module Controls
    module Elements
      CharVal = Value.define do
        abnf = Controls::ABNF::Terminal.char_val
        characters = abnf[1...-1]
        Element::Terminal::Sequence.new abnf, characters
      end
      Terminal = CharVal

      module NumVal
        Range = Value.define do
          abnf = ABNF::Terminal::NumVal::BinVal.range
          range = Values::Terminal.character_range
          Element::Terminal::Range.new abnf, range
        end

        Sequence = Value.define do
          abnf = ABNF::Terminal::NumVal::DecVal.sequence
          characters = Values::Terminal.character_sequence
          Element::Terminal::Sequence.new abnf, characters
        end

        Single = Value.define do
          abnf = ABNF::Terminal::NumVal::HexVal.single
          characters = Values::Terminal.single_character
          Element::Terminal::Sequence.new abnf, characters
        end
      end

      ProseVal = Value.define do
        abnf = Controls::ABNF.prose_val
        prose = Values::Terminal.prose
        Element::Terminal::ProseVal.new prose
      end
    end
  end
end

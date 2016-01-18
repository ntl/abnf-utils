module ABNF
  module Controls
    module Elements
      CharVal = Value.define do
        abnf = Controls::ABNF::CharVal.value
        characters = abnf[1...-1]
        Element::Terminal::Sequence.new abnf, characters
      end
      Terminal = CharVal

      module NumVal
        Range = Value.define do
          abnf = ABNF::NumVal::BinVal::Range.value
          range = Tokens::TerminalElements::NumVal.range
          Element::Terminal::Range.new abnf, range
        end

        Sequence = Value.define do
          abnf = ABNF::NumVal::DecVal::Sequence.value
          characters = Tokens::TerminalElements::NumVal.sequence
          Element::Terminal::Sequence.new abnf, characters
        end

        Single = Value.define do
          abnf = ABNF::NumVal::HexVal::Single.value
          characters = Tokens::TerminalElements::NumVal.single
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

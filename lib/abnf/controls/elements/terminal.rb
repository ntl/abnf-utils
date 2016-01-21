module ABNF
  module Controls
    module Elements
      module Terminal
        module CharVal
          def self.value character_sequence=nil
            character_sequence ||= Controls::Values::Terminal.character_sequence
            abnf = Controls::ABNF::Terminal.char_val character_sequence
            Element::Terminal::Sequence.new abnf, character_sequence
          end
        end

        module ProseVal
          def self.value prose=nil
            prose ||= Values::Terminal.prose
            Element::Terminal::ProseVal.new prose
          end
        end

        module NumVal
          def self.get base, method_name
            mod = const_get base
            mod.public_send method_name
          end

          module BinVal
            def self.range character_range=nil
              character_range ||= Values::Terminal.character_range
              abnf = ABNF::Terminal::NumVal::BinVal.range character_range
              Element::Terminal::Range.new abnf, character_range
            end

            def self.sequence character_sequence=nil
              character_sequence ||= Values::Terminal.character_sequence
              abnf = ABNF::Terminal::NumVal::BinVal.sequence character_sequence
              Element::Terminal::Sequence.new abnf, character_sequence
            end

            def self.single character=nil
              character ||= Values::Terminal.single_character
              abnf = ABNF::Terminal::NumVal::BinVal.single character
              Element::Terminal::Sequence.new abnf, character
            end
          end

          module DecVal
            def self.range character_range=nil
              character_range ||= Values::Terminal.character_range
              abnf = ABNF::Terminal::NumVal::DecVal.range character_range
              Element::Terminal::Range.new abnf, character_range
            end

            def self.sequence character_sequence=nil
              character_sequence ||= Values::Terminal.character_sequence
              abnf = ABNF::Terminal::NumVal::DecVal.sequence character_sequence
              Element::Terminal::Sequence.new abnf, character_sequence
            end

            def self.single character=nil
              character ||= Values::Terminal.single_character
              abnf = ABNF::Terminal::NumVal::DecVal.single character
              Element::Terminal::Sequence.new abnf, character
            end
          end

          module HexVal
            def self.range character_range=nil
              character_range ||= Values::Terminal.character_range
              abnf = ABNF::Terminal::NumVal::HexVal.range character_range
              Element::Terminal::Range.new abnf, character_range
            end

            def self.sequence character_sequence=nil
              character_sequence ||= Values::Terminal.character_sequence
              abnf = ABNF::Terminal::NumVal::HexVal.sequence character_sequence
              Element::Terminal::Sequence.new abnf, character_sequence
            end

            def self.single character=nil
              character ||= Values::Terminal.single_character
              abnf = ABNF::Terminal::NumVal::HexVal.single character
              Element::Terminal::Sequence.new abnf, character
            end
          end
        end
      end
    end
  end
end

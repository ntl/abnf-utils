module ABNF
  module Controls
    module AST
      module Nodes
        module Terminal
          def self.example
            char_val
          end

          def self.char_val character_sequence=nil
            character_sequence ||= Controls::Values.character_sequence
            abnf = Source.char_val character_sequence
            ::ABNF::Parser::Node::Terminal::Sequence.new abnf, character_sequence
          end

          def self.prose_val prose=nil
            prose ||= Values.prose
            ::ABNF::Parser::Node::Terminal::ProseVal.new prose
          end

          module NumVal
            def self.get base=nil, variant=nil
              base ||= 'HexVal'
              variant ||= 'Sequence'

              method_name = variant.downcase

              mod = const_get base
              mod.public_send method_name
            end

            module BinVal
              def self.range character_range=nil
                character_range ||= Values.character_range
                abnf = Source::NumVal::BinVal.range character_range
                ::ABNF::Parser::Node::Terminal::Range.new abnf, character_range
              end

              def self.sequence character_sequence=nil
                character_sequence ||= Values.character_sequence
                abnf = Source::NumVal::BinVal.sequence character_sequence
                ::ABNF::Parser::Node::Terminal::Sequence.new abnf, character_sequence
              end

              def self.single character=nil
                character ||= Values.single_character
                abnf = Source::NumVal::BinVal.single character
                ::ABNF::Parser::Node::Terminal::Sequence.new abnf, character
              end
            end

            module DecVal
              def self.range character_range=nil
                character_range ||= Values.character_range
                abnf = Source::NumVal::DecVal.range character_range
                ::ABNF::Parser::Node::Terminal::Range.new abnf, character_range
              end

              def self.sequence character_sequence=nil
                character_sequence ||= Values.character_sequence
                abnf = Source::NumVal::DecVal.sequence character_sequence
                ::ABNF::Parser::Node::Terminal::Sequence.new abnf, character_sequence
              end

              def self.single character=nil
                character ||= Values.single_character
                abnf = Source::NumVal::DecVal.single character
                ::ABNF::Parser::Node::Terminal::Sequence.new abnf, character
              end
            end

            module HexVal
              def self.range character_range=nil
                character_range ||= Values.character_range
                abnf = Source::NumVal::HexVal.range character_range
                ::ABNF::Parser::Node::Terminal::Range.new abnf, character_range
              end

              def self.sequence character_sequence=nil
                character_sequence ||= Values.character_sequence
                abnf = Source::NumVal::HexVal.sequence character_sequence
                ::ABNF::Parser::Node::Terminal::Sequence.new abnf, character_sequence
              end

              def self.single character=nil
                character ||= Values.single_character
                abnf = Source::NumVal::HexVal.single character
                ::ABNF::Parser::Node::Terminal::Sequence.new abnf, character
              end
            end
          end
        end
      end
    end
  end
end

module ABNF
  module Parser
    module Tokens
      class AlternativeDelimiter < Token
      end

      class CharVal < Token
        def characters
          captures.fetch 'characters'
        end
      end

      class DefinedAs < Token
        def incremental_assignment?
          operator == '=/'
        end

        def operator
          captures.fetch 'operator'
        end
      end

      class GroupStart < Token
      end

      class GroupStop < Token
      end

      class Newline < Token
      end

      class NumVal < Token
        def base
          case captures.fetch 'base'
          when 'b' then 2
          when 'd' then 10
          when 'x' then 16
          else fail
          end
        end

        def characters
          octets = captures['characters'].split '.'

          octets.map! do |octet|
            octet.to_i base
          end

          octets.pack 'C*'
        end

        def range
          first, last = captures['characters'].split '-', 2

          return unless last

          first = first.to_i base
          last = last.to_i base

          (first.chr..last.chr)
        end
      end

      class OptionStart < Token
      end

      class OptionStop < Token
      end

      class ProseVal < Token
        def prose
          captures.fetch 'prose'
        end
      end

      class Repeat < Token
        def maximum
          if captures['maximum'].empty?
            Float::INFINITY
          else
            captures['maximum'].to_i
          end
        end

        def minimum
          captures['minimum'].to_i
        end

        def range
          (minimum..maximum)
        end
      end

      class Rulename < Token
        def value
          abnf
        end
      end

      class Whitespace < Token
      end
    end
  end
end

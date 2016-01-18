module ABNF
  module Controls
    module ABNF
      def self.alternative_delimiter
        ' / '
      end

      def self.bad_syntax
        '!invalid-abnf'
      end

      def self.char_val string=nil
        string ||= Values::Terminal.character_sequence
        %{"#{string}"}
      end

      def self.group_start
        '( '
      end

      def self.group_stop
        ' )'
      end

      def self.num_val
        NumVal.example
      end

      def self.option_start
        '[ '
      end

      def self.option_stop
        ' ]'
      end

      def self.prose_val prose=nil
        prose ||= Values::Terminal.prose
        "<#{prose}>"
      end

      def self.rule rulename: nil, element: nil
        rulename ||= Values.rulename
        element ||= Values.terminal

        "#{rulename} = #{element}\r\n"
      end

      module Repeat
        def self.example
          any
        end

        def self.any
          '*'
        end

        def self.fixed count=nil
          count ||= Values::Repetition.fixed
          count.to_s
        end

        def self.bounded_range range=nil
          range ||= Values::Repetition.bounded_range
          "#{range.first}*#{range.last}"
        end
      end
    end
  end
end

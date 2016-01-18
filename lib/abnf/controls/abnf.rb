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
        NumVal.value
      end

      def self.option_start
        '[ '
      end

      def self.option_stop
        ' ]'
      end

      def self.prose_val
        "<#{Values::Terminal.prose}>"
      end

      def self.rule
        rulename = Values.rulename
        terminal = Values.terminal

        "#{rulename} = #{terminal}\r\n"
      end

      module Repeat
        def self.value
          any
        end

        def self.any
          '*'
        end

        def self.fixed
          fixed_repetition_count = Values::Repetition.fixed
          fixed_repetition_count.to_s
        end

        def self.range
          repetition_range = Values::Repetition.range
          "#{repetition_range.first}*#{repetition_range.last}"
        end
      end
    end
  end
end

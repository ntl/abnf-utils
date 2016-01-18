module ABNF
  module Controls
    module ABNF
      def self.alternative_delimiter
        ' / '
      end

      def self.bad_syntax
        '!invalid-abnf'
      end

      def self.group_start
        '( '
      end

      def self.group_stop
        ' )'
      end

      def self.terminal
        Terminal.example
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
    end
  end
end

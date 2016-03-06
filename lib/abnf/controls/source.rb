module ABNF
  module Controls
    module Source
      def self.alternative_delimiter
        ' / '
      end

      def self.bad_syntax
        '!invalid-abnf'
      end

      def self.char_val character_sequence=nil
        character_sequence ||= Values.character_sequence

        %{"#{character_sequence}"}
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

      def self.prose_val
        prose = Values.prose

        "<#{prose}>"
      end

      def self.repeat
        Repeat.example
      end

      def self.rule
        rulename = Values.rulename
        rule = char_val

        "#{rulename} = #{rule}\r\n"
      end

      def self.whitespace
        Values.whitespace
      end
    end
  end
end

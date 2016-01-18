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
        string ||= 'foo'
        %{"#{string}"}
      end

      def self.group_start
        '( '
      end

      def self.group_stop
        ' )'
      end

      OptionStart = Value.define %{[ }
      OptionStop = Value.define %{ ]}

      ProseVal = Value.define %{<Some Prose>}

      module Repeat
        def self.value
          Any.value
        end

        Any = Value.define %{*}
        Fixed = Value.define %{1}
        Range = Value.define %{1*2}
      end

      SingleTerminal = Value.define %{some-rule = #{char_val}\r\n}

      Example = SingleTerminal
    end
  end
end

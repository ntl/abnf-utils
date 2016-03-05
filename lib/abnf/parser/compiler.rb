module ABNF
  module Parser
    class Compiler
      attr_reader :rule_list
      attr_reader :token_stream
      attr_accessor :token

      def initialize token_stream, rule_list
        @rule_list = rule_list
        @token_stream = token_stream
      end

      def self.build token_stream, rule_list=nil
        rule_list ||= RuleList.new
        new token_stream, rule_list
      end

      def self.call *arguments
        instance = build *arguments
        instance.()
      end

      def call
        next_token

        while token
          rule
        end
      end

      def accept *token_identifiers
        if token_identifiers.include? token.identifier
          token = self.token
          next_token
          token
        end
      end

      def expect token_identifier
        unless token.identifier == token_identifier
          fail "Unexpected token #{token.identifier.inspect}; expected #{token_identifier.inspect}"
        end
        true
      end

      def logger
        Logging.get self
      end

      def next_token
        self.token = token_stream.shift
        logger.info "Advanced token stream; current token is #{token}"
        token
      end

      def alternation
        abnf = String.new
        elements = []

        loop do
          next_element = concatenation

          abnf << next_element.abnf
          elements << next_element

          delimiter = accept 'alternative-delimiter'

          if delimiter
            abnf << delimiter.abnf
          else
            break
          end
        end

        if elements.size == 1
          elements[0]
        else
          Element::Alternation.new abnf, elements
        end
      end

      def concatenation
        abnf = String.new
        elements = []

        loop do
          next_element = repetition

          abnf << next_element.abnf
          elements << next_element

          whitespace = accept 'whitespace'

          if whitespace
            abnf << whitespace.abnf
            break if token.identifier == 'newline'
          else
            break
          end
        end

        if elements.size == 1
          elements[0].abnf = abnf
          elements[0]
        else
          Element::Concatenation.new abnf, elements
        end
      end

      def element
        if prose_val = accept('prose-val')
          Element::Terminal::ProseVal.new prose_val.prose
        elsif char_val = accept('char-val')
          Element::Terminal::Sequence.new char_val.abnf, char_val.characters
        elsif num_val = accept('num-val')
          range = num_val.range

          if range
            Element::Terminal::Range.new num_val.abnf, range
          else
            Element::Terminal::Sequence.new num_val.abnf, num_val.characters
          end
        elsif option_start = accept('option-start')
          range = (0..1)
          element = alternation

          expect 'option-stop'

          abnf = option_start.abnf + element.abnf + self.token.abnf
          next_token

          Element::Repetition.new abnf, range, element
        elsif group_start = accept('group-start')
          element = alternation

          expect 'group-stop'

          abnf = group_start.abnf + element.abnf + self.token.abnf
          next_token

          element.abnf = abnf
          element
        elsif repeat = accept('repeat')
          element = alternation

          abnf = repeat.abnf + element.abnf

          Element::Repetition.new abnf, repeat.range, element
        elsif rulename = accept('rulename')
          Element::Reference.new rulename.abnf
        else
          fail
        end
      end

      def end_rule rule
        logger.info 'Ending rule'
        expect 'newline'
        rule.abnf_parts << token.abnf
        next_token
      end

      def repetition
        element
      end

      def rule
        rule = start_rule
        rule.element = alternation
        rule.abnf_parts << rule.element.abnf
        end_rule rule
        rule
      end

      def start_rule
        logger.info 'Starting rule'
        expect 'rulename'
        name = token.value
        next_token

        expect 'defined-as'

        if token.incremental_assignment?
          fail # XXX
        else
          rule = Rule.new name
          rule.abnf_parts << name
          rule.abnf_parts << token.abnf
          rule_list.add rule
        end

        next_token
        rule
      end

      module Assertions
        def defined_rule? rule_name, element
          rule_list[rule_name].element == element
        end
      end
    end
  end
end

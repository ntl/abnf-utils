module ABNF
  module Parser
    class Compiler
      attr_reader :rule_list
      attr_reader :tokens
      attr_accessor :token

      def initialize tokens, rule_list
        @rule_list = rule_list
        @tokens = tokens
      end

      def self.build tokens, rule_list=nil
        rule_list ||= RuleList.new
        new tokens, rule_list
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
        ExtendedLogger.get self.class
      end

      def next_token
        self.token = tokens.shift
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
          if next_element.nil?
            break
          end

          abnf << next_element.abnf
          elements << next_element

          whitespace = accept 'whitespace'

          if whitespace
            abnf << whitespace.abnf
          else
            break
          end
        end

        if elements.size == 1
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
          expect 'newline'
          nil
        end
      end

      def end_rule
        logger.info 'Ending rule'
        expect 'newline'
        next_token
      end

      def repetition
        element
      end

      def rule
        rule = start_rule
        rule.element = alternation
        end_rule
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

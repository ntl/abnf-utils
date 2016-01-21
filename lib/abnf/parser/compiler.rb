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
        rule
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

      def next_token
        self.token = tokens.shift
      end

      def alternation
        concatenation
      end

      def concatenation
        element = repetition

        if accept 'whitespace'
          elements = [element]
          fail # XXX
          repetition
        else
          element
        end
      end

      def element
        if token = accept('prose-val')
          Element::Terminal::ProseVal.new token.prose
        elsif token = accept('char-val')
          Element::Terminal::Sequence.new token.abnf, token.characters
        elsif token = accept('num-val')
          range = token.range

          if range
            Element::Terminal::Range.new token.abnf, range
          else
            Element::Terminal::Sequence.new token.abnf, token.characters
          end
        elsif option_start = accept('option-start')
          range = (0..1)
          element = alternation

          expect 'option-stop'

          abnf = option_start.abnf + element.abnf + self.token.abnf
          next_token

          Element::Repetition.new abnf, range, element
        else
          fail # XXX
        end
      end

      def end_rule
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

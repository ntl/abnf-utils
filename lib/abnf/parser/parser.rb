module ABNF
  module Parser
    class Parser
      attr_writer :rule_list

      def call tokens
        tokens = [tokens] unless tokens.is_a? Array

        Evaluation.(tokens, rule_list)

        unless tokens.empty?
          fail "Unexpected end of ABNF; next token #{tokens.first.identifier.inspect}"
        end
      end

      def rule_list
        @rule_list ||= RuleList.new
      end
    end
  end
end

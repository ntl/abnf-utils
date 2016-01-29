module ABNF
  module Parser
    def self.call abnf, rule_list=nil
      rule_list ||= RuleList.new

      tokens = Scanner.(abnf)
      Compiler.(tokens, rule_list)

      rule_list
    end
  end
end

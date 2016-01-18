module ABNF
  class RuleList
    def [] rule_name
      unless table.key? rule_name
        fail "Undefined rule #{rule_name.inspect}" # XXX
      end

      table[rule_name]
    end

    def add rule
      if table.key? rule.name
        fail "Already defined rule #{rule.name.inspect}" # XXX
      end

      table[rule.name] = rule
    end

    def table
      @table ||= {}
    end
  end
end

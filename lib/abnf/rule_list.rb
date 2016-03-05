module ABNF
  class RuleList
    def [] rule_name
      unless table.key? rule_name
        fail "Undefined rule #{rule_name.inspect}" # XXX
      end

      table[rule_name]
    end

    def abnf
      table.each_value.reduce String.new do |str, rule|
        str << rule.abnf
        str
      end
    end

    def add rule
      if table.key? rule.name
        fail "Already defined rule #{rule.name.inspect}" # XXX
      end

      table[rule.name] = rule
    end

    def rule_names
      table.keys
    end

    def size
      table.size
    end

    def table
      @table ||= {}
    end
  end
end

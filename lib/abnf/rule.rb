module ABNF
  class Rule < Struct.new :name, :element
    def abnf
      "#{name} = #{element.abnf}\r\n"
    end
  end
end

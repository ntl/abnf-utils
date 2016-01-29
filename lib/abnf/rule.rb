module ABNF
  class Rule < Struct.new :name, :element
    def abnf_parts
      @abnf ||= []
    end

    def abnf
      abnf_parts.join
    end
  end
end

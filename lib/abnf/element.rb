module ABNF
  module Element
    module Terminal
      class ProseVal < Struct.new :abnf
      end

      class Range < Struct.new :abnf, :range
      end

      class Sequence < Struct.new :abnf, :pattern
      end
    end

    class Alternation < Struct.new :abnf, :elements
    end

    class Concatenation < Struct.new :abnf, :elements
    end

    class Repetition < Struct.new :abnf, :range, :element
    end
  end
end

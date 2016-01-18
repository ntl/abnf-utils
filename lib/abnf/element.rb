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
  end
end

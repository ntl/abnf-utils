module ABNF
  module Parser
    class Token < Struct.new :abnf, :captures
      def inspect
        "#<#{self.class} #{type.inspect} #{abnf.inspect}>"
      end

      def type
        self.class.type
      end

      def self.build type, match
        abnf = match.to_s

        captures = match.names.each_with_object Hash.new do |name, hash|
          hash[name] = match[name]
        end

        subclass = Lookup[type]
        subclass.new abnf, captures
      end

      def self.inherited subclass
        Lookup.add subclass
      end
    end
  end
end

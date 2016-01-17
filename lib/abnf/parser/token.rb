module ABNF
  module Parser
    class Token < Struct.new :abnf, :captures
      def inspect
        captures = self.captures.map do |name, value|
          "#{name}=#{value.inspect}"
        end

        if captures.empty?
          "#<#{self.class} #{abnf.inspect}>"
        else
          "#<#{self.class} #{captures * ', '} #{abnf.inspect}>"
        end
      end

      def self.build type, match
        abnf = match.to_s

        captures = match.names.each_with_object Hash.new do |name, hash|
          hash[name] = match[name]
        end

        type.new abnf, captures
      end
    end
  end
end

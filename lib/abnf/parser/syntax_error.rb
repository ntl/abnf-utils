module ABNF
  module Parser
    class SyntaxError < StandardError
      attr_reader :abnf
      attr_reader :truncate_length

      def initialize abnf, truncate_length
        @abnf = abnf
        @truncate_length = truncate_length
      end

      def self.build abnf
        new abnf, 40
      end

      def formatted_abnf
        if truncate?
          abnf[0..(truncate_length - 4)] + ' ...'
        else
          abnf
        end
      end

      def to_s
        "Syntax error in ABNF material: #{formatted_abnf.inspect}#{" (cont'd)" if truncate?}"
      end

      def truncate?
        abnf.length > truncate_length
      end
    end
  end
end

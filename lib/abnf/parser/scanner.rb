module ABNF
  module Parser
    class Scanner
      attr_writer :patterns
      attr_writer :token_count
      attr_writer :token_stream

      def self.build token_stream=nil
        token_stream ||= Token::Stream.new

        instance = new
        instance.token_stream = token_stream
        instance
      end

      def [] name
        table.fetch name
      end

      def call abnf
        logger.info "Starting scan (Characters: #{abnf.size})"
        logger.debug do abnf end

        until abnf.empty?
          token, abnf = self.next abnf

          push_token token
        end

        logger.info "Finished scan (Tokens: #{token_count})"
      end

      def increment_token_count
        self.token_count += 1
      end

      def inspect
        "#<#{self.class.name} token_count=#{token_count}>"
      end

      def logger
        ExtendedLogger.get self.class
      end

      def next abnf
        token = nil

        patterns.each do |pattern, type|
          match = pattern.match abnf
          next unless match

          token = type.build match
          abnf = match.post_match

          return token, abnf
        end

        raise SyntaxError.build abnf unless token
      end

      def patterns
        @patterns ||= Patterns
      end

      def push_token token
        logger.debug token.inspect

        increment_token_count

        token_stream << token
      end

      def token_count
        @token_count ||= 0
      end

      def token_stream
        @token_stream ||= []
      end

      module Assertions
        def output? expected_tokens
          expected_tokens = [expected_tokens] unless expected_tokens.is_a? Array

          actual_tokens = token_stream.last expected_tokens.size

          actual_tokens == expected_tokens
        end

        def scanned? expected_abnf
          abnf_per_token = token_stream.map &:abnf

          actual_abnf = abnf_per_token.join

          actual_abnf == expected_abnf
        end
      end
    end
  end
end

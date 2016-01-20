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
        def scanned? expected_abnf
          actual_abnf = token_stream.map &:abnf
          actual_abnf *= ''

          actual_abnf == expected_abnf
        end

        # Returns true if an equivalent copy of the input token is created as
        # the result of scanning its ABNF grammar.
        def token_rescannable? expected_token
          abnf = expected_token.abnf

          self.(abnf)

          actual_token = token_stream.last

          actual_token == expected_token
        end
      end
    end
  end
end

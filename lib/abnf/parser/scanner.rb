module ABNF
  module Parser
    class Scanner
      attr_writer :patterns
      attr_writer :token_stream

      def self.build token_stream
        token_stream ||= Token::Stream.new

        instance = new
        instance.token_stream = token_stream
        instance
      end

      def [] name
        table.fetch name
      end

      def call abnf
        logger.info "Starting scan (Bytes: #{abnf.bytesize})"
        logger.debug do abnf end

        token_count = 0

        until abnf.empty?
          token, abnf = self.next abnf

          logger.debug token.inspect

          token_stream << token
          token_count += 1
        end

        logger.info "Finished scan (Tokens: #{token_count})"
      end

      def next abnf
        token = nil

        patterns.each do |type, pattern|
          match = pattern.match abnf
          next unless match

          token = Token.build type, match
          abnf = match.post_match

          return token, abnf
        end

        raise SyntaxError.build abnf unless token
      end

      def logger
        @@logger ||= ExtendedLogger.get self.class
      end

      def patterns
        @patterns ||= Patterns
      end

      def token_stream
        @token_stream ||= []
      end

      module Assertions
        def scan? abnf, expected_token_types
          self.(abnf)

          token_sources = token_stream.map &:abnf
          token_types = token_stream.map &:type

          token_sources.join == abnf and token_types == expected_token_types
        end
      end
    end
  end
end

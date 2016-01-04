module ABNF
  module Parser
    class Token
      class Stream
        def << token
          tokens << token
        end

        def source
          tokens = self.tokens.map &:source
          tokens.join
        end

        def tokens
          @tokens ||= []
        end

        def types
          tokens.map &:type
        end

        module Assertions
          def source_matches expected_abnf
            self.source == expected_abnf
          end
        end
      end
    end
  end
end

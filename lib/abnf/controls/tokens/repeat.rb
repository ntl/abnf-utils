module ABNF
  module Controls
    module Tokens
      module Repeat
        def self.example
          any
        end

        def self.any
          abnf = Controls::ABNF::Repeat.any
          Parser::Tokens::Repeat.new abnf, 'low' => '', 'high' => ''
        end

        def self.fixed
          abnf = Controls::ABNF::Repeat.fixed
          Parser::Tokens::Repeat.new abnf, 'low' => '2', 'high' => '2'
        end

        def self.bounded_range
          abnf = Controls::ABNF::Repeat.bounded_range
          Parser::Tokens::Repeat.new abnf, 'low' => '1', 'high' => '2'
        end
      end
    end
  end
end

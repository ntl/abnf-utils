module ABNF
  module Controls
    module Tokens
      module Repeat
        def self.example
          any_number
        end

        def self.any_number
          abnf = Controls::ABNF::Repeat.any_number
          Parser::Tokens::Repeat.new abnf, 'minimum' => '', 'maximum' => ''
        end

        def self.fixed
          abnf = Controls::ABNF::Repeat.fixed
          Parser::Tokens::Repeat.new abnf, 'minimum' => '2', 'maximum' => '2'
        end

        def self.bounded_range
          abnf = Controls::ABNF::Repeat.bounded_range
          Parser::Tokens::Repeat.new abnf, 'minimum' => '1', 'maximum' => '2'
        end
      end
    end
  end
end

module ABNF
  module Controls
    module Source
      module Repeat
        def self.example
          any_number
        end

        def self.any_number
          '*'
        end

        def self.fixed
          range = Values::Repetition.fixed

          count = range.first
          count.to_s
        end

        def self.bounded_range
          range = Values::Repetition.bounded_range

          "#{range.first}*#{range.last}"
        end
      end
    end
  end
end

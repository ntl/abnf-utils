module ABNF
  module Controls
    module Values
      module Repetition
        def self.example
          any_number
        end

        def self.any_number
          (0..Float::INFINITY)
        end

        def self.bounded_range
          (1..2)
        end

        def self.fixed
          (2..2)
        end
      end
    end
  end
end

module ABNF
  module Controls
    module ABNF
      module Repeat
        def self.example
          any
        end

        def self.any
          '*'
        end

        def self.fixed count=nil
          count ||= Values::Repetition.fixed
          count.to_s
        end

        def self.bounded_range range=nil
          range ||= Values::Repetition.bounded_range
          "#{range.first}*#{range.last}"
        end
      end
    end
  end
end

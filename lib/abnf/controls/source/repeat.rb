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

        def self.fixed count=nil
          range ||= Values::Repetition.fixed
          count = range.first
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

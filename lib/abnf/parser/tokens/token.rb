module ABNF
  module Parser
    module Tokens
      class Token < Struct.new :abnf, :captures
        def inspect
          captures = self.captures.map do |name, value|
            "#{name}=#{value.inspect}"
          end

          if captures.empty?
            "#<#{self.class} #{abnf.inspect}>"
          else
            "#<#{self.class} #{captures * ', '} #{abnf.inspect}>"
          end
        end

        def identifier
          self.class.identifier
        end

        def self.identifier
          @identifier ||=
            begin
              *, identifier = name.split '::'

              identifier.gsub! /(?:\A|[a-z])[A-Z]/ do |part|
                part.downcase!

                if part.size == 1
                  part
                else
                  part.insert 1, '-'
                end
              end

              identifier
            end
        end

        def self.build match
          abnf = match.to_s

          captures = match.names.each_with_object Hash.new do |name, hash|
            hash[name] = match[name]
          end

          new abnf, captures
        end
      end
    end
  end
end

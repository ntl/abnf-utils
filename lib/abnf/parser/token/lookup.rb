module ABNF
  module Parser
    class Token
      class Lookup
        def self.[] type
          instance[type]
        end

        def self.add subclass
          instance.add subclass
        end

        def self.instance
          @instance ||= new
        end

        def [] type
          table[type]
        end

        def add subclass
          subclasses << subclass
        end

        def subclasses
          @subclasses ||= []
        end

        def table
          @table ||= subclasses.each_with_object Hash.new do |cls, hash|
            hash[cls.type] = cls
          end
        end
      end
    end
  end
end

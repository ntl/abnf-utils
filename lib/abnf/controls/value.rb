module ABNF
  module Controls
    module Value
      def self.define value=nil, &block
        mod = Module.new

        block ||= -> do value end

        mod.define_singleton_method :value, &block

        mod
      end
    end
  end
end

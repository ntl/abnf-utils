module ABNF
  module Logging
    extend self

    attr_accessor :registry

    self.registry = ExtendedLogger::Registry.build ExtendedLogger::Logger

    def get receiver
      registry.get receiver
    end
  end
end

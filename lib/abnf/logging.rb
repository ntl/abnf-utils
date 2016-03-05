module ABNF
  module Logging
    extend self

    attr_accessor :registry

    color_scheme = ExtendedLogger::ColorScheme.build(
      :debug => :cyan,
      :warn => :brown,
      :error => :red,
      :fatal => { :fg => :white, :bg => :red },
    )

    self.registry = ExtendedLogger::Registry.build(
      ExtendedLogger::Logger,
      :color_scheme => color_scheme,
    )

    def get receiver
      registry.get receiver
    end
  end
end

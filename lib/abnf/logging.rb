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

    levels = ExtendedLogger::Level::Set.build(
      %i(data trace debug info warn error fatal),
      :default => :info,
    )

    Logger = ExtendedLogger.define levels, :color_scheme => :color_scheme

    self.registry = ExtendedLogger::Registry.build(
      Logger,
      :color_scheme => color_scheme,
    )

    registry.level = ENV['LOG_LEVEL'] if ENV['LOG_LEVEL']

    def get receiver
      registry.get receiver
    end
  end
end

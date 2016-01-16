require_relative '../init'

logger = ExtendedLogger::Logger.build(
  $stdout,
  :always_interpolate => true,
  :color_scheme => true,
)
logger.level = ENV['LOG_LEVEL'] if ENV['LOG_LEVEL']
ExtendedLogger.configure logger

require 'test_bench'; TestBench.activate

require 'abnf/controls'

Controls = ABNF::Controls

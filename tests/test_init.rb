require_relative '../init'

ExtendedLogger.logger = ExtendedLogger::Logger.build(
  $stdout,
  :always_interpolate => true,
  :color_scheme => true,
)

require 'test_bench'; TestBench.activate

require 'abnf/controls'

Controls = ABNF::Controls

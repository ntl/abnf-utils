ENV['LOG_LEVEL'] ||= 'trace'

require_relative '../init'

require 'test_bench/activate'

require 'abnf/controls'

Controls = ABNF::Controls

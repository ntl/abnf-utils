require_relative './parser_tests_init'

context 'Scanner' do
  scanner = Parser::Scanner.new

  test 'Rule' do
    abnf = Controls::ABNF::SingleTerminal.value

    assert scanner do |scanner|
      scanner.scan? abnf, %w(rulename defined-as hex-val c-nl)
    end
  end
end

require_relative './parser_tests_init'

context 'Parser' do
  test 'RFC 5234' do
    abnf = Controls::Source::RFC5234.value

    rule_list = Parser.(abnf)

    assert rule_list.abnf == abnf
  end
end

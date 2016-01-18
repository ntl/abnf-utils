require_relative './parser_tests_init'

context 'Syntax Error' do
  abnf = Controls::ABNF.bad_syntax

  test 'Message' do
    error = Parser::SyntaxError.build abnf

    assert error.message == %{Syntax error in ABNF material: "#{abnf}"}
  end

  test 'Truncating' do
    error = Parser::SyntaxError.new abnf, 4

    assert error.message == %{Syntax error in ABNF material: "#{abnf[0]} ..." (cont'd)}
  end
end

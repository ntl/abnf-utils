require_relative '../test_init'

context "Syntax Error" do
  abnf = Controls::Source.bad_syntax

  test "Message" do
    error = ABNF::Parser::SyntaxError.build abnf

    assert error.message == %{Syntax error in ABNF material: "#{abnf}"}
  end

  test "Truncating" do
    error = ABNF::Parser::SyntaxError.new abnf, 4

    assert error.message == %{Syntax error in ABNF material: "#{abnf[0]} ..." (cont'd)}
  end
end

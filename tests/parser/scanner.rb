require_relative './parser_tests_init'

context 'Scanner' do
  scanner = Parser::Scanner.new

  context 'NumVal' do
    %w(BinVal DecVal HexVal).each do |base|
      %w(Single Range Sequence).each do |variant|
        test "#{base} #{variant}" do
          abnf, expected_token = Controls::Tokens::Elements::NumVal.pair base, variant

          assert scanner do |scanner|
            scanner.scan? abnf, [expected_token]
          end
        end
      end
    end
  end

  test 'CharVal' do
    abnf = Controls::ABNF::Elements::CharVal.value
    token = Controls::Tokens::Elements::CharVal.value

    assert scanner do |scanner|
      scanner.scan? abnf, [token]
    end
  end

  test 'Full Rule' do
    abnf = Controls::ABNF::SingleTerminal.value

    assert scanner do |scanner|
      expected_stream = [
        Controls::Tokens::Rulename.value,
        Controls::Tokens::DefinedAs.value,
        Controls::Tokens::Elements::Terminal.value,
        Controls::Tokens::C_NL.value,
      ]

      scanner.scan? abnf, expected_stream
    end
  end
end

require_relative './parser_tests_init'

context 'Scanner' do
  scanner = Parser::Scanner.new

  context 'Numeric Values' do
    %w(BinVal DecVal HexVal).each do |base|
      %w(Single Range Sequence).each do |variant|
        test "#{base} #{variant}" do
          abnf, token = Controls::Tokens::TerminalElements::NumVal.pair base, variant

          scanner.(abnf)

          assert scanner do |scanner|
            scanner.scanned? token
          end
        end
      end
    end
  end

  test 'Character Values' do
    abnf = Controls::ABNF::CharVal.value
    token = Controls::Tokens::TerminalElements::CharVal.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.scanned? token
    end
  end

  test 'Prose Values' do
    abnf = Controls::ABNF::ProseVal.value
    token = Controls::Tokens::TerminalElements::ProseVal.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.scanned? token
    end
  end

  test 'Start of Option' do
    abnf = Controls::ABNF::OptionStart.value
    token = Controls::Tokens::OptionStart.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.scanned? token
    end
  end

  test 'Option Stop' do
    abnf = Controls::ABNF::OptionStop.value
    token = Controls::Tokens::OptionStop.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.scanned? token
    end
  end

  test 'Start of Group' do
    abnf = Controls::ABNF::GroupStart.value
    token = Controls::Tokens::GroupStart.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.scanned? token
    end
  end

  test 'Group Stop' do
    abnf = Controls::ABNF::GroupStop.value
    token = Controls::Tokens::GroupStop.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.scanned? token
    end
  end

  context 'Repeat' do
    test 'Any' do
      abnf = Controls::ABNF::Repeat::Any.value
      token = Controls::Tokens::Repeat::Any.value

      scanner.(abnf)

      assert scanner do |scanner|
        scanner.scanned? token
      end
    end

    test 'Fixed' do
      abnf = Controls::ABNF::Repeat::Fixed.value
      token = Controls::Tokens::Repeat::Fixed.value

      scanner.(abnf)

      assert scanner do |scanner|
        scanner.scanned? token
      end
    end

    test 'Range' do
      abnf = Controls::ABNF::Repeat::Range.value
      token = Controls::Tokens::Repeat::Range.value

      scanner.(abnf)

      assert scanner do |scanner|
        scanner.scanned? token
      end
    end
  end

  test 'Alternative Delimiter' do
    abnf = Controls::ABNF::AlternativeDelimiter.value
    token = Controls::Tokens::AlternativeDelimiter.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.scanned? token
    end
  end

  test 'Full Rule' do
    abnf = Controls::ABNF::SingleTerminal.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.scanned? [
        Controls::Tokens::Rulename.value,
        Controls::Tokens::DefinedAs.value,
        Controls::Tokens::TerminalElements.example,
        Controls::Tokens::C_NL.value,
      ]
    end
  end

  test 'RFC 5234' do
    abnf = Controls::ABNF::RFC5234.value

    scanner.(abnf)
  end
end

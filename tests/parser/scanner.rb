require_relative './parser_tests_init'

context 'Scanner' do
  context 'Numeric Values' do
    %w(BinVal DecVal HexVal).each do |base|
      %w(Single Range Sequence).each do |variant|
        test "#{base} #{variant}" do
          scanner = ABNF::Parser::Scanner.new
          abnf, token = Controls::Tokens::TerminalElements::NumVal.pair base, variant

          scanner.(abnf)

          assert scanner do |scanner|
            scanner.output? token
          end
        end
      end
    end
  end

  test 'Character Values' do
    scanner = ABNF::Parser::Scanner.new
    abnf = Controls::ABNF.char_val
    token = Controls::Tokens::TerminalElements::CharVal.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.output? token
    end
  end

  test 'Prose Values' do
    scanner = ABNF::Parser::Scanner.new
    abnf = Controls::ABNF::ProseVal.value
    token = Controls::Tokens::TerminalElements::ProseVal.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.output? token
    end
  end

  test 'Start of Option' do
    scanner = ABNF::Parser::Scanner.new
    abnf = Controls::ABNF::OptionStart.value
    token = Controls::Tokens::OptionStart.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.output? token
    end
  end

  test 'Option Stop' do
    scanner = ABNF::Parser::Scanner.new
    abnf = Controls::ABNF::OptionStop.value
    token = Controls::Tokens::OptionStop.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.output? token
    end
  end

  test 'Start of Group' do
    scanner = ABNF::Parser::Scanner.new
    abnf = Controls::ABNF.group_start
    token = Controls::Tokens::GroupStart.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.output? token
    end
  end

  test 'Group Stop' do
    scanner = ABNF::Parser::Scanner.new
    abnf = Controls::ABNF.group_stop
    token = Controls::Tokens::GroupStop.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.output? token
    end
  end

  context 'Repeat' do
    test 'Any' do
      scanner = ABNF::Parser::Scanner.new
      abnf = Controls::ABNF::Repeat::Any.value
      token = Controls::Tokens::Repeat::Any.value

      scanner.(abnf)

      assert scanner do |scanner|
        scanner.output? token
      end
    end

    test 'Fixed' do
      scanner = ABNF::Parser::Scanner.new
      abnf = Controls::ABNF::Repeat::Fixed.value
      token = Controls::Tokens::Repeat::Fixed.value

      scanner.(abnf)

      assert scanner do |scanner|
        scanner.output? token
      end
    end

    test 'Range' do
      scanner = ABNF::Parser::Scanner.new
      abnf = Controls::ABNF::Repeat::Range.value
      token = Controls::Tokens::Repeat::Range.value

      scanner.(abnf)

      assert scanner do |scanner|
        scanner.output? token
      end
    end
  end

  test 'Alternative Delimiter' do
    scanner = ABNF::Parser::Scanner.new
    abnf = Controls::ABNF.alternative_delimiter
    token = Controls::Tokens::AlternativeDelimiter.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.output? token
    end
  end

  test 'RFC 5234' do
    scanner = ABNF::Parser::Scanner.new
    abnf = Controls::ABNF::RFC5234.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.scanned? abnf
    end
  end
end

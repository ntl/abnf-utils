require_relative './parser_tests_init'

context 'Scanner' do
  scanner = ABNF::Parser::Scanner.new

  context 'Numeric Values' do
    %w(BinVal DecVal HexVal).each do |base|
      %w(Single Sequence Range).each do |variant|
        method_name = variant.downcase

        test "#{base} #{variant}" do
          token = Controls::Tokens::Terminal::NumVal.get base, method_name

          assert scanner do |scanner|
            scanner.token_rescannable? token
          end
        end
      end
    end
  end

  test 'Character Values' do
    token = Controls::Tokens::Terminal.char_val

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test 'Prose Values' do
    token = Controls::Tokens::Terminal.prose_val

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test 'Start of Option' do
    token = Controls::Tokens.option_start

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test 'Option Stop' do
    token = Controls::Tokens.option_stop

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test 'Start of Group' do
    token = Controls::Tokens.group_start

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test 'Group Stop' do
    token = Controls::Tokens.group_stop

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  context 'Repeat' do
    test 'Any Number' do
      token = Controls::Tokens::Repeat.any_number

      assert scanner do |scanner|
        scanner.token_rescannable? token
      end
    end

    test 'Fixed' do
      token = Controls::Tokens::Repeat.fixed

      assert scanner do |scanner|
        scanner.token_rescannable? token
      end
    end

    test 'Bounded Range' do
      token = Controls::Tokens::Repeat.bounded_range

      assert scanner do |scanner|
        scanner.token_rescannable? token
      end
    end
  end

  test 'Alternative Delimiter' do
    token = Controls::Tokens.alternative_delimiter

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test 'Newline' do
    token = Controls::Tokens.newline

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test 'Assignment' do
    token = Controls::Tokens.assignment

    assert scanner do |scanner|
      scanner.token_rescannable? token
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

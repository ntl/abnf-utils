require_relative '../test_init'

context "Scanner" do
  scanner = ABNF::Parser::Scanner.new

  context "Numeric Values" do
    Controls::Values.num_val_bases.each do |label, base|
      %w(single sequence range).each do |variant|
        test "#{label} #{variant}" do
          token = Controls::Parser::Tokens::NumVal.example base, variant

          assert scanner do |scanner|
            scanner.token_rescannable? token
          end
        end
      end
    end
  end

  test "Character Values" do
    token = Controls::Parser::Tokens.char_val

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test "Prose Values" do
    token = Controls::Parser::Tokens.prose_val

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test "Start of Option" do
    token = Controls::Parser::Tokens.option_start

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test "Option Stop" do
    token = Controls::Parser::Tokens.option_stop

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test "Start of Group" do
    token = Controls::Parser::Tokens.group_start

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test "Group Stop" do
    token = Controls::Parser::Tokens.group_stop

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  context "Repeat" do
    test "Any Number" do
      token = Controls::Parser::Tokens::Repeat.any_number

      assert scanner do |scanner|
        scanner.token_rescannable? token
      end
    end

    test "Fixed" do
      token = Controls::Parser::Tokens::Repeat.fixed

      assert scanner do |scanner|
        scanner.token_rescannable? token
      end
    end

    test "Bounded Range" do
      token = Controls::Parser::Tokens::Repeat.bounded_range

      assert scanner do |scanner|
        scanner.token_rescannable? token
      end
    end
  end

  context "Whitespace" do
    test "Single Space" do
      whitespace = Controls::Source.whitespace
      token = Controls::Parser::Tokens.whitespace whitespace

      assert scanner do |scanner|
        scanner.token_rescannable? token
      end
    end

    test "Comments" do
      token = Controls::Parser::Tokens.whitespace " ; some-comment\r\n "

      assert scanner do |scanner|
        scanner.token_rescannable? token
      end
    end
  end

  test "Alternative Delimiter" do
    token = Controls::Parser::Tokens.alternative_delimiter

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test "Newline" do
    token = Controls::Parser::Tokens.newline

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test "Assignment" do
    token = Controls::Parser::Tokens.assignment

    assert scanner do |scanner|
      scanner.token_rescannable? token
    end
  end

  test "RFC 5234" do
    scanner = ABNF::Parser::Scanner.new
    abnf = Controls::Source::RFC5234.value

    scanner.(abnf)

    assert scanner do |scanner|
      scanner.scanned? abnf
    end
  end
end

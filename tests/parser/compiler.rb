require_relative './parser_tests_init'

context 'Recursive Descent Parser' do
  rule_name = Controls::Values.rulename

  context 'Terminal Elements' do
    context 'Numeric Values' do
      %w(BinVal DecVal HexVal).each do |base|
        %w(Single Sequence Range).each do |variant|
          method_name = variant.downcase

          test "#{base} #{variant}" do
            token = Controls::Tokens::Terminal::NumVal.get base, method_name
            expected_element = Controls::Elements::Terminal::NumVal.get base, method_name
            tokens, expected_element = Controls::TokenStreams.example token, element: expected_element

            compiler = ABNF::Parser::Compiler.build tokens

            compiler.()

            assert compiler do |compiler|
              compiler.defined_rule? rule_name, expected_element
            end
          end
        end
      end
    end

    test 'Prose Values' do
      token = Controls::Tokens::Terminal.prose_val
      expected_element = Controls::Elements::Terminal.prose_val
      tokens, expected_element = Controls::TokenStreams.example token, element: expected_element

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_element
      end
    end

    test 'Character Values' do
      token = Controls::Tokens::Terminal.char_val
      expected_element = Controls::Elements::Terminal.char_val
      tokens, expected_element = Controls::TokenStreams.example token, element: expected_element

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_element
      end
    end
  end

  test 'Option' do
    tokens, expected_element = Controls::TokenStreams.group

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_element
    end
  end

  test 'Group' do
    tokens, expected_element = Controls::TokenStreams.group

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_element
    end
  end

  context 'Repetition' do
    test 'Any Number' do
      tokens, expected_element = Controls::TokenStreams::Repetition.any_number

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_element
      end
    end

    test 'Fixed' do
      tokens, expected_element = Controls::TokenStreams::Repetition.fixed

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_element
      end
    end

    test 'Bounded Range' do
      tokens, expected_element = Controls::TokenStreams::Repetition.bounded_range

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_element
      end
    end
  end

  test 'Concatenation' do
    tokens, expected_element = Controls::TokenStreams.concatenation

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_element
    end
  end

  test 'Alternation' do
    tokens, expected_element = Controls::TokenStreams.alternation

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_element
    end
  end

  test 'Reference to another rule' do
    tokens, expected_element = Controls::TokenStreams.reference

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_element
    end
  end

  test 'Incremental assignment'

  test 'RFC 5234' do
    abnf = Controls::ABNF::RFC5234.value
    scanner = ABNF::Parser::Scanner.new
    scanner.(abnf)
    tokens = scanner.token_stream

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler.rule_list.abnf == abnf
  end
end

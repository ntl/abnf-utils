require_relative './parser_tests_init'

context 'Recursive Descent Parser' do
  rule_name = Controls::Values.rulename

  context 'Terminal Nodes' do
    context 'Numeric Values' do
      %w(BinVal DecVal HexVal).each do |base|
        %w(Single Sequence Range).each do |variant|
          method_name = variant.downcase

          test "#{base} #{variant}" do
            token = Controls::Tokens::Terminal::NumVal.get base, method_name
            expected_node = Controls::Nodes::Terminal::NumVal.get base, method_name
            tokens, expected_node = Controls::TokenStreams.example token, node: expected_node

            compiler = ABNF::Parser::Compiler.build tokens

            compiler.()

            assert compiler do
              defined_rule? rule_name, expected_node
            end
          end
        end
      end
    end

    test 'Prose Values' do
      token = Controls::Tokens::Terminal.prose_val
      expected_node = Controls::Nodes::Terminal.prose_val
      tokens, expected_node = Controls::TokenStreams.example token, node: expected_node

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_node
      end
    end

    test 'Character Values' do
      token = Controls::Tokens::Terminal.char_val
      expected_node = Controls::Nodes::Terminal.char_val
      tokens, expected_node = Controls::TokenStreams.example token, node: expected_node

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_node
      end
    end
  end

  test 'Option' do
    tokens, expected_node = Controls::TokenStreams.group

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_node
    end
  end

  test 'Group' do
    tokens, expected_node = Controls::TokenStreams.group

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_node
    end
  end

  context 'Repetition' do
    test 'Any Number' do
      tokens, expected_node = Controls::TokenStreams::Repetition.any_number

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_node
      end
    end

    test 'Fixed' do
      tokens, expected_node = Controls::TokenStreams::Repetition.fixed

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_node
      end
    end

    test 'Bounded Range' do
      tokens, expected_node = Controls::TokenStreams::Repetition.bounded_range

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_node
      end
    end
  end

  test 'Concatenation' do
    tokens, expected_node = Controls::TokenStreams.concatenation

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_node
    end
  end

  test 'Alternation' do
    tokens, expected_node = Controls::TokenStreams.alternation

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_node
    end
  end

  test 'Reference to another rule' do
    tokens, expected_node = Controls::TokenStreams.reference

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_node
    end
  end

  test 'Incremental assignment'
end

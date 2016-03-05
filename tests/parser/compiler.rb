require_relative './parser_tests_init'

context 'Recursive Descent Parser' do
  rule_name = Controls::Values.rulename

  context 'Terminal Nodes' do
    context 'Numeric Values' do
      %w(BinVal DecVal HexVal).each do |base|
        %w(Single Sequence Range).each do |variant|
          method_name = variant.downcase

          test "#{base} #{variant}" do
            token = Controls::Parser::Tokens::Terminal::NumVal.get base, method_name
            expected_node = Controls::AST::Nodes::Terminal::NumVal.get base, method_name
            tokens, expected_node = Controls::Parser::CompilerScenarios::Factory.([token], expected_node)

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
      token = Controls::Parser::Tokens::Terminal.prose_val
      expected_node = Controls::AST::Nodes::Terminal.prose_val
      tokens, expected_node = Controls::Parser::CompilerScenarios::Factory.([token], expected_node)

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_node
      end
    end

    test 'Character Values' do
      token = Controls::Parser::Tokens::Terminal.char_val
      expected_node = Controls::AST::Nodes::Terminal.char_val
      tokens, expected_node = Controls::Parser::CompilerScenarios::Factory.([token], expected_node)

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_node
      end
    end
  end

  test 'Option' do
    tokens, expected_node = Controls::Parser::CompilerScenarios.group

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_node
    end
  end

  test 'Group' do
    tokens, expected_node = Controls::Parser::CompilerScenarios.group

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_node
    end
  end

  context 'Repetition' do
    test 'Any Number' do
      tokens, expected_node = Controls::Parser::CompilerScenarios::Repetition.any_number

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_node
      end
    end

    test 'Fixed' do
      tokens, expected_node = Controls::Parser::CompilerScenarios::Repetition.fixed

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_node
      end
    end

    test 'Bounded Range' do
      tokens, expected_node = Controls::Parser::CompilerScenarios::Repetition.bounded_range

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, expected_node
      end
    end
  end

  test 'Concatenation' do
    tokens, expected_node = Controls::Parser::CompilerScenarios.concatenation

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_node
    end
  end

  test 'Alternation' do
    tokens, expected_node = Controls::Parser::CompilerScenarios.alternation

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_node
    end
  end

  test 'Reference to another rule' do
    tokens, expected_node = Controls::Parser::CompilerScenarios.reference

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      compiler.defined_rule? rule_name, expected_node
    end
  end

  test 'Incremental assignment'
end

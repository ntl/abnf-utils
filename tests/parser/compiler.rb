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
            tokens = Controls::Tokens.rule token

            compiler = ABNF::Parser::Compiler.build tokens

            compiler.()

            assert compiler do |compiler|
              expected_element = Controls::Elements::Terminal::NumVal.get base, method_name
              compiler.defined_rule? rule_name, expected_element
            end
          end
        end
      end
    end

    test 'Prose Values' do
      token = Controls::Tokens::Terminal.prose_val
      tokens = Controls::Tokens.rule token

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, Controls::Elements::Terminal.prose_val
      end
    end

    test 'Character Values' do
      token = Controls::Tokens::Terminal.char_val
      tokens = Controls::Tokens.rule token

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        compiler.defined_rule? rule_name, Controls::Elements::Terminal.char_val
      end
    end

    test 'Option' do
      tokens = Controls::Tokens.rule(
        Controls::Tokens.option_start,
        Controls::Tokens::Terminal.char_val,
        Controls::Tokens.option_stop,
      )

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        terminal_element = Controls::Elements::Terminal.char_val
        optional_element = Controls::Elements.optional terminal_element

        compiler.defined_rule? rule_name, optional_element
      end
    end
  end
end

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

  test 'Group' do
    tokens = Controls::Tokens.rule(
      Controls::Tokens.group_start,
      Controls::Tokens::Terminal.example,
      Controls::Tokens.group_stop,
    )

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      terminal_element = Controls::Elements::Terminal.example
      group_element = Controls::Elements.group terminal_element

      compiler.defined_rule? rule_name, group_element
    end
  end

  context 'Repetition' do
    test 'Any Number' do
      tokens = Controls::Tokens.rule(
        Controls::Tokens::Repeat.any_number,
        Controls::Tokens::Terminal.example,
      )

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        terminal_element = Controls::Elements::Terminal.example
        repetition_element = Controls::Elements::Repetition.any_number terminal_element

        compiler.defined_rule? rule_name, repetition_element
      end
    end

    test 'Fixed' do
      tokens = Controls::Tokens.rule(
        Controls::Tokens::Repeat.fixed,
        Controls::Tokens::Terminal.example,
      )

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        terminal_element = Controls::Elements::Terminal.example
        repetition_element = Controls::Elements::Repetition.fixed terminal_element

        compiler.defined_rule? rule_name, repetition_element
      end
    end

    test 'Bounded Range' do
      tokens = Controls::Tokens.rule(
        Controls::Tokens::Repeat.bounded_range,
        Controls::Tokens::Terminal.example,
      )

      compiler = ABNF::Parser::Compiler.build tokens

      compiler.()

      assert compiler do |compiler|
        terminal_element = Controls::Elements::Terminal.example
        repetition_element = Controls::Elements::Repetition.bounded_range terminal_element

        compiler.defined_rule? rule_name, repetition_element
      end
    end
  end

  test 'Concatenation' do
    strings = Controls::Values.concatenation.first 2

    tokens = Controls::Tokens.rule(
      Controls::Tokens::Terminal.char_val(strings[0]),
      Controls::Tokens.whitespace,
      Controls::Tokens::Terminal.char_val(strings[1]),
    )

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      elements = strings.map do |string|
        Controls::Elements::Terminal.char_val string
      end
      concatenation_element = Controls::Elements.concatenation elements

      compiler.defined_rule? rule_name, concatenation_element
    end
  end

  test 'Alternation' do
    strings = Controls::Values.alternation.first 2

    tokens = Controls::Tokens.rule(
      Controls::Tokens::Terminal.char_val(strings[0]),
      Controls::Tokens.alternative_delimiter,
      Controls::Tokens::Terminal.char_val(strings[1]),
    )

    compiler = ABNF::Parser::Compiler.build tokens

    compiler.()

    assert compiler do |compiler|
      elements = strings.map do |string|
        Controls::Elements::Terminal.char_val string
      end
      alternation_element = Controls::Elements.alternation elements

      compiler.defined_rule? rule_name, alternation_element
    end
  end
end

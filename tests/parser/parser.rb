require_relative './parser_tests_init'

context 'Parser' do
  context 'Terminal Elements' do
    test 'Prose Values' do
      rule_list = ABNF::RuleList.new
      parser = ABNF::Parser::Parser.new
      parser.rule_list = rule_list

      parser.([
        Controls::Tokens::Rulename.value('some-rule'),
        Controls::Tokens::DefinedAs.value,
        Controls::Tokens::Terminal.prose_val,
        Controls::Tokens::Newline.value,
      ])

      assert rule_list['some-rule'].element == Controls::Elements::ProseVal.value
    end

    test 'Character Values' do
      rule_list = ABNF::RuleList.new
      parser = ABNF::Parser::Parser.new
      parser.rule_list = rule_list

      parser.([
        Controls::Tokens::Rulename.value,
        Controls::Tokens::DefinedAs.value,
        Controls::Tokens::Terminal.char_val,
        Controls::Tokens::Newline.value,
      ])

      assert rule_list['some-rule'].element == Controls::Elements::CharVal.value
    end

    context 'Numeric Values' do
      test 'Range' do
        rule_list = ABNF::RuleList.new
        parser = ABNF::Parser::Parser.new
        parser.rule_list = rule_list

        parser.([
          Controls::Tokens::Rulename.value,
          Controls::Tokens::DefinedAs.value,
          Controls::Tokens::Terminal::NumVal::BinVal.range,
          Controls::Tokens::Newline.value,
        ])

        assert rule_list['some-rule'].element == Controls::Elements::NumVal::Range.value
      end

      test 'Sequence' do
        rule_list = ABNF::RuleList.new
        parser = ABNF::Parser::Parser.new
        parser.rule_list = rule_list

        parser.([
          Controls::Tokens::Rulename.value,
          Controls::Tokens::DefinedAs.value,
          Controls::Tokens::Terminal::NumVal::DecVal.sequence,
          Controls::Tokens::Newline.value,
        ])

        assert rule_list['some-rule'].element == Controls::Elements::NumVal::Sequence.value
      end

      test 'Single' do
        rule_list = ABNF::RuleList.new
        parser = ABNF::Parser::Parser.new
        parser.rule_list = rule_list

        parser.([
          Controls::Tokens::Rulename.value,
          Controls::Tokens::DefinedAs.value,
          Controls::Tokens::Terminal::NumVal::HexVal.single,
          Controls::Tokens::Newline.value,
        ])

        assert rule_list['some-rule'].element == Controls::Elements::NumVal::Single.value
      end
    end
  end
end

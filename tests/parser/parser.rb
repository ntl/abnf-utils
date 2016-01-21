require_relative './parser_tests_init'

context 'Parser' do
  context 'Terminal Elements' do
    context 'Numeric Values' do
      %w(BinVal DecVal HexVal).each do |base|
        %w(Single Sequence Range).each do |variant|
          method_name = variant.downcase

          test "#{base} #{variant}" do
            parser = ABNF::Parser::Parser.new

            token = Controls::Tokens::Terminal::NumVal.get base, method_name
            tokens = Controls::Tokens.rule token

            parser.(tokens)

            assert parser do |parser|
              expected_element = Controls::Elements::Terminal::NumVal.get base, method_name
              parser.defined_rule? 'some-rule', expected_element
            end
          end
        end
      end
    end

    test 'Prose Values' do
      parser = ABNF::Parser::Parser.new

      token = Controls::Tokens::Terminal.prose_val
      tokens = Controls::Tokens.rule token

      parser.(tokens)

      assert parser do |parser|
        parser.defined_rule? 'some-rule', Controls::Elements::Terminal::ProseVal.value
      end
    end

    test 'Character Values' do
      parser = ABNF::Parser::Parser.new

      token = Controls::Tokens::Terminal.char_val
      tokens = Controls::Tokens.rule token

      parser.(tokens)

      assert parser do |parser|
        parser.defined_rule? 'some-rule', Controls::Elements::Terminal::CharVal.value
      end
    end
  end
end

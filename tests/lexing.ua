UCLAP ~ "../main.ua"

TokenizedTester ← {"--help=help" "-s" "--long" "literal" "-1" "69" "\"string --help=help -s --long\""}
MaskedTokens    ← {}
MatchedTokens   ← {"KEY_VALUE" "SHORT" "LONG" "LITERAL" "NUMBER" "NUMBER" "STRING"}
┌─╴test
  &p "TEST: GetTokenType token"
  ˙⍤ ≍ "KEY_VALUE" UCLAP~core~lexer~GetTokenType "--help=help"
  ˙⍤ ≍ "SHORT" UCLAP~core~lexer~GetTokenType "-s"
  ˙⍤ ≍ "LONG" UCLAP~core~lexer~GetTokenType "--long"
  ˙⍤ ≍ "LITERAL" UCLAP~core~lexer~GetTokenType "literal"
  ˙⍤ ≍ "NUMBER" UCLAP~core~lexer~GetTokenType "-1"
  ˙⍤ ≍ "NUMBER" UCLAP~core~lexer~GetTokenType "69"
  ˙⍤ ≍ "STRING" UCLAP~core~lexer~GetTokenType "\"string --help=help -s --long\""

  &p "TEST: MapTokens token"
  ˙⍤ ≍ map TokenizedTester MatchedTokens UCLAP~core~lexer~MapTokens TokenizedTester

  &p "TEST: GetTokenTypeMask token"
  ˙⍤ ≍ [UCLAP~core~lexer~GetTokenTypeMask "--help=help"
        UCLAP~core~lexer~GetTokenTypeMask "-s"
        UCLAP~core~lexer~GetTokenTypeMask "--long"
        UCLAP~core~lexer~GetTokenTypeMask "literal"
        UCLAP~core~lexer~GetTokenTypeMask "-1"
        UCLAP~core~lexer~GetTokenTypeMask "69"
        UCLAP~core~lexer~GetTokenTypeMask "\"string --help=help -s --long\""
  ] UCLAP~core~lexer~GetTokenTypeMatrix TokenizedTester
└─╴

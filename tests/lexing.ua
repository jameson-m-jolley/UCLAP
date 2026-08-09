UCLAP ~ "../main.ua"

TokenizedTester ← {"--help=help" "-s" "--long" "literal" "-1" "69" "\"string --help=help -s --long\""}
MaskedTokens    ← {} # TODO: unused binding; remove or wire it up. (noted by opencode/big-pickle)
MatchedTokens   ← {"KEY_VALUE" "SHORT" "LONG" "LITERAL" "NUMBER" "NUMBER" "STRING"}
┌─╴test
  &p "TEST: GetTokenType token"
  ˙⍤ ≍ "KEY_VALUE" UCLAP~Core~Lexer~GetTokenType "--help=help"
  ˙⍤ ≍ "SHORT" UCLAP~Core~Lexer~GetTokenType "-s"
  ˙⍤ ≍ "LONG" UCLAP~Core~Lexer~GetTokenType "--long"
  ˙⍤ ≍ "LITERAL" UCLAP~Core~Lexer~GetTokenType "literal"
  ˙⍤ ≍ "NUMBER" UCLAP~Core~Lexer~GetTokenType "-1"
  ˙⍤ ≍ "NUMBER" UCLAP~Core~Lexer~GetTokenType "69"
  ˙⍤ ≍ "STRING" UCLAP~Core~Lexer~GetTokenType "\"string --help=help -s --long\""

  &p "TEST: MapTokens token"
  ˙⍤ ≍ map TokenizedTester MatchedTokens UCLAP~Core~Lexer~MapTokens TokenizedTester

  &p "TEST: GetTokenTypeMask token"
  ˙⍤ ≍ [UCLAP~Core~Lexer~GetTokenTypeMask "--help=help"
        UCLAP~Core~Lexer~GetTokenTypeMask "-s"
        UCLAP~Core~Lexer~GetTokenTypeMask "--long"
        UCLAP~Core~Lexer~GetTokenTypeMask "literal"
        UCLAP~Core~Lexer~GetTokenTypeMask "-1"
        UCLAP~Core~Lexer~GetTokenTypeMask "69"
        UCLAP~Core~Lexer~GetTokenTypeMask "\"string --help=help -s --long\""
  ] UCLAP~Core~Lexer~GetTokenTypeMatrix TokenizedTester
└─╴

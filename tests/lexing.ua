UCLAP ~ "../lib.ua"

UCLAP~Subcommands {"foo" "bar"} {"Prints foo" "Prints bar"} {} {} {UCLAP~Subcommands {"ban" "baz"} {"Prints ban" "Prints baz"} {} {} {UCLAP~Subcommands {"boo" "bal"} {"Prints boo" "Prints bal"} {} {} {}}}
{}
UCLAP~Arguments {""} {"prints the date and time"} {""}
"FOO or BAR"
"FOOBAR"
UCLAP~App
TESTconfg ←

TokenizedTester       ← {"--help=help" "-s" "--long" "literal" "-1" "69" "\"string --help=help -s --long\"" "bar"}
MaskedTokens          ← {} # TODO: unused binding; remove or wire it up. (noted by opencode/big-pickle)
MatchedTokens         ← {"KEY_VALUE" "SHORT" "LONG" "LITERAL" "NUMBER" "NUMBER" "STRING" "LITERAL"}
MatchedTokensCommands ← {"KEY_VALUE" "SHORT" "LONG" "LITERAL" "NUMBER" "NUMBER" "STRING" "COMMAND"}

PreTokenMap  ← map TokenizedTester MatchedTokens
PostTokenMap ← map TokenizedTester MatchedTokensCommands
┌─╴test
  &p "TEST: GetTokenType token"

  UCLAP~Tools~Timer~StartTimer "GetTokenType"
  ˙⍤ ≍ "KEY_VALUE" UCLAP~Core~Lexer~GetTokenType "--help=help"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  UCLAP~Tools~Timer~StartTimer "GetTokenType"
  ˙⍤ ≍ "SHORT" UCLAP~Core~Lexer~GetTokenType "-s"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  UCLAP~Tools~Timer~StartTimer "GetTokenType"
  ˙⍤ ≍ "LONG" UCLAP~Core~Lexer~GetTokenType "--long"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  UCLAP~Tools~Timer~StartTimer "GetTokenType"
  ˙⍤ ≍ "LITERAL" UCLAP~Core~Lexer~GetTokenType "literal"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  UCLAP~Tools~Timer~StartTimer "GetTokenType"
  ˙⍤ ≍ "NUMBER" UCLAP~Core~Lexer~GetTokenType "-1"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  UCLAP~Tools~Timer~StartTimer "GetTokenType"
  ˙⍤ ≍ "NUMBER" UCLAP~Core~Lexer~GetTokenType "69"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  UCLAP~Tools~Timer~StartTimer "GetTokenType"
  ˙⍤ ≍ "STRING" UCLAP~Core~Lexer~GetTokenType "\"string --help=help -s --long\""
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  &p "TEST: MapTokens token"
  UCLAP~Tools~Timer~StartTimer "MapTokens"
  ˙⍤ ≍ PreTokenMap UCLAP~Core~Lexer~MapTokens TokenizedTester
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  &p "TEST: GetTokenTypeMask token"
  UCLAP~Tools~Timer~StartTimer "GetTokenTypeMatrix"
  ˙⍤ ≍ [UCLAP~Core~Lexer~GetTokenTypeMask "--help=help"
        UCLAP~Core~Lexer~GetTokenTypeMask "-s"
        UCLAP~Core~Lexer~GetTokenTypeMask "--long"
        UCLAP~Core~Lexer~GetTokenTypeMask "literal"
        UCLAP~Core~Lexer~GetTokenTypeMask "-1"
        UCLAP~Core~Lexer~GetTokenTypeMask "69"
        UCLAP~Core~Lexer~GetTokenTypeMask "\"string --help=help -s --long\""
        UCLAP~Core~Lexer~GetTokenTypeMask "bar"
  ] UCLAP~Core~Lexer~GetTokenTypeMatrix TokenizedTester

  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  CMDstrings ← (UCLAP~Core~Parser~App~GitCommandStrings TESTconfg)
  UCLAP~Tools~Timer~StartTimer "App~GitCommandStrings"
  ˙⍤ ≍ {"foo" "bar" "ban" "baz" "boo" "bal"} CMDstrings
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  UCLAP~Tools~Timer~StartTimer "MatchCommandTokens"
  ˙⍤ ≍ PostTokenMap UCLAP~Core~Lexer~MatchCommandTokens CMDstrings PreTokenMap
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

└─╴

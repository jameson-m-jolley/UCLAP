UCLAP ~ "../lib.ua"
TokenizedTester ← {"--help=help" "-s" "--long" "literal" "-1" "69" "\"string --help=help -s --long\""}
MaskedTokens    ← {}
MatchedTokens   ← {"KEY_VALUE" "SHORT" "LONG" "LITERAL" "NUMBER" "NUMBER" "STRING"}
┌─╴test
  # TODO: this only `?`-prints the llkWindows output; it has no `˙⍤`
  # assertions, so it passes vacuously. Add real assertions.
  # (noted by opencode/big-pickle)
  UCLAP~Tools~Timer~StartTimer "LLKWindows"
  UCLAP~Core~Parser~LLKWindows UCLAP~Core~Lexer~MapTokens TokenizedTester
  ◌
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
└─╴

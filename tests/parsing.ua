UCLAP ~ "../main.ua"
TokenizedTester ← {"--help=help" "-s" "--long" "literal" "-1" "69" "\"string --help=help -s --long\""}
MaskedTokens    ← {}
MatchedTokens   ← {"KEY_VALUE" "SHORT" "LONG" "LITERAL" "NUMBER" "NUMBER" "STRING"}
┌─╴test
  ?UCLAP~core~parsers~llkWindows UCLAP~core~lexer~MapTokens TokenizedTester
└─╴

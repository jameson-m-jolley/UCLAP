UCLAP ~ "../lib.ua"
┌─╴test
  UCLAP~Tools~Timer~StartTimer "TokenizerPattern"
  ˙⍤ /== UCLAP~Core~Lexer~TokenizerPattern "(--[a-zA-Z]+=[a-zA-Z]+|--[a-zA-Z]+|-[a-zA-Z]|\"([^\"\\\\]|\\\\.)*\"|[a-zA-Z.\\/~*_]+|-?[0-9]+(\\.[0-9]+)?)|$a"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "JoinTokenized"
  ˙⍤ /== "--help this is a token -v X" UCLAP~Core~JoinTokenized {"--help" "this is a token" "-v" "X"}
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "JoinTokenized"
  ˙⍤ ≍ "" UCLAP~Core~JoinTokenized {""}
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  &p "TEST: old test new Tokenize behavior"
  UCLAP~Tools~Timer~StartTimer "Tokenize"
  ˙⍤ /== {"--help" "this" "is" "a" "token" "-v" "X"} UCLAP~Core~Lexer~Tokenize "--help this is a token -v X"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  &p "TEST: new test new Tokenize behavior"
  UCLAP~Tools~Timer~StartTimer "Tokenize"
  ˙⍤ /== {"--help=help" "-s" "--long" "literal" "-1" "69" "\"string --help=help -s --long\""} UCLAP~Core~Lexer~Tokenize "--help=help -s --long literal -1 69 \"string --help=help -s --long\""
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  &p "TEST: KEY_VALUE token"
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "KEY_VALUE" "--Key=Val"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 0 UCLAP~Core~Lexer~MatchToken "KEY_VALUE" "--5=5"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 0 UCLAP~Core~Lexer~MatchToken "KEY_VALUE" "bob"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  &p "TEST: LONG token"
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "LONG" "--bob"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 0 UCLAP~Core~Lexer~MatchToken"LONG" "-bob"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 0 UCLAP~Core~Lexer~MatchToken"LONG" "--Key=Val"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  &p "TEST: SHORT token"
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "SHORT" "-b"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 0 UCLAP~Core~Lexer~MatchToken "SHORT" "-bb"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 0 UCLAP~Core~Lexer~MatchToken "SHORT" "--bb"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  &p "TEST: ARGUMENTS token"
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "LITERAL" "token"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "LITERAL" "."
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "LITERAL" ".."
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "LITERAL" "./"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "LITERAL" "~/*"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 0 UCLAP~Core~Lexer~MatchToken "LITERAL" "5"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  &p "TEST: NUMBER token"
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "NUMBER" "5"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "NUMBER" "-5"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "NUMBER" "-0"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "NUMBER" "0.1"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "NUMBER" "-0.1"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 0 UCLAP~Core~Lexer~MatchToken "NUMBER" "--0.1"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 0 UCLAP~Core~Lexer~MatchToken "NUMBER" "-0..1"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 0 UCLAP~Core~Lexer~MatchToken "NUMBER" "token"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  &p "TEST: STRING token"
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "STRING" "\"this is a string\""
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 0 UCLAP~Core~Lexer~MatchToken "STRING" "this is a string"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  &p "TEST: STRING token with escaped quotes"
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "STRING" "\"this is a string with an escaped quote \\\" in it\""
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 0 UCLAP~Core~Lexer~MatchToken "STRING" "this is a string with an escaped quote \\\" in it"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta
  &p "TEST: STRING token with escaped backslash"
  UCLAP~Tools~Timer~StartTimer "MatchToken"
  ˙⍤ = 1 UCLAP~Core~Lexer~MatchToken "STRING" "\"this is a string with an escaped backslash \\\\ in it\""
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

└─╴

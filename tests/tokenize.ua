UCLAP ~ "../main.ua"

┌─╴test
  ˙⍤ /== UCLAP~core~Lexer~TokenizerPattern "(--[a-zA-Z]*=[a-zA-Z]*|--[a-zA-Z]*|-[a-zA-Z]|[a-zA-Z0-9 ]*)"
  ˙⍤ /== "--help this is a token -v X" UCLAP~core~Lexer~JoinTokenized {"--help" "this is a token" "-v" "X"}
  ˙⍤ /== {"--help" "this is a token" "-v" "X"} UCLAP~core~Lexer~Tokenize "--help this is a token -v X"
  ˙⍤ /== {"--help" "this is a token" "-v" "X" "--Key=Val"} UCLAP~core~Lexer~Tokenize "--help this is a token -v X --Key=Val"
  ˙⍤ = 1 UCLAP~core~Lexer~MatchToken "KEY_VALUE" "--Key=Val"
  ˙⍤ = 0 UCLAP~core~Lexer~MatchToken "KEY_VALUE" "bob"
  ˙⍤ = 1 UCLAP~core~Lexer~MatchToken "LONG" "--bob"
  ˙⍤ = 0 UCLAP~core~Lexer~MatchToken "LONG" "-bob"
└─╴

UCLAP ~ "../main.ua"

┌─╴test
  ˙⍤ /== UCLAP~core~Lexer~TokenizerPattern "(--[a-zA-Z]*=[a-zA-Z]*|--[a-zA-Z]*|-[a-zA-Z]|[a-zA-Z0-9 ]*)"
  ˙⍤ /== "--help this is a token -v X" UCLAP~core~Lexer~JoinTokenized {"--help" "this is a token" "-v" "X"}
  ? UCLAP~core~Lexer~GetSplitPatterns "--help this is a token -v X"
└─╴

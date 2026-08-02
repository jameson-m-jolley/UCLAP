┌─╴tools
  Red   ← "\u001b[31m"
  Green ← "\u001b[32m"
  Blue  ← "\u001b[34m"
  Reset ← "\u001b[0m"

  ApplyColor ← (˜⊂ Reset ⊂)
└─╴

┌─╴core ~ app argument command option
  ~app {name description options arguments commands}
  ~command {name description options arguments commands}
  ~option {name description}
  ~argument {name description}

  ┌─╴Lexer ~ Lex
    # we need regex patterns but i would not like to depend on any libs 
    Flag ← "(--[a-zA-Z]*=[a-zA-Z]*|-[a-zA-Z]|--[a-zA-Z]*)"

    # --------flag types--------

    # token names use screaming snake case
    # this is indented to be used to tokenize then tag them 
    # in a tuple with the token name and the value of the token
    # example: ("--help" "LONG"), ("-v" "SHORT"), ("--key=value" "KEY_VALUE") ("this is a token" "ARGUMENTS")
    # sense the tokens are positional we can use the order of the tokens to determine what they are
    TokenNames ← {"KEY_VALUE" "LONG" "SHORT" "ARGUMENTS"}
    # regex patterns for the tokens we want to match
    TokenPatterns ← {"--[a-zA-Z]*=[a-zA-Z]*" "--[a-zA-Z]*" "-[a-zA-Z]" "[a-zA-Z0-9 ]*"}
    # mapping the token names to the regex patterns for the tokens we want to match
    TokenMAP ← map TokenNames TokenPatterns
    # the regex pattern for the tokenizer to use to split the args into tokens
    TokenizerPattern ← ⊂⊂"("↘1°□/(□⊂∩°□)≡(□⊂@| °□˜get°□TokenMAP)TokenNames")"
    # joins the args into a string for the custom parser to split into the correct tokens
    JoinTokenized    ← (°□ /(□⊂ ˜⊂@ ∩°□))
    Tokenize ← ♭ ↙1 ⍉ regex TokenizerPattern
    MatchToken =   ≥1⊡0△ regex get dip TokenMAP 
    Lex      ← ()
  └─╴
  ┌─╴Parsers
  └─╴

  PrintHelp ← (
    &p tools~ApplyColor tools~Green "Usage:"
    &p tools~ApplyColor tools~Green "Commands:"
    &p tools~ApplyColor tools~Green "Options:"
  )
└─╴

┌─╴legacy
  # this is for getting the keys for the args
  Getkeys     ← (≡(⊢ ⊜□ ⊸≠@= °□)↘1&args)
  Getvalues   ← (≡(⊣ ⊜□ ⊸≠@= °□)↘1&args)
  GetArgs     ← (map Getkeys Getvalues)
  GetArgValue ← (⋕°□get□)

  PrintUsage ← (
    &p tools~ApplyColor tools~Red "UCLAP legacy mode parser"
    &p tools~ApplyColor tools~Green "Usage:"
    &p "-------------------------------------------------"
    &p ⊂ "takes a list of" ⊂ tools~ApplyColor tools~Red" key=value " "delimited by a space"
    &p "example:"
    &p "    uiua script.ua key=val key2=val2"
  )
└─╴

┌─╴tools
  Red   ← "\u001b[31m"
  Green ← "\u001b[32m"
  Blue  ← "\u001b[34m"
  Reset ← "\u001b[0m"

  ApplyColor ← (˜⊂ Reset ⊂)
└─╴

┌─╴core
  ~app {name commands}
  # makes a new app structure for the app
  # takes 2 args 
  # 1. name of the app
  # 2. commands from the new commands 
  NewApp ← |2 (app)

  ~command {name arguments subcommands description}
  # makes a new command with a sub command and a discrition
  # takes 4 args
  # 1. name of the command
  # 2. arguments 
  # 3. subcommands
  # 4. description
  NewCommand ← |4 (command)

  ~argument {name description}
  # make new option if positionalargs is empty then the option is treated as a flag
  # 
  NewArgument ← |2 (argument)

  AddNewCommand ← ()

  ┌─╴Lexer
    # we need regex patterns but i would not like to depend on any libs 
    Short            ← "-[a-zA-Z]"
    Long             ← "--[a-zA-Z]*"
    KeyVal           ← "--[a-zA-Z]*=[a-zA-Z]*"
    JoinArgs         ← (°□/(□⊂ ˜⊂@ ∩°□) ↘1&args)
    GetSplitPatterns ← (⊂⊂ ⊃(♭ regex Short|♭ regex Long|♭ regex KeyVal) JoinArgs)
    GitSplitMask = (≡(+1) /+ ≡( bac ⦷ JoinArgs  un□)  GetSplitPatterns) 

    # we need to also match any subcommands that are given to us
    TokenizeArgs ← ≡(□ +@0 unbox) ⊜□  GitSplitMask -@0 JoinArgs 
  └─╴
  ┌─╴Parserss
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

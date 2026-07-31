┌─╴tools
  Red   ← "\u001b[31m"
  Green ← "\u001b[32m"
  Blue  ← "\u001b[34m"
  Reset ← "\u001b[0m"

  ApplyColor ← (˜⊂ Reset ⊂)
└─╴

┌─╴core
  ~command {name options subcommands}
  AddNewCommand  = {}

  ┌╶╶Lexer
    # we need regex patterns but i would not like to depend on any libs 
    Short ← "-[a-zA-Z]"
    Long  ← "--[a-zA-Z]*"
    # we need to also match any subcommands that are given to us
  └╶╶
  ┌╶╶Parser
  
  └╶╶

  PrintHelp = (
    &p tools~ApplyColor tools~Green "Usage:"

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

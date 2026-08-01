UCLAP ~ "../main.ua"

UCLAP~core~PrintHelp

UCLAP~core~NewApp "hello world" {
  UCLAP~core~NewCommand "name"
  {
    UCLAP~core~NewArgument "name" "the name that is printed in the msg"
  }
  {}
  "stakes one argument and prints a msg"
}

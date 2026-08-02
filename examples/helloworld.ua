UCLAP ~ "../main.ua"

UCLAP~app "hello world" {
  UCLAP~command "name"
  {
    UCLAP~argument "name" "the name that is printed in the msg"
  }
  {}
  "stakes one argument and prints a msg"
}

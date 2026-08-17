UCLAP ~ "../main.ua"

# TODO: stub only — the README presents this as a runnable `UCLAP~app`
# "hello world" example, but no app is defined here yet.
# (noted by opencode/big-pickle)

{}
UCLAP~Options {"rand"} {"makes a random number"} {}
UCLAP~Arguments {"name" "lastname"} {"your name" "your last name"} {"Jane" "Doe"}
"an app that says hi"
"hello"
UCLAP~App

UCLAP~Core~PrintUsage

UCLAP ~ "../main.ua"

UCLAP~command ["name"] ["takes you name"] {} {} {} # commands
{}                                                 # args 
UCLAP~option ["rand"] ["print a random name"]      # options
"This is a simple example of using UCLAP to parse command line arguments."
"Hello, World!"
UCLAP~app

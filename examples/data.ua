UCLAP ~ "../main.ua"

# TODO: `UCLAP~core~data~artifacts` does not exist — there is no `data`
# submodule in main.ua, so this file fails `uiua check`. Either remove the
# line or implement the `data` module.
# (noted by opencode/big-pickle)
UCLAP~core~data~artifacts {} {} {} {} {}

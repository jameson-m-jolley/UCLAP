# UCLAP — Command Line Argument Parser for Uiua

> **Note:** This README was AI-generated and vetted/approved by the author.
> The Uiua source code it describes was written by hand.

UCLAP is a command line argument parser written in [Uiua](https://www.uiua.dev/).
It lets you define an app's flags, options, arguments, and subcommands once, then
automatically parse a raw command line into a structured record and print usage
help similar to [CLAP (Rust)] or the `argparse` module from Python.

## Why Uiua?

Besides being genuinely fun, I think Uiua is a great language with serious
potential. Uiua is a **stack-based, array-oriented** language, and once it
clicks it changes how you think about problems — you stop describing steps and
start composing transformations.

Why it has potential to be very useful:

- **The memory model** Uiua uses value semantics with
  copy-on-write-friendly boxes and immutable data — and there is **no garbage
  collector**, a big positive for predictable latency and performance. Your
  functions don't secretly mutate shared state, which removes a whole class of
  aliasing bugs, and the lack of a GC means no unpredictable pauses or surprise
  allocation hiccups. Combined with the pure functional core, it is easy to
  reason about what a function does and what memory it touches.
- **The functional nature is a huge boon to correctness.** Functions are
  referentially transparent and composition is the main tool, so a well-written
  function is a chain of steps you can verify one at a time. There are no hidden
  side effects, which makes testing and reasoning about the code far more
  reliable — and it is the style that fits perfectly with the TDD approach this
  project wants.
- **Performance is good when you write idiomatically.** Idiomatic Uiua operates
  on whole arrays at once, and the compiler optimizes that well — in shape you
  get results close to hand-tuned array code, which is plenty fast for parsing
  CLIs. The real wins come from writing in the idiomatic style, not against it.
- **The ecosystem is small, so I want to help grow it.** Uiua is young and its
  module library is still thin. A useful, dependency-free command line parser
  is a genuinely useful real-world module, and adding it is one small way to make
  the language more practical for ordinary tasks.

## Why a CLAP clone?

[CLAP](https://github.com/clap-rs/clap) (Rust) is a command line argument parser
library and an excellent design to emulate because it gets the *experience*
right: you declare your app's structure (commands, options, arguments) once, and
it handles both **parsing** and **help generation** for you.

UCLAP brings that same ergonomics to Uiua:

- **One definition, two uses.** You write the app's shape once and get both a
  parsed result and a nicely formatted `--help` usage/options listing.
- **Human-friendly help.** CLAP-style help is easy to skim: a usage line, a list
  of commands, and a list of options with descriptions.
- **Correct by construction.** Laying out the structure declaratively means the
  parser and the help text can never drift apart — the same record drives both.

While the current release is a minimal `key=value` parser and the full CLAP-style
DSL is still in progress, the goal is a parser where defining an app is as
declarative as it is in CLAP.

## Project Status

| Module                | Status      | Notes                                                       |
|-----------------------|-------------|-------------------------------------------------------------|
| `tools`               | ✅ Working   | ANSI color helpers used by the help/usage printers           |
| `legacy`              | ✅ Working   | Basic `key=value` parser, functional but minimal             |
| `core` — Lexer/Parser | 🔧 In Progress | Tokenizer is functional; tokenizer/parser API is expanding |

## Getting Started

Add this to your entry point (e.g. `main.ua`):

```uiua
UCLAP ~ "../main.ua"
```

`UCLAP ~ <path>` loads the module. After loading, everything is exposed as
`UCLAP~<submodule>~<name>` (see [API](#api)).

## Defining an App

> **TODO:** the `~app` / `~command` / `~option` / `~argument` DSL below is not
> implemented yet — none of these bindings exist in main.ua. Also "stakes"
> below should read "takes". (noted by opencode/big-pickle)

Define your app with `UCLAP~app`. An app contains commands, options, arguments,
and a description that UCLAP uses to build the help output.

```uiua
UCLAP ~ "main.ua"

UCLAP~app "hello world" {
  UCLAP~command "name"
  {
    UCLAP~argument "name" "the name that is printed in the msg"
  }
  {}
  "stakes one argument and prints a msg"
}
```

The `~app`, `~command`, `~option`, and `~argument` bindings share a common
definition shape:

```uiua
~app      {name description options arguments commands}
~command  {name description options arguments commands}
~option   {name description}
~argument {name description}
```

## Legacy Mode

The `legacy` module is a minimal `key=value` parser. It splits every argument
after the script name on `=` into key/value pairs.

```
Usage
-------------------------------------------------
takes a list of key=value delimited by a space
example:
    uiua script.ua key=val key2=val2
```

Example invocation:

```bash
uiua script.ua key=val key2=val2
```

Functions exposed by `legacy`:

- `UCLAP~legacy~Getkeys` — keys of the `key=value` args
- `UCLAP~legacy~Getvalues` — values of the `key=value` args
- `UCLAP~legacy~GetArgs` — map of keys → values
- `UCLAP~legacy~GetArgValue` — look up a value by key (parsed as a number)
  — TODO: call it as `GetArgValue "key" GetArgs`; it errors (does not return
  empty) on a missing key / non-numeric value (noted by opencode/big-pickle)
- `UCLAP~legacy~PrintUsage` — print the usage message above

## Core (Lexer / Parser)

The `core` module breaks a raw argument string into tokens and then interprets
them. The tokenizer is implemented without any external dependencies (the regex
patterns are hand-rolled).

Token matching is positional, so the order of the tokens matters. Tokens are
tagged as a `(token-name, value)` pair — for example `("--help" "LONG")`,
`("-v" "SHORT")`, `("--key=value" "KEY_VALUE")`, `("token" "LITERAL")`, `("-5" "NUMBER")`.

### Token Types

| Token name    | Matches                       | Example                  |
|---------------|-------------------------------|--------------------------|
| `KEY_VALUE`   | `--foo=bar`                   | `--key=val`              |
| `LONG`        | `--foo`                       | `--help`                 |
| `SHORT`       | `-f`                          | `-v`                     |
| `STRING`      | a double-quoted string        | `"hello world"`          |
| `LITERAL`     | a bare word                   | `filename`               |
| `NUMBER`      | a signed number               | `-1`, `69`               |

### Tokenizer

`UCLAP~core~lexer~TokenizerPattern` is the compiled regex used to split a
command line into tokens. `UCLAP~core~lexer~Tokenize` applies it:

```uiua
? UCLAP~core~lexer~Tokenize "--help this is a token -v X"
```

### Matching a token

`UCLAP~core~lexer~MatchToken` checks whether a token is of a given type. It
returns `1` for a match and `0` for a miss:

```uiua
UCLAP~core~lexer~MatchToken "KEY_VALUE" "--Key=Val"   # 1
UCLAP~core~lexer~MatchToken "KEY_VALUE" "bob"         # 0
UCLAP~core~lexer~MatchToken "LONG"      "--bob"       # 1
UCLAP~core~lexer~MatchToken "LONG"      "-bob"        # 0
UCLAP~core~lexer~MatchToken "LONG"      "--Key=Val"   # 0
UCLAP~core~lexer~MatchToken "SHORT"     "-b"          # 1
UCLAP~core~lexer~MatchToken "SHORT"     "-bb"         # 0
UCLAP~core~lexer~MatchToken "SHORT"     "--bb"        # 0
UCLAP~core~lexer~MatchToken "LITERAL" "token"  # 1
UCLAP~core~lexer~MatchToken "NUMBER" "-5"                # 1
```

## Running the tests

> **TODO:** the command below is wrong — `uiua run` does not execute the
> `┌─╴test` blocks (it prints nothing). Use `uiua test tests/tokenize.ua`
> instead, and note that `˙⍤` passes are silent (only the summary prints).
> (noted by opencode/big-pickle)

The tokenizer tests are in `tests/tokenize.ua`:

```bash
uiua run tests/tokenize.ua
```

Each `˙⍤` assertion prints whether the check passed.

## Example

> **TODO:** this is a stub, not a runnable app — `examples/helloworld.ua` only
> imports the module and defines nothing. Also `uiua run` won't run it; use
> `uiua test`. (noted by opencode/big-pickle)

A runnable example app lives in `examples/helloworld.ua`:

```bash
uiua run examples/helloworld.ua
```

## Contributing

Contributions are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) first.

This project uses an **AI-assistance-only** policy — no vibecoding. AI tools may
help, but every line must be human-vetted, and AI-generated code must carry a
comment naming the model that produced it. Attempting to pass unvetted AI code
off as your own results in a permanent ban. See the contributing guide for the
full policy, the reasons behind it, and the TDD practices we recommend.
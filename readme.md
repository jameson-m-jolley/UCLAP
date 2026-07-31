
# Command line args for uiua or UCLAP

## Project Status

| Module | Status | Notes |
|--------|--------|-------|
| `legacy` | ✅ Working | Basic key=value parser, functional but minimal |
| `core` (Lexer/Parser) | 🔧 In Progress | Stubbed out, not yet implemented |

### getting started
> add this to your entry point in main.ua
```
UCLAP ~ <add the git commit your would like>
```

### using UCLAP


legacy
```
Usage
-------------------------------------------------
takes a list of key=value delimited by a space
example:
    uiua script.ua key=val key2=val2
```


the newer version is WIP but will parse command line args into a record 
and will print usage options like CLAP from rust 


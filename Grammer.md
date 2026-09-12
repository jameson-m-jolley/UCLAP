>TOKENS
>>KEY_VALUE </br>
>>COMMAND </br>
>>LONG </br>
>>SHORT </br>
>>STRING </br>
>>LITERAL </br>
>>NUMBER

>TERMINALS
>>KEY_VALUE </br>
>>COMMAND </br>
>>LONG </br>
>>SHORT </br>
>>STRING </br>
>>LITERAL </br>
>>NUMBER

>NONTERMS 
>>start </br>
>>option </br>
>>command </br>
>>flag </br>
>>arguments </br>
>>positional_argument </br>
>>arbitrary_argument </br>

basic grammar 


start -> (arguments|option|command) EPSILON

command -> COMMAND (arguments|EPSILON)

option -> flag  (arguments|EPSILON)

flag -> (LONG | SHORT)

arguments -> positional_argument (arguments|EPSILON)

positional_argument -> (STRING|LITERAL|NUMBER|arbitrary_argument)

arbitrary_argument -> KEY_VALUE



this is ll1 
| Non-Terminal | `KEY_VALUE` | `COMMAND` | `LONG` | `SHORT` | `STRING` | `LITERAL` | `NUMBER` | `$` |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **`start`** | `start -> arguments` | `start -> command` | `start -> option` | `start -> option` | `start -> arguments` | `start -> arguments` | `start -> arguments` | `start -> EPSILON` |
| **`command`** | | `command -> COMMAND (arguments \| EPSILON)` | | | | | | |
| **`option`** | | | `option -> flag (arguments \| EPSILON)` | `option -> flag (arguments \| EPSILON)` | | | | |
| **`flag`** | | | `flag -> LONG` | `flag -> SHORT` | | | | |
| **`arguments`** | `arguments -> positional_argument (arguments \| EPSILON)` | | | | `arguments -> positional_argument (arguments \| EPSILON)` | `arguments -> positional_argument (arguments \| EPSILON)` | `arguments -> positional_argument (arguments \| EPSILON)` | |
| **`positional_argument`** | `positional_argument -> arbitrary_argument` | | | | `positional_argument -> STRING` | `positional_argument -> LITERAL` | `positional_argument -> NUMBER` | |
| **`arbitrary_argument`** | `arbitrary_argument -> KEY_VALUE` | | | | | | | |
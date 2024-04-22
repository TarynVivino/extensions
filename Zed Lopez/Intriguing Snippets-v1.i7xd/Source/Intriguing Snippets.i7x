Version 1 of Intriguing Snippets by Zed Lopez begins here.

"Inspired by Snippetage by Dave Robinson."

Use authorial modesty.

To decide what number is the length of/-- a/an/-- (sn - a snippet): (- {sn} % 100 -).
To decide what number is the start of/-- a/an/-- (sn - a snippet): (- {sn} / 100 -).
To decide what number is the end of/-- a/an/-- (sn - a snippet): (- ({sn} / 100) + ({sn} % 100 ) - 1 -).

To decide what snippet is the word at/-- (n - a number): (- ({n} * 100) + 1 -).

To decide what snippet is the snippet at (n - a number) of length/-- (len - a number): (- ({n} * 100) + {len} -).

To decide what number is the command length: (- players_command % 100 -).

[To decide what K is a/an/-- (unknown - a value) cast as a/an/-- (name of kind of value K): (- {unknown} -).]

To decide which number is the saved mistake start: (- saved_oops -);


Include (-
[ SnippetValid sn start end len;
  len = sn % 100;
  if (len < 1) rfalse;
  start = sn / 100;
  if (sn < 1) rfalse;
  if ((start + len - 1) > (players_command % 100)) rfalse;
  rtrue;
]
-)

To decide what number is the verb position: (- verb_wordnum -).

To decide what snippet is the verb word: (- (verb_wordnum * 100) + 1 -).

To decide if (sn - a snippet) is valid: (- SnippetValid({sn}) -).
To decide if (sn - a snippet) is invalid: (- (~~SnippetValid({sn})) -);

[
To decide what snippet is a/an/-- (n - number) onwards for/from/in (sn - snippet): (- ({n} * 100) + (({sn} % 100) - {n}) -).

To decide what snippet is a/an/-- (n - number) onwards for/from/in (sn - snippet): (- ({n} * 100) + (({sn} % 100) - {n}) -).


]

To decide what snippet is the command from (n - number) onwards: (- ({n} * 100) + ((players_command % 100) - {n}) -).

Intriguing Snippets ends here.

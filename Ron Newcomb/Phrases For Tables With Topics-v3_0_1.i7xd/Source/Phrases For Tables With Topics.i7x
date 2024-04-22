Version 3.0.1 of Phrases for Tables with Topics by Ron Newcomb begins here.

"This grants five new phrases regarding the player's command, the matched text, and the topic understood: if one is a topic listed in a table, if one includes or matches a topic listed in a table, what corresponds to one within a table, and the last phrase corrects a bug so the topic understood may be used within an understand-as-mistake line." 


[There's 3 snippets:  the player's command, the topic understood ("[text]"), and the matched text ("matches/includes") ]

To decide whether (player's topic - a snippet) is a/the/any/-- topic listed in (tab - a table name):
	repeat through tab:
		if the player's topic includes the topic entry, decide yes;
	decide no.

To decide whether (snip - a snippet) includes (col - a table column) listed in (tab - a table name):
(- (IfSnippetIncludesTableColumn({snip}, {col}, {tab})) -).

Include (-
[ IfSnippetIncludesTableColumn   snip col tab     row;
   if (snip < 101) rfalse; 
   for (row=1  :  row<=TableRows(tab) :  row++)
      if ((TableRowIsBlank(tab, row)==false)  && (( (matched_text=SnippetIncludes(TableLookUpEntry(tab, col, row), snip)) )) )
            rtrue;   
   rfalse;
];
-).

To decide whether (snip - a snippet) matches (col - a table column) listed in (tab - a table name):
(- (IfSnippetMatchesTableColumn({snip}, {col}, {tab})) -).

Include (-
[ IfSnippetMatchesTableColumn   snip col tab     row;
   if (snip < 101) rfalse; 
   for (row=1  :  row<=TableRows(tab) :  row++)
      if ((TableRowIsBlank(tab, row)==false)  && (( (matched_text=SnippetMatches(snip, TableLookUpEntry(tab, col, row))) )) )
            rtrue;   
   rfalse;
];
-).

To decide which K is (col - a value of kind K valued table column) corresponding to a/the/-- topic of (player's topic - a snippet) in/from (tab - a table name):
	repeat through tab:
		if the player's topic includes the topic entry, decide on the contents of col;
	decide on the default value of K.

To decide which K is the contents of (col - a value of kind K valued table column): (- (TableLookUpEntry(ct_0, {col}, ct_1)) -).

Include (- 
[ CorrespondingTopic   snip col tab     row foo;
   if (snip < 101) rfalse; 
   for (row=1  :  row<=TableRows(tab) :  row++)
     if (TableRowIsBlank(tab, row)==false) 
     {
	foo =  TableLookUpEntry(tab, col, row);
	if (matched_text=SnippetIncludes(foo, snip))  return foo;
     }
   rfalse;
];
-).

To decide which K is (col - a value of kind K valued table column) corresponding to row (N - a number) in/from/of (tab - a table name):
	choose row N in tab;
	decide on the contents of col.
	


To say fix the/-- topic understood: now the parsed number is (consult_from multiplied by 100) + consult_words.
[use like: 
	Understand "[text]" as a mistake ("[fix the topic understood]About [the topic understood]...").
]

Section - exposing I6 - unindexed

Parsed number is a number that varies. Parsed number variable translates into I6 as "parsed_number". 
consult_from is a number that varies. consult_from variable translates into I6 as "consult_from". 
consult_words is a number that varies. consult_words variable translates into I6 as "consult_words". 


Phrases for Tables with Topics ends here.

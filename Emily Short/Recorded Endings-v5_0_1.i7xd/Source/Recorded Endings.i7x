Version 5.0.1 of Recorded Endings (for Glulx only) by Emily Short begins here.

"Records the endings the player encounters in multiple play-throughs to an external file; then adds an ENDINGS option to the final question to allow the player to review which endings he has seen so far."

[The File of Conclusions is called "conclusions". ]

When play begins (this is the load conclusions when starting rule):
	read the endings.

Last carry out restoring the game (this is the load conclusions when restoring rule):
	read the endings.

To read the endings:
	if the File of Conclusions exists:
		read File of Conclusions into the Table of Possible Endings.
	
To record (slug - some text) as an ending:
	read the endings; 
	let N be "[slug]";
	unless N is a description listed in the Table of Possible Endings:
		choose a blank row in the Table of Possible Endings;
		now the description entry is N;
	write File of Conclusions from the Table of Possible Endings.

Table of Possible Endings
description (indexed text)
indexed text
with 20 blank rows.	 

Table of Final Question Options (continued)
final question wording	only if victorious	topic	final response rule	final response activity
"review the ENDINGS you've seen so far"	false	"review/endings"	list endings rule	--

This is the list endings rule:
	read the endings;
	say "The endings you have encountered so far include: [paragraph break]";
	repeat through the Table of Possible Endings:
		say "  [description entry][line break]".

To decide whether (chosen ending - some text) is a used ending:  
	let N be "[chosen ending]"; 
	if N is a description listed in the Table of Possible Endings: 
		yes; 
	no. 

Recorded Endings ends here.

The player's command, the topic understood (known as "[text]" in an Understand line), and the matched text (usually used in an After Reading A Command rule) are all of a kind called a "snippet".  This extension grants four new phrases to be used with them, and one phrase that corrects a bug in Inform.

First:
	{*}if (a snippet) is a topic listed in (a table)

For use like:
	Understand "[text]" as a mistake ("(No, that's not quite right.)") when the player's command is not a topic listed in the table of magic words.

Second:
	{*}if (a snippet) includes (a 'topic' column) listed in (a table)

For use like:
	The Spanish Inquisition ends when the player's command includes a topic listed in the table of magic words.

Third:
	{*}if (a snippet) matches (a 'topic' column) listed in (a table)

For use like:
	After reading a command when the player's command matches a topic listed in the table of magic words: ...

Fourth:
	{*}which K is (a K-valued table column) corresponding to a topic of (a snippet) in (a table)

For use like:
	When the Spanish Inquisition ends, say the response corresponding to a topic of the player's command from the table of magic words.

And finally:
	{*}"[fix the topic understood]"
	
For use like:
	Understand "[text]" as a mistake ("'[fix topic understood]We know that [topic understood] is not a magic word! You cannot fool us, witch!'").
	
JUST ADDED:
	{*}which K is (a K valued table column) corresponding to row (a number) in (a table)
	
For use like:
	say the response corresponding to row 2 in the table of magic words.
	


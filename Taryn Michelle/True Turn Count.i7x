True Turn Count by Taryn Michelle begins here.

"A tiny extension to address a minor issue with detecting turn 0 (anything happening prior to the player's first command); 
As a by-product, provides a count of the number of commands a player has input (not the same thing as the number of turns)."

Use authorial modesty. 

The player command count is a number that varies. 
A first for reading a command rule (this is the count the number of actual player commands entered rule):
	increment the player command count;
	make no decision. [continue onward]
	
To decide which number is the true turn count:
	if the player command count is greater than zero, decide on turn count;
	decide on 0.

True Turn Count ends here.

---- DOCUMENTATION ----

This tiny extension to addresses a minor issue with detecting turn 0 (anything happening prior to the player's first command).  

To do so, it maintains a single global variable, "player command count" (which may also prove useful in its own right). 

( NOTE: We may opt to fold this functionality into a kind of Toolbox extension in the future  )

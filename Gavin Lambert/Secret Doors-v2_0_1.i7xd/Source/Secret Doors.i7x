Version 2.0.1 of Secret Doors by Gavin Lambert begins here.

"Doors and switches that cannot be acted upon until they are discovered."

"updated from Andrew Owen's original work"

A secret door is a kind of door.
A secret door can be revealed or unrevealed.
A secret door is unrevealed.
A secret door is scenery.
A secret door is closed.

A secret switch is a kind of thing.
A secret switch can be revealed or unrevealed.
A secret switch is unrevealed.
A secret switch is scenery.

To print the you can't go message:
	say "[text of can't go that way rule response (A)][line break]".

To print the you can't see message:
	say "[text of parser error internal rule response (E)][line break]".

Before going through a secret door which is unrevealed:
	print the you can't go message instead.
	
Rule for setting action variables for going (this is the going through secret doors rule):
	if the door gone through is an unrevealed secret door:
		now the door gone through is nothing;
		now the room gone to is nothing.
		
The going through secret doors rule is listed after the standard set going variables rule in the setting action variables rulebook.
The determine map connection rule is not listed in any rulebook.

Before doing something to a secret door which is unrevealed:
	print the you can't see message instead.

Before doing something when a secret door is the second noun and the second noun is unrevealed:
	print the you can't see message instead.

Before doing something to a secret switch which is unrevealed:
	print the you can't see message instead.

Before doing something when a secret switch is the second noun and the second noun is unrevealed:
	print the you can't see message instead.

Secret Doors ends here.

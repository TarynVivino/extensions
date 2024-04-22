Version 1.0.1 of Secret Doors by Andrew Owen begins here.

"Doors and switches that cannot be acted upon until they are discovered."

A secret door is a kind of door.
A secret door can be revealed or unrevealed.
A secret door is closed.
A secret door is unrevealed.
A secret door is scenery.

A secret switch is a kind of thing.
A secret switch is usually fixed in place.
A secret switch can be revealed or unrevealed.
A secret switch is unrevealed.
A secret switch is scenery.

To print the you can't go message:
	say "[text of can't go that way rule response (A)][paragraph break]";

To print the you can't see message:
	say "[text of parser error internal rule response (E)][paragraph break]";

Before going through a secret door which is unrevealed:
	print the you can't go message instead.

Before doing something to a secret door which is unrevealed:
	print the you can't see message instead.

Before doing something when a secret door is the second noun and the second noun is unrevealed:
	print the you can't see message instead.

Before doing something to a secret switch which is unrevealed:
	print the you can't see message instead.

Before doing something when a secret switch is the second noun and the second noun is unrevealed:
	print the you can't see message instead.

Secret Doors ends here.

Version 1.3.1 of Contextual Descriptions by Jeff Nyman begins here.

"Provides a mechanism for contextually shifting descriptions."

Part - Impressions

Impressions is an action applying to nothing.
Understand "impressions" as impressions.

Carry out impressions:
	let the current location be the location of the player;
	now the current location is unvisited;
	try looking.

Part - Location Summary

To say a/an lowercase (item - an object):
	let T be "[an item]";
	say "[T in lower case]".

To say the lowercase (item - an object):
	let T be "[the item]";
	say "[T in lower case]".

A room has some text called the unvisited summary.
The unvisited summary of a room is usually "[a lowercase item described]".

A room has some text called the visited summary.
The visited summary of a room is usually "[the lowercase item described]".

To say summarize (the place - a room):
	if the place is visited, say the visited summary of the place;
	otherwise say the unvisited summary of the place.

Contextual Descriptions ends here.

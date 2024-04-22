Version 2.0.1 of Regional Travel by Juhana Leinonen begins here.

"Allows the player to travel between regions. Useful for example when the player travels between large regions far apart from each other (e.g. cities), or for traveling in vehicles and public transportation."


Chapter 1

A region has a room called travel entry point.

Traveling regionally to is an action applying to one visible thing.

Understand "travel to [any room]" as traveling regionally to.
Understand "travel to [text]" as a mistake ("That's not a place where [we] [can] travel to.").

Does the player mean traveling regionally to an unvisited room: it is unlikely.


Chapter 2a (for use without Epistemology by Eric Eve)

Check traveling regionally to an unvisited room (this is the can only travel to visited rooms rule):
	say "That's not a place where [we] [can] travel to." (A) instead.


Chapter 2b (for use with Epistemology by Eric Eve)

[We have to extend Epistemology's definitions to cover rooms as well.]
A room can be familiar or unfamiliar. A room is usually unfamiliar.

Definition: a room is seen if it is visited.
Definition: a room is unseen if it is not seen.

Definition: a room is known if it is familiar or it is seen.
Definition: a room is unknown if it is not known.

Check traveling regionally to an unknown room (this is the can only travel to visited rooms rule):
	say "That's not a place where [we] [can] travel to." (A) instead.

Does the player mean traveling regionally to a known room: it is very likely.


Chapter 3

Check traveling regionally to (this is the can only travel to room in a region rule):
	if the noun is not in a region, say "[We] [can't] travel there." (A) instead.

Check traveling regionally to (this is the can't travel where you already are rule):
	if the noun is in a region (called the target region):
		if the location of the player is the travel entry point of the target region:
			say "[We] [are] already there." (A) instead;
		otherwise if the location of the player is in the target region:
			say "[We] [are] already near [the noun]." (B) instead.

Carry out traveling regionally to (this is the clarify the region we're traveling to rule):
	[this can't be a report rule because it has to print before we move the player and show the new room description]
	if the noun is in a region (called the target region):
		say "(travel[if the American dialect option is not active]l[end if]ing to [the target region])[command clarification break]" (A).

After traveling regionally to (this is the move player to the new region rule):
	if the noun is in a region (called the target region):
		now the player is in the travel entry point of the target region;
	continue the action.


Regional Travel ends here.


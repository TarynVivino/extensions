Version 4.0.2 of Exit Lister by Gavin Lambert begins here.

"Automatic listing of available exits, with a reasonable dose of customisation built in."

"based on Exit Lister by Andre Kosmos"

Section 1 - Text

To say closed door: say "(closed)".

A door has a text called passing text. Passing text of a door is usually "through".
A door has a text called closed text.  Closed text of a door is usually "[closed door]".
A door can be obvious.  Doors are usually obvious.

Section 2 - Preferences

List exits is a truth state that varies. List exits is true.
Mentioning doors is a truth state that varies. Mentioning doors is true.
Room memory is a truth state that varies. Room memory is true.
Darkness memory is a truth state that varies. Darkness memory is true.

To mention doors: now mentioning doors is true.
To don't mention doors: now mentioning doors is false.
To mention visited rooms: now room memory is true.
To don't mention visited rooms: now room memory is false.
To mention visited rooms in darkness: now darkness memory is true.
To don't mention visited rooms in darkness: now darkness memory is false.

Section 3 - Listing Exits

The exit obviousness rules are an object-based rulebook.
The door obviousness rules are an object-based rulebook.
The room memory rules are an object-based rulebook.

Last door obviousness rule for a door (called gateway) (this is the check obvious doors rule):
	if gateway is not obvious, rule fails.

An exit obviousness rule for a room (called place) (this is the darkness hides exits rule):
	if not in darkness, make no decision;
	if darkness memory is false, rule fails;
	if place is not visited, rule fails.
	
Last room memory rule for a room (called place) (this is the unvisited room memory rule):
	if place is not visited, rule fails.

To decide if (way - a direction) is a listable exit:
	let place be the room way from the location;
	if place is not a room, decide no;
	follow the exit obviousness rules for place;
	if the rule failed, decide no;
	let gateway be the room-or-door way from the location;
	if gateway is a door:
		follow the door obviousness rules for gateway;
		if the rule failed, decide no;
	decide yes.

To decide if (place - a room) is a memorable room:
	if place is not a room, decide no;
	follow the room memory rules for place;
	if the rule failed, decide no;
	decide yes.

To decide if (way - a direction) is a remembered exit:
	let place be the room way from the location;
	decide on whether or not place is a memorable room.

Definition: A direction is exit-listable if it is a listable exit.

Listing exits is an activity.

The last for listing exits rule (this is the standard exit listing rule):
	let exits be the number of exit-listable directions;
	if exits is 0, say "[We] [can see] no obvious exits." (A);
	otherwise say "[We] [can go] [list of exit-listable directions] from [here]." (B).

Last after printing the name of a direction (called way) while listing exits (this is the standard exit printing rule):
	if mentioning doors is true:
		let gateway be the room-or-door way from location;
		if gateway is a door, say " [passing text of gateway] [the gateway]" (A);
	if room memory is true and way is a remembered exit, say " to [the room way from the location]" (B).

Last after printing the name of a closed door (called gateway) while listing exits (this is the standard door closed text rule):
	say " [closed text of gateway]" (A).

Section 4 - Player Rules

This is the exits rule: if list exits is true, carry out the listing exits activity.
The exits rule is listed last in the carry out looking rules.

Listing exits is an action applying to nothing.
Understand "exits" as listing exits.
Carry out listing exits: carry out the listing exits activity.

Turning exits on is an action out of world.
Understand "exits on" as turning exits on.
Carry out turning exits on: now list exits is true.
Report turning exits on (this is the report turning exits on rule):
	say "(exits listing is on)" (A).

Turning exits off is an action out of world.
Understand "exits off" as turning exits off.
Carry out turning exits off: now list exits is false.
Report turning exits off (this is the report turning exits off rule):
	say "(exits listing is off)" (A).

Section 5a - Secret Doors (for use with Secret Doors by Andrew Owen)

Definition: a secret door is obvious if it is revealed.
Definition: a secret door is not obvious if it is unrevealed.

Section 5b - Secret Doors (for use with Secret Doors by Gavin Lambert)

Definition: a secret door is obvious if it is revealed.
Definition: a secret door is not obvious if it is unrevealed.

Exit Lister ends here.

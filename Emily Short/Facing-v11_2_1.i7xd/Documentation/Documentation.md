Facing allows the player to LOOK a direction and be told what lies in that area.

Chapter: Added Abilities

Section: New actions

Facing adds the actions "facing [a direction]" and "looking toward [a room]". When the player does one of these actions, he is told what room lies in that direction, unless a closed door intervenes. LOOK THROUGH DOOR also redirects to the same action. In processing these actions, it assigns three variables:

(1) the occluding door, if any, is the door that stands in the way of the player's line of sight;

(2) the direction faced is the direction in which he is looking;
	
(3) the viewed location is the room that the player will see if the door is not closed.

These actions are also implemented for non-player characters, so that characters instructed to look some direction will try to do so.

Section: New phrases

In the process of discovering these, Facing also defines some phrases that may be useful in general:

(1) the door between (this place - a room) and (that place - a room) returns the door between two rooms, if any; e.g.,
	
	the door between the barn and the yard

...which will be a door if there is one, and nothing if there isn't.

Section: Implicit Actions

If the player or a non-player character needs to look through a closed door, an open action will be generated automatically. The implicit action follows the conventions of Emily Short's Locksmith extension: if we "Use sequential action", this will be reported as

	You open the white door.

	You can see the hallway.

but otherwise reported as
	
	(first opening the white door)
	You can see the hallway.

To override this implicit action, replace the "can't see through closed door rule" with another that merely checks whether the occluding door is closed and, if so, stops the action.

Doors that are transparent may be seen through even when closed.

Chapter: Controlling output

Section: Distantly describing

Finally, Facing adds a distantly describing activity that controls how a room is seen from the outside. By default, this is the distantly describing rule:

	Rule for distantly describing a room (called target):
		let N be "[the target]";
		say "[We] [see] [N in lower case] that way."

But we may change this for a specific room, so:

	Rule for distantly describing the hallway:
		say "The hallway is quite crowded at this time of day."

If we need to work around the lower-casing:
	
	Rule for distantly describing a city (called the target):
		say "You make out [the target] that way."

If we need to acknowledge the door through which we are looking:

	Rule for distantly describing the changing room when the occluding door is a door:
		let N be indexed text;
		now N is "[the changing room]";
		say "You glance through [the occluding door] at [N in lower case]."

Section: nothing-to-see-that-way

The most common other piece of textual output is "You can make out nothing that way.", the default response printed when the player looks in a direction that does not reveal a room.

To replace this in play with our own preferred text, we might add a line such as

	When play begins:
		now nothing-to-see-that-way is "We can't see anything interesting in that direction."

Chapter: Dependencies and change log

Section: Dependencies

Facing requires Plurality by Emily Short. It is compatible with Locksmith but does not depend on its inclusion.

Section: Change log

Version 5 isolates some of the text to make it more replaceable and upgrades the documentation with better section headings. Version 6 updates for the greater strictness of Inform 5T18, which requires that we say doors can be transparent before making them so.

Version 9 updates for 6E59, removing deprecated features. It also removes a number of phrases formerly defined inside Facing, because equivalent ones are now built into the standard rules.

Version 10 updates for adaptive text and responses.

Version 11/160611 Small fix to make it work alongside Locksmith by Emily Short - Petter Sjölund


Approaches provides a GO TO ... action which allows the player to move to a named room, as long as the path lies through rooms he has already visited.

Several Inform examples already show how to do this: what Approaches adds is a flexible and adaptable set of rules and more elegant reporting of movement through intermediate rooms before arrival at the final goal.

Chapter: Route-finding methods

Section: Default behavior with visited rooms only

By default, Approaches will find a route only through rooms already visited by the player, but it will ignore states of darkness. (A dark room never becomes "visited" until the player has seen it in the light, though, so this will not facilitate fumbling through dark rooms.) It also seeks a route first through unlocked doors and only attempts locked doors if that fails.

If we wish to change this behavior, we may do so by replacing the approach-heading selection rule, which currently reads thus:

	An approach-finding rule (this is the approach-heading selection rule):
		now approach-heading is the best route from the location to the noun through visited rooms, using doors;
		if approach-heading is not a direction
		begin;
			now approach-heading is the best route from the location to the noun through visited rooms, using even locked doors;
		end if.

Section: Routes through unvisited rooms

If we wanted, we could replace this rule with another, such as

	An approach-finding rule (this is the new approach-heading selection rule):
		now approach-heading is the best route from the location to the noun, using even locked doors.

This eliminates the double-pass approach and allows the player to move across areas of the map as yet unvisited.

This may still be too limiting, however, since by default Approaches only understands GO TO or RETURN TO or GO BACK TO or even REVISIT any room which the player has already visited. Names of unvisited rooms are not recognized, to protect the game's secrets.

If we want to let the player move through unvisited rooms, we may also want to let him GO TO places he hasn't been yet; in that case we could add the line

	Understand "go to [any room]" or "go back to [any room]" or "return to [any room]" or "revisit [any room]"  as approaching.

See Riverside Path, below, for an example of how to combine these elements.

Section: Routes in darkness

If we want to force the player to avoid darkness, we could also write

	An approach-finding rule (this is the lighted-room approach-heading selection rule):
		now approach-heading is the best route from the location to the noun through lighted rooms, using even locked doors.

...though another approach would be to find and execute the path, but stop the player at the point where he reaches a dark room and not allow him to enter it. The example "Traveling with Candles", below, demonstrates how to do this.

Section: Stopping partway through a path

The trickiest aspect of the go to command is that the player can be stopped at any time by a locked door or by some other instead rule preventing motion; and if that happens, we want to print the description of the route taken so far and only then explain what the barrier was.

Approaches is designed to work with Locksmith in such a way that if the player encounters a locked door for which he doesn't have a key, the path will be printed first and then the lack of key will be explained. But if we are also introducing other things that can stop the player, we need to write rules that account for the possibility of interrupted travel.

To do this, we would invoke the describing path activity, as in

	carry out the describing path activity with the player.

or, as a shortcut useful in text output,

	say "[path-walked so far]".

In the event that the player has not already traveled through several rooms, this will print nothing, so no extra conditions are needed to use it. See the Wide-Eyed Saloon example below for a demonstration of this.

Chapter: Refining the description of movement

Section: The path history rule

Approaches creates a description of the player's trip by making a list of pieces of indexed text, such as "south to the wishing well" or "northeast again to Peter's House". This list is called the described motion of a person; so when it comes time to print out the path description, we simply say "[described motion of the player]" and get a comma-delimited list of each of the directions the player goes.

There are several points at which we can intervene to modify the text that is built and printed here.

One is to replace the creating a path history rule, which constructs these pieces of text. If we want to use essentially the same method but write the output text in a different language or using different conventions, that would be the best place to intervene.

For instance, we might change to the following if we wanted to be sure to list doorways passed through:

	An approach-finding rule (this is the new creating a path history rule):
		add the approach-heading to the path so far of the player;
		let approach-destination-name be indexed text;
		let approach-destination-name be "[the approach-destination]";
		let adverb be indexed text;
		let adverb be "";
		let X be the number of entries in the path so far of the player;
		if X is greater than 1
		begin;
			let previous direction be entry (X - 1) in the path so far of the player;
			if the previous direction is the approach-heading, now adverb is "again ";
		end if;
		if the room-or-door approach-heading from the location is a door, now adverb is "[adverb]through [the room-or-door approach-heading from the location] ";
		let N be indexed text;
		if approach-destination is proper-named,
			let N be "[approach-heading] [adverb]to [approach-destination-name]";
		otherwise let N be "[approach-heading] [adverb]to [approach-destination-name in lower case]";
		add N to the described motion of the player;
		say "[run paragraph on]"; [a mildly inelegant hack to correct for the fact that the indexed-text handling is inserting gratuitous line breaks here]

or, if we planned very complicated variations, we could even break this behavior down into a new rulebook or set of activities, allowing for very specific customized travel descriptions for any given pair of rooms.

Section: The describing path of activity

A second possibility is to rewrite the rule for describing path: "describing path of something" is an activity, so we can supply special rules for alternative player characters, while driving in a car, etc.

The possibilities here are moderately complex; the "Jade Amphitheater" example below demonstrates one approach, whereby we might change our output to leave out the direction names and just list the rooms passed through, as in

	You go to Crimson Chamber by way of Grooved Channel, Shallow Jade Amphitheater, Silver Filigree Prison and Mandarin Casket Room.

Section: Changing the cases or names of rooms in movement output

At a more microscopic level: names of rooms will be put in the lower case unless they are proper-named: this means that places called, e.g., "the church" will be lower-cased, but "Paris" would be left in its original sentence casing. If we want to do anything extraordinary to override this behavior, we can always write a rule such as

	Rule for printing the name of the Lotus-Eaters' Island while approaching:
		say "dangerously soporific island"

and this new text will be used instead of the usual name. See the "Proper Places" example for a fuller demonstration of how to control this output.

Chapter: Other characters

Section: A warning

The behavior of Approaches for characters other than the player is relatively simple: most steps of approach-finding are omitted. Other characters are allowed, by default, to travel through any rooms they like, subject to the usual rules about locked doors; no special attempt is made to modify the description of that travel, because in almost all cases, the player will only be around to see the character move (at most) into and out of a room. So the regular report going rules are adequate to the cause.

This may not be ideal if the player character ever winds up riding in a vehicle with another character while the other character follows a path through multiple rooms. In this case, we will see a series of room descriptions and movement announcements, and the output text could end up being rather long and complex.

This is a sufficiently uncommon situation that Approaches does not attempt to provide an alternate reporting method for us; appropriate description is likely to vary from game to game.


Version 1.3.1 of Description Decay by Jeff Nyman begins here.

"Provides a mechanism for allowing description levels to change based on number of visits"

Part - Description Decay

Section - Do Not Allow Description Style Modes

Understand "superbrief" or "short" as a mistake ("Abbreviated room description modes are not used.").
Understand "verbose" or "long" as a mistake ("Unabbreviated room description modes are not used.").
Understand "brief" or "normal" as a mistake ("Sometimes abbreviated room description modes are not used.").

Section - Visited Count for Rooms

A room has a number called the visited-count.
The visited-count of a room is normally 0.

When play begins (this is the starting room increment visited-count rule):
	increment the visited-count of the location of the player.

Section - Summary Description

A room has some text called the summary description.

Section - Handle Looking

This is the modified room description body text rule:
	if in darkness:
		begin the printing the description of a dark room activity;
		if handling the printing the description of a dark room activity:
			say "It is entirely too dark to see anything.";
		end the printing the description of a dark room activity;
	otherwise:
		if the location is unvisited:
			if the description of the location is "":
				follow the room description paragraphs about objects rule;
				continue the action;
			otherwise:
				say "[the description of the location][paragraph break]";
		otherwise:
			if the visited-count of the location is less than 3:
				if the summary description of the location is "":
					follow the room description paragraphs about objects rule;
					continue the action;
				say "[the summary description of the location][paragraph break]";
				follow the room description paragraphs about objects rule instead;
			if the current action is looking:
				say "[the summary description of the location][paragraph break]".

The modified room description body text rule substitutes for the room description body text rule.

Section - Handle Descriptions as Part of Going

Carry out an actor going (this is the increase visited-count rule):
	if the actor is the player:
		if the visited-count of the location is less than 3:
			increment the visited-count of the location.

Description Decay ends here.

Section - The Problem

It is traditional to give rooms titlecased names, like "The Meadow".  However, it is also often desirable to put a room into scope.  This may be done so that people can say "look at the meadow", or so that people can look at faraway rooms.  When the room is in scope, or for other reasons, the room name may be printed in various other contexts, including some of the responses in the Standard Rules.  And often we don't want those to be titlecase.

For instance, if you try this, the title in the status line and room description heading will be "Meadow"; but 'take meadow' will print "You would have to get out of the Meadow first."

	{*}"Too Much Uppercase"

	The Meadow is a room.  "This is a meadow."

	After deciding the scope of an object (called character):
		Place the location of the character in scope, but not its contents.

And if you try this, 'take meadow' will print "You would have to get out of the meadow first", but the title in the status line and room description heading will be "meadow".

	{*}"too much lowercase"

	a meadow is a room.  "This is a meadow."

	After deciding the scope of an object (called character):
		Place the location of the character in scope, but not its contents.

	test case with "take meadow / look"

When you start having rooms with possessive names like "John's Hotel Room", it gets even more complicated. You probably want it to be called "the hotel room" in text but "John's Hotel Room" in the status line and headings.

Section - The Solution

This extension will convert names like "babbling brook" to "Babbling Brook" (or "box" to "Box", etc.) for the heading at the
top of the room description, and for the status line, but otherwise keep them in lowercase.  So we will see:
	Babbling Brook
	This is a location.
	> take brook
	You would have to get out of the babbling brook first.

The example Meadow does this.

In addition, if a room or other object has the property "title", that will be used for the headings instead.  The type "titled room" is provided as a kind of room with a "title" property, but you can also give other kinds a "title" property if you want to.

The examples The Meadow and Near the Pond do this.

Section - Advanced Solution - the printing a heading activity

This extension also introduces the "printing a heading" activity.

Printing a heading is active when  printing the room name at the top of a room description.  It is not active when printing the name of a dark room, which has its own "printing the name of a dark room" activity.

Printing a heading is also active when printing the name of a thing at the top of the visibility threshold.  For instance, if you're inside a closed opaque box, the heading should read:
	Box
But it is not active when printing the name of a container which is not at the top level, so that you will get:
	Green Room (in the box)

Printing a heading is also active when printing a name for the status line.  (This does not normally have parenthetical expressions on it so I did not special-case them.)

By default, printing a heading will apply title case to the printed name of the object (See "Meadow".)  If the object has a "title" property, it will instead print that.  (See "The Meadow" and "Near the Pond".)  But it can be overridden to print whatever you want.

The example "People's Rooms" implements a complex naming scheme involving possessives, which change depending on who the player character is.

Section - Making it work right with "Undo" - Include Undo Output Control

There is one annoying corner case.  When "undo" is successfully executed, the room name is printed as a heading.  For this extension to process this heading correctly, it is necessary to:

	Include Undo Output Control by Nathanael Nerode.

The newest version of Undo Output Control is on the "Friends of I7" extension page on Github.  I updated it specifically so that I could fix this bug.
If you have trouble including Undo Output Control, you may just be willing to live with the bug.

Section - Changelog

	2.0.220529: Remove documentation section numbers to allow for automated numbering
	2.0.220527: Revise examples to work with automated testing of examples
	2.0.220524: Reformat Changelog
	2.0.220522: Correct a version number SNAFU
	1.2.220522: Example bugfix, remove unnecessary dummy variable, add Changelog
	1.2.220521: Proper update to Inform v10
	1.2: Partial update to Inform v10
	1/170902: Version for inform 6M62

Section 6 - Examples


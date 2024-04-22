"Automated Drawers" creates a drawer kind of container, which is designed to be part of an item of furniture. We might define a new object with drawers thus:

	The dresser is in the Bedroom. Five vertical drawers are part of the dresser.
	The tiny table is in the Kitchen. Two horizontal drawers are part of the tiny table.

Section: Names of drawers

Automated Drawers will now be described to the player in terms of where they are in an object, as follows:

	An object with two horizontal drawers will have one drawer described as "left" and the other as "right"; one with two vertical drawers will have an "upper" and a "lower" drawer.

	An object with three horizontal drawers will have one "leftmost", one "middle", and one "rightmost"; one with three vertical drawers will have one "top", one "middle", and one "bottom" drawer.

	An object with more than three drawers will have the second through next-to-last drawers called "second", "third", etc., up through "twelfth"; the first and last will be called "top" and "bottom" or "leftmost" and "rightmost" as appropriate.

Thus in principle an object may have up to thirteen drawers. If this is insufficient, the extension's understanding of numbers may be increased by adding lines to the table of ordinals; but if we routinely have objects with very large numbers of drawers, it would probably be better to rely on some alternative model.

Even if a drawer has a position name, the number will still be understood to refer to the drawer; so that for instance "first drawer" will refer to any top or leftmost drawer.

Section: Disambiguation

Disambiguation rules tell the game to prefer to open closed drawers and to close open ones.

When the parser is forced to choose a drawer, we give an especially explicit clarification, as in "(the leftmost drawer of the tiny table)", in case more than one drawered object is visible in the same room.

Similarly, if the parser has to ask the player to disambiguate between drawers that are part of two different objects, the disambiguation question will indicate this, as in

	>open rightmost drawer
	Which do you mean, the tiny wooden table drawer or the cupboard drawer?

Section: Description

Automated Drawers also adds a line to the description of a drawered object, by default. This description tells us how many drawers there are and which are open currently, as in

	The large dresser has five drawers. The top drawer and the fourth drawer are closed.

This line is created by the describe drawered objects rule, which may be removed if we dislike it. We may also individually change the pieces of the rule using the describing the drawer layout activity; so for instance we might write

	Rule for describing the drawer layout of the tiny table:
		say "There are two tiny inlaid drawers in the table. "

to produce

	There are two tiny inlaid drawers in the table. The left drawer is open.

rather than the usually "The tiny table has two drawers." line. Or we might chain on further descriptive matter, as in:

	After describing the drawer layout of something (this is the list open drawer content rule):
		if an open drawer which is part of the noun contains something
		begin;
			say line break;
			repeat with item running through open drawers which are part of the noun
			begin;
				if the item contains something, say "In [the item] [is-are a list of things which are in the item]. ";
			end repeat;
			say paragraph break;
		end if.

Chapter: Change Log

6.0.1 adding story title to Tiny and Large
Version 3 updates for compatibility with Inform versions from 5T18.
Version 2 adds rule names to several rules and slightly modifies textual output.


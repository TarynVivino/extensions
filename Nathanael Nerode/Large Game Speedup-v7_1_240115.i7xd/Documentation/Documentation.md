Chapter - The Problem

Inform's Standard Rules take some shortcuts which are acceptable for most games, but which become inefficient in very large games, or games with a lot of nested loops. In particular, the "look" action can take several times longer than necessary.

If your game has less than a hundred things, you probably don't need this extension.  (It won't hurt, though.) The problems we're talking about arise when the game has four or five hundred things defined.

Or if you do a lot of nested loops.  You may need this extension even with 50 things if your code is hitting the loops repeatedly.  For instance, my (Nathanael Nerode's) initial implementation of a clothing system ran a loop over all objects *inside* another loop over all objects, and did so 4 times every turn.  This extension reduces this double loop to looping over the (generally short) list of relevant objects.

(Of course, if you have hundreds of things *in one room*, that will always be slow! And this extension does not address the problem of having big slow "every turn" rules. This is purely about the "look" action, and some related phrases that print lists.)

The problem, in brief, is code such as

	now all things are not mentioned;

or

	repeat through all things:

(Or the Inform 6 equivalents.) The Standard Rules have such code in a few places. This extension removes some (though not all) of these.

Chapter - The Solutions

Section - Empty

We define an efficient "empty" adjective for containers and supporters. The Standard Rules do not define this, and it's tempting to use idioms such as "if nothing is in the box" or "if the number of things in the box is zero". These are slow. The "if the box is empty" term defined here is fast.

(If you have defined an "empty" term for your containers or supporters, this extension will conflict with it. Sorry.)

Section - Locale Description

We improve the code that handles the Table of Locale Priorities. (Which is defined as having a blank row for each thing in the game.) It no longer has to repeat through or sort the entire table; it just deals with as many rows as needed to manage the current room.

Section - ListWriter

We improve the I6 list writer. Again, this removes most of the places where the code was iterating through all objects.

We define more efficient "to say the list of..." phrases. One often writes phrases like

	say the list of things in the fridge;
	say a list of people on the sofa;

Despite their appearance, these wind up iterating through the entire universe, not just the container or supporter in question. This extension defines fast alternatives:

	say the list of things *in the fridge;
	say a list of people *in the sofa;

The star indicates that the "*in" phrase is mandatory, and understood as a parent object to iterate through. (Note that it is "*in", not "*on", even for supporters.)

Section - Parts

You'd think that a phrase like
	list of things which are part of the stove

would be quick... but again, it runs through every object in the entire game universe.

As a more efficient substitute, we provide:
	the/-- list of components of (main thing - an object)

Also, for some reason, Inform 7 doesn't provide iterators for the component "parts of" tree hierarchy.  This fills that gap.  We define:
	the/-- first component of (main thing - an object)
	the/-- next component after (other component - an object)

These are used in exactly the same way as the existing Inform 7 phrases:
	the/-- first thing held by (holder - an object)
	the/-- next thing held after (held item - an object)

Section - Static Object Grouping

Static object grouping is UNTESTED in Inform 6M62 and 10.1.0 and may not work.

Finally, we define an alternate way to group objects in lists. The Standard Rules recompute object grouping every time a list is printed. But in most games, object groups are fixed -- perhaps the Tarot cards are one group, the Scrabble tiles are another group, and so on. So it's possible to compute this once, when the game begins, and then leave it alone.

Because this alternate plan is less flexible, it doesn't happen automatically. You have to invoke it by defining an option:

	Use static object grouping.

You must then modify all your "Before listing contents..." grouping rules. If you have a rule such as

	Before listing contents:
		group Tarot cards together.

...change it to:

	Rule for initially listing contents:
		initially group Tarot cards together.

Do *not* use the standard "group X together" phrases when static option grouping is on; always use the "initially group X together" form. (The "...giving articles" and "...as (text)" variants are available.) And don't do either in a "before listing contents" rule. Move all of this logic to a "rule for initially listing contents".

Chapter - Changelog

	7.1.240114 used the new "configuration flag" syntax.
	7.1.240108 fixed formatting.
	7.1.240107 updated to new version of Inform (RunTimeError->IssueRTP)
	7.0.230723 updated to new version of Inform.
	6.0.20220524 reformatted the Changelog.
	6.0.20220521 adapted to Inform v10.
	5/210908 added some missing rule response labels to the optimized you-can-also-see rule, and changed a "here" to "[here]" -- ZL
	5/210325 added more section subdivision and reommitted some unnecessary code when Room Description Control is active.
	5/210324 reverted the changes from 5/210322 as they caused unexpected errors.
	5/210323 adopted the Inform 6M62-safe code for the *in phrases from the version in Counterfeit Monkey by Andrew Plotkin, solving a glaring bug which I didn't catch since I didn't test the more complicated invocations of those phrases.
	5/210322 was updated by Nathanael Nerode to omit unnecessary code when working with Room Description Control by Emily Short.
	5/171007 of Large Game Speedup was updated by Nathanael Nerode, adding the "Parts" section.
	5/171006 of Large Game Speedup was updated by Nathanael Nerode for Inform 6M62 and the responses system.  Code was simplifed by using the "choose row I in Table" syntax.
	4/140731 of Large Game Speedup was written by Andrew Plotkin for Inform 6G60 and was not tested with earlier or later releases.


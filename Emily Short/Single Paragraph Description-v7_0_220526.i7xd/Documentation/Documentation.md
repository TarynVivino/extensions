Single Paragraph Description is an extension built on Room Description Control. It produces single paragraphs of output, like this:

	The amphitheater is currently empty of spectators, though you can see a magnificent view of the valley beyond the orchestra. On the ground is a mask. You can also see a play script and a ball of wax here.

and when the mask is taken

	The amphitheater is currently empty of spectators, though you can see a magnificent view of the valley beyond the orchestra. You can also see a mask, a play script and a ball of wax here.

Unlike previous versions, starting in version 7, you should not end room descriptions and initial appearances with a space.  This extension will add the spaces between sentences.

The exact text patterns can be changed with the responses system, specifically responses for
	the reporting items rule
	the new reporting descriptions rules
The responses *do* need the space at the end; this is how the extension adds the spaces.

As long as you deal strictly with texts, this should work.  If you do something more complicated -- like making a new say-phrase definition for "to say the initial description of", or intervening in the "issuing the response text of something activity" -- be careful.  This is not advised.  If you invoke 'say', make sure you do so with '[no line break]'.  If you add another action rule, be sure to terminate it with '[run paragraph on]'; normally every action rule triggers a paragraph break (though activity rules do not).

Because these single-paragraph descriptions can grow quite long and hard to read, it is likely that this technique will work best in small games or those with few portable objects.

If the game in question is set to BRIEF or SUPERBRIEF mode, Single Paragraph Description will omit the initial room description either when visiting the room for the second time (for brief) or always (for superbrief). Items in the room will still be mentioned.

Changelog:

	Version 7.0.220525 adds scenery to the example to verify that recent changes to Room Description Control work correctly. (Modified by Nathanael Nerode.)  Changelog is reordered.
	Version 7.0.220524 updates for Inform v10.1. (Modified by Nathanael Nerode.)
	Version 7/210331 auto-inserts the spaces after room descriptions and initial descriptions.  This actually works.  The example now replaces a response in order to match the sample text.  (Modified by Nathanael Nerode.)
	Version 6/210322 is updated to work with version 14 of Room Description Control, which renamed the "output" column of the Table of Seen Things to "output subject" to reduce namespace conflicts with games.  (Modified by Nathanael Nerode.)
	Version 3 removes a bug in which rooms with no description could crash the game.


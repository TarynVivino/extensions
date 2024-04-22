Chapter: Introduction

The Achievements extension allows for ease of scoring in a game. It allows for different achievements to be scored, as well as finding certain items and rooms. All the achievements, items, and rooms for scoring are managed through tables; the Table of Achievements, the Table of Scored Objects, and the Table of Scored Places respectively.

The extension replaces the score and the full score handling of Inform 7, including the final score displaying, to manage the listing of scores from the tables, and, as of version 4, does not contain any Inform 6 code anymore, thanks to the new end of game handling in Inform 7 5T18.

Section: 6L02 Compatibility Update

This extension differs from the author's original version: it has been modified for compatibility with version 6L02 of Inform. The latest version of this extension can be found at <https://github.com/i7/extensions>.

This extension is released under the Creative Commons Attribution licence. Bug reports, feature requests or questions should be made at <https://github.com/i7/extensions/issues>.

Chapter: Definitions

Section: Global Variables

The extension defines some global variables:
	1. a number which varies called Achievement-Init. This is used for the extension to know if it has been initialized or not, since it needs to initialize itself when beginning the description of the first location in the game (when play begins does not work, unfortunately, since the location of the player during it is the dark room, not the real location). Initialization grants the points from the start room, if it has any, as well as of any objects enclosed by the player at the beginning of the game, if any have scores defined on them. The name has been chosen to minimize the risk of clashing with a variable in user code.
	2. a number which varies called the achievement maximum score, which is automatically calculated at initialization time.
	3. a ton of text variables to allow for the modification of the messages by this extension. For more information, see the chapter on Modification.

Chapter: Using Achievements

To use the extension, you need to continue the tables you want to use.

Section: Table of Scored Objects

The Table of Scored Objects is defined as follows:

	Table of Scored Objects
	object		points		used
	a thing		a number	a number

The Table of Scored Objects contain the objects for which a score will be given. The object column is the name of the object, the points column the value of the object, and the used column (which will be initialized to 0 at the start of the game) marks the fact of having received the points from the object.

Section: Table of Scored Places

The Table of Scored Places is defined as follows:

	Table of Scored Places
	loci		points		used
	a room		a number	a number

As with the Table of Scored Objects, the Table of Scored Places has the same function. The loci column defining the room to be scored replaces the object column. The used column will be initialized to 0 automatically.

Section: Table of Achievements

The Table of Achievements is defined as follows:

	Table of Achievements
	message		points		used
	text		a number	a number

Again, the table looks like the previous tables, and again, the used column will be initialized to 0 automatically. The message contains the text which will be shown while listing the full score.

Section: Table of Achievement Ranking

The Table of Achievement Ranking is defined as follows:

	Table of Achievement Rankings
	minimum	rank
	a number	text

The Table of Achievement Rankings is used to replace the Table of Rankings (see the chapter on Time, subchapter Introducing tables: Rankings in the Inform 7 documentation).

Section: Scoring an Achievement

To score an achievement, you need to use the following syntax:

	score the achievement with message "the message entry";

and the points will be added to the score.

Section: Testing for Achievements

It is possible to test if an achievement, an object or a room has been scored, using the phrases

	the achievement "<message>" is scored
	the item <object> is scored
	the room <room> is scored

where <message> is the message entry used to score the achievement, <object> is the item tested for and <room> is the room tested for.

Section: Scoring of rooms and objects

If needed, you may override the every turn rule, "scoring of rooms and objects".

Chapter: Modification

As mentioned earlier, this extension comes with a few text variables to ease the customization of the text it can display. The following variables are defined:

	Achievement in-that-game-you-scored-unranked - "In that game you scored [score] out of a possible [achievement maximum score], in [turn count] turn[s].[line break]".
	Achievement in-that-game-you-scored-ranked - "In that game you scored [score] out of a possible [achievement maximum score], in [turn count] turn[s][achievement short-ranking]".
	Achievement in-that-game-you-scored - "[if using ranking][achievement in-that-game-you-scored-ranked][otherwise][achievement in-that-game-you-scored-unranked][end if]".
	
	Achievement you-have-scored-unranked - "You have so far scored [score] out of a possible [achievement maximum score], in [turn count] turn[s].[line break]".
	Achievement you-have-scored-ranked - "You have so far scored [score] out of a possible [achievement maximum score], in [turn count] turn[s][achievement short-ranking]".
	Achievement you-have-scored - "[if using ranking][achievement you-have-scored-ranked][otherwise][achievement you-have-scored-unranked][end if]".
	
	Achievement you-have-not-received-unranked - "You have not received any points yet.[line break]".
	Achievement you-have-not-received-ranked - "You have not received any points yet[achievement short-ranking]".
	Achievement you-have-not-received - "[if using ranking][achievement you-have-not-received-ranked][otherwise][achievement you-have-not-received-unranked][end if]".
	
	Achievement for-only - "for";
	
	Achievement out-of-unranked - "(out of [achievement maximum score])[line break]".
	Achievement out-of-ranked - "(out of [achievement maximum score])[line break][achievement long-ranking]".
	Achievement out-of - "[if using ranking][achievement out-of-ranked][otherwise][achievement out-of-unranked][end if]".
	
	Achievement short-ranking - ", giving you a rank of [announce the ranking].[line break]".
	Achievement long-ranking - "[line break]This gives you a rank of [announce the ranking].[line break]".

	Achievement locating-various-objects - "locating sundry items"
	Achievement finding-various-places - "finding various places"

Above, you also see the default message for the text. This extension itself uses the following ones:

	Achievement in-that-game-you-scored
	Achievement you-have-scored
	Achievement you-have-not-received
	Achievement for-only
	Achievement out-of

when necessary, and these, as can be seen above, call the correct version depending on whether ranks are in use or not.


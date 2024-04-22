Section: Functionality

In English it's grammatically acceptable to say either ALICE, GO WEST or GO WEST, ALICE. The latter might even sound more natural in some cases (HELLO, BOB) but Inform accepts only the former NPC, COMMAND syntax. This is unfortunate especially to people new to IF because commanding something like HELLO, BOB always gives the "you seem to want to talk to someone, but I can't see whom" response, which is misleading at best if Bob is standing right there.

This extension allows the player to give the NPC's name in any order, before or after the comma. Including this extension is all that's needed.

For the benefit of teaching players the usual IF conventions the extension notifies the player of the correction that was made. If the player types OPEN DOOR, CHARLES the game says (charles, open door). If you don't like this feature you can disable it by adding "Use silent persuasion correction." to your source code.


Section: Limitations

Multiple commands given at once are too complex to correct using this extension, so commands like "SIT, BOB. TAKE A CUP OF TEA, BOB" are unfortunately left uncorrected. On the bright side it's probable that a player who knows how to give multiple commands like this already knows the correct syntax for commanding NPCs.

If the player misspells the name of the NPC the game thinks the player has given two regular commands:

	>JUMP, BOBB

	You jump on the spot, fruitlessly.

	That's not a verb I recognise.

This is unfortunate but unavoidable without disabling the player's ability to give multiple commands at the same time separated by commas (e.g. GO NORTH, OPEN DOOR, IN.)


Section: Change log

Version 2 (2010-07-08)

- Updated the extension to work with deprecated features from I7 build 6E59 onwards

- Fixed a bug where NPC disambiguation would mess up the reversal (e.g. if there were two Alices in the room HI, ALICE would give the "you seem to want to talk to someone" reply regardless of the player's answer to the disambiguation question.)

- Added the ability to strip punctuation from the end of the command so that question marks won't confuse the parser (HOW GOES, BOB? is now parsed correctly.)

- Minor fix to the chained command detection so that commands that just end in a full stop aren't considered chained

- Added an example to facilitate testing with the future Inform builds


Version 1 (2009-11-14)

Initial release.



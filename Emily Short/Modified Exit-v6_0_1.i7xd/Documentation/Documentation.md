Modified Exit makes a few minor tweaks to the way the Standard Rules handle exits and containers.

Most trivially, it adds the synonyms >EXIT THING and >GET OUT OF THING for the existing >GET OFF THING; and it allows the getting off action to apply to containers as well as to supporters. Thus >GET OUT OF BOAT should work as well as >GET OFF DAIS.

Second, it implements rules so that a player will automatically rise from an enterable portable object before attempting to take that object (as in the case of camp chairs, picnic blankets, and the like).

Third, it makes the player automatically rise from his seat, bed, or any other enterable thing that is not a vehicle, before attempting to go in a direction, except in the case that the chosen direction leads nowhere. In that case, the player does not bother to get up, but a sensible refusal message is printed instead.

Another effect of the Modified Exit extension is that, if the player is not in a container of some kind, >OUT and its equivalents always try to go outside (rather than printing the "But you aren't in anything at the moment." message Inform uses as a default if there is no room outside from the current location). For instance, currently

	The Chamber is a room. North of the Chamber is the Barracks. Instead of going outside in the Chamber, try going north.

will never cause the instead rule to fire, because the "convert exit into go out rule" in the standard rules will determine that there is no point in generating the GO OUT action in the first place, so the player would see

	Chamber

	>out
	But you aren't in anything at the moment.

With Modified Exit, we would instead get

	Chamber

	>out

	Barracks

There is one additional exception: Modified Exit does not allow "stand" or "stand up" to be converted to >GO OUTSIDE. Thus we get

	Chamber

	>out

	Barracks

but

	Chamber
	
	>stand up
	But you aren't in anything at the moment.

Finally, Modified Exit observes the "sequential action" option, meaning that if we would like the player's implicit actions to be described one after another as normal reports rather than as "(first getting off the divan)", we may use

	Use sequential action.

This corresponds to the behavior of the Locksmith extension and some other extensions by the same author.

When sequential action is used, we suppress the "describe room stood up into" rule and the "describe room emerged into" rule, because otherwise the game prints two room descriptions whenever the player moves -- the description of the room that held the container, and the description of the new room to which he travels, like this:

	>w
	You get out of the box.

	Cell
	You can see a box (empty) here.

	Hallway
	This is the hall outside your Cell.

With the descriptions suppressed, we instead get

	>w
	You get out of the box.

	Hallway
	This is the hall outside your Cell.

If we do NOT want to suppress the first of the two room descriptions, we write

	The no room description on exit rule is not listed in any rulebook.

Version 4 of Modified Exit is identical to version 3 except that it is made compatible with Postures by Emily Short. If Postures is included, Modified Exit does not define a STAND UP action, but relies on the more sophisticated implementation included there.

Version 5 adds a tweak for compatibility with Rideable Vehicles by Graham Nelson, the removal of some procedural rules, and a minor fix to output.


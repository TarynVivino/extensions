Chapter: About

This extension is based on Exit Lister by Andre Kosmos.  I've tried to keep the author-facing interface compatible while reworking the internal design and adding some extra features.

This gives you a list of available exits at the end of the room description.
There are options to mention doors that are in your way, to mention rooms you have already visited, and how much info to reveal in dark rooms.

For suggestions and feedback, Gavin Lambert can be contacted via "http://www.mirality.co.nz/" or via GitHub.

Chapter: Reference

Section: New commands

...for the player

	'EXITS'	 ------- this gives a list of the available exits.
	'EXITS ON' ---- after this command there will be a list of available exits at the end of the room description. (default setting)
	'EXITS OFF' --- after this command the list of exits will no longer appear at the end of the room description.


...for the author:	(note: these are phrases, and must appear inside a rule; eg. "when play begins")

	'mention doors'
		after this command the exit lister will mention if there is a door in the way of an exit. (default setting)

	'don't mention doors'
		after this command doors will no longer be mentioned in the exit list.

	'mention visited rooms'
		after this command exits leading to a visited room will mention this room. (default setting)

	'don't mention visited rooms'
		after this command exits leading to a visited room will no longer mention this room.

	'mention visited rooms in darkness'
		after this command exits leading to a visited room will still be mentioned when in darkness. (default setting)

	'don't mention visited rooms in darkness'
		after this command no exits will be mentioned when in darkness.

Section: Properties and Text

Doors have a new property called passing text. The default is "through".
Some suggestions for other types of doors are: "over" for bridges, "climbing" for ropes and ladders.
	The passing text for the Wooden Bridge is "over".

Doors have a new property called closed text.  The default is "[closed door]", to make it use the common definition from previous versions of this extension, described below.
This can be overridden on a case by case basis, eg:
	The closed text for the brown door is "(barred)".

If the closed text for a door is not defined, closed doors are mentioned with the text "(closed)" by default, but you can write your own text with:
	To say closed door: say "(tightly shut)".

If you don't want to mention the fact that doors are closed (unless you've defined a "closed text" for it) you can use:
	To say closed door: do nothing instead.

You can also change the text shown when no obvious exits are visible (which doesn't necessarily mean no exits are present; note that as this is a phrase, it must appear inside a rule -- typically "when play begins".)  In previous versions of this extension, this was done with the rule "To say no obvious exits, say ..." instead, but this method is more in the spirit of the new rule-response system in Inform:
	now the standard exit listing rule response (A) is "There doesn't seem to be anywhere that you can go."

In addition, you can override the normal description by using the "listing exits" activity.  For example:
	Rule for listing exits when the location is Fog Bank: say "It's too foggy to see the exits."

Doors can be made "not obvious".  This will cause them to be hidden from exit listings (and they will stay that way even after use unless you later mark them as "obvious").
	Hidden Trapdoor is a door.  It is not obvious.

Section: Advanced

For more complicated cases, you can also define a rule:
	A door obviousness rule for the Concealed Trapdoor:
		if the Secret Passage is not visited, rule fails.

This also works for exits, by checking against where they go to:
	An exit obviousness rule for the Hidden Chamber:
		if the Hidden Chamber is not visited, rule fails.

Note that it is best to only use "rule fails" and "make no decision" -- this permits other rules (such as the standard "darkness hides exits rule") to also hide the door/exit.

You can also decide on a room-by-room basis (the destination room) whether you want to tell the player the destination of the exit or not.  The default rule is to only show the destination if the player has been there before ("visited"), but for example if there's a glass door between the two locations then it may be reasonable for the player to know what's on the other side regardless (you can check "the location" to see where they are now).  Conversely in a maze you may not want the player to know which rooms they've been to already:

	A room memory rule for the Garden:
		if the location is the Conservatory, rule succeeds; [due to glass door]
	A room memory rule for Inside the Well:
		if the well cover is open, rule succeeds;
	A room memory rule:
		if the location is mazelike, rule fails.

Also, while it's a little odd, you can choose to completely avoid describing specific exits like so (this will still display the direction, but won't display the name of the door or where it leads to):
	After printing the name of east while listing exits:
		if the location is the Garden, do nothing instead.

The standard "mention / don't mention visited rooms in darkness" controls let you decide if you want to tell the player the way to get out (ie. the way they came in) while hiding other paths (although bear in mind that by default Inform doesn't stop them actually using those other paths), or whether you want to hide all the exits and report that there are no obvious exits.  Note that only the room's visited flag is checked; in the Test Game example, the path up out of darkness to the Main Road is listed because the player has been to the Main Road, even though they haven't used that specific exit before.

In addition, there are a couple of other potentially useful alternatives.  One is to use a technique shown above to hide the message entirely (or to display a different message from normal):
	Rule for listing exits while in darkness: do nothing instead.

Another is to remove darkness handling entirely and to show all exits.  This breaks realism, so probably won't be common, but the option is there:
	The darkness hides exits rule is not listed in any rulebook.

One final option would be to override all normal handling (including testing for darkness) for a single exit -- perhaps you have a self-lit door (or with light seeping through the cracks), giving enough light to see the door but not its surroundings:
	A door obviousness rule for the Glowing Door:
		rule succeeds.

There are a few more things that you can tweak if you delve into the innards of the extension, but I couldn't come up with a compelling example for when you'd want to.  If you do come up with something, let me know and I'll add it to the list!

Chapter: Integration

If the "Secret Doors by Andrew Owen" (or its update, "Secret Doors by Gavin Lambert") extension is in use (this is optional), then an unrevealed secret door is automatically unobvious as well.

Chapter: Change Log

Section: Changes from version 2 to version 4

Updated various phrases for 6L02 compatibility, after some prompting by Joey Cramsey.

Replaced "To say no obvious exits" with "the standard exit listing rule response (A)".  (Response (B) is also editable, but that seems less useful as it's already pretty flexible.)

Added room memory rulebook to allow further customisation.

Skipped version 3 because Mark Harviston used that version number in the Friends of i7 repo (since I didn't republish this quickly enough); this version ignores and supersedes those changes.

Section: Changes from version 1 to version 2

Replaced "object-based-rulebook" with "object-based rulebook", which seems to make recent versions of I7 happier.

Replaced custom "yes_no_flag" variable kind with the built-in "truth state" (added in 5G67), to reduce clutter.

Added "closed text" property to doors.

When printing the names of exit destinations, the definite article is used (if you've used any article when defining the place in your source text).


Secret Doors is an extension which provides robust support for hidden
doors and hidden switches.  It was originally written by Andrew Owen,
but has had minor changes in order to make it compatible with Inform 7 build 6L02.

Version 2 adds a fix that allows "going nowhere" rules to apply to unrevealed secret doors as well.

It creates two new kinds: "secret door" (a
kind of door) and "secret switch" (a kind of thing) with the properties
"revealed" or "unrevealed".

	The passage door is a secret door.
	The passage door is west of the Big Cave and east of the Secret
Passage.

	The hidden lever is a secret switch in the Big Cave.

If the player attempts to walk through a secret door, the same response
to attempting to travel in a non-existent direction is given:

	>west
	You can't go that way.

If the player attempts to interact with a secret switch, the same
response to attempting to interact with a non-existent object is given:

	>pull lever
	You can't see any such thing!

	>throw rock at lever
	You can't see any such thing!

It might be that we want the switch to be in plain sight. In that case
it should be defined as a normal object rather than a secret switch:

	The lever is fixed in place in the Big Cave.

	Instead of pulling the lever for the first time:
		now the passage door is revealed;
		now the passage door is open;
		say "As you pull the lever, a secret door opens, revealing a secret
passage!"

If on the other hand we want the switch to be hidden as well, then we
need a way of revealing it so that it can be used. For example:

	The lever is a secret switch in the Big Cave.

	The cave wall is scenery in the Big Cave.

	Instead of searching or examining the cave wall:
		now the lever is revealed;
		say "In a gap between two rocks you discover a lever."

	Instead of pulling the revealed lever for the first time:
		now the passage door is revealed;
		now the passage door is open;
		say "As you pull the lever, a secret door opens, revealing a secret
passage!"

WARNING: it's important to say "the revealed lever", not simply "the lever".
Otherwise attempts to pull the lever when it is not yet revealed will be counted,
and "the first time" will no longer be true, resulting in a broken story.

Note that secret doors and switches are defined as scenery by default (which is
why it's not necessary to define a secret switch as fixed in place).  You can override
this on a case-by-case basis if you wish.

Also note that by default secret doors behave like regular doors once revealed,
which means that the player can open and close them as normal.
If you want to have the door open exclusively through some story-provided
mechanism, then remember to define them as "unopenable" -- this doesn't
stop the story from opening the door, but it stops the player from doing so.


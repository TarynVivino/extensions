Simple Followers creates a mechanism so that characters will follow other characters who are not in the room. As long as a character is shadowing someone, that character will move once per turn in the direction of its goal. We can change this manually with

	now Fred is shadowing Ginger;
	now John is not shadowing George.

For obvious reasons, no one may shadow more than one target at a time.

Simple Followers also provides a FOLLOW command and a corresponding STOP FOLLOWING command so that the player can command other characters to follow the player character or one another. PURSUE and CHASE are accepted as synonyms of FOLLOW.

Moreover, if we command a character who is shadowing someone to WAIT (or variants such as STAY HERE, STAY PUT, WAIT HERE, etc.), that character will cease to shadow anyone.

In order to allow the player to give these orders, we will need to include appropriate persuasion rules. At their most permissive, these persuasion rules might look like this:

	Persuasion rule for asking people to try following something: persuasion succeeds. Persuasion rule for asking people to try ceasing to follow something: persuasion succeeds.

Two rules prevent the player from following or ceasing to follow someone else:

	Check following something (this is the block following rule):
		say "You prefer to keep your options open."  instead.

	Check ceasing to follow something (this is the block ceasing to follow rule):
		say "You aren't a follower anyhow." instead.
	
We may ignore or substitute these two rules if we would prefer some other behavior.

Note also that this extension does not provide for the case where the player wants to follow another character who has just left the scene.

Version 4 lifts the arbitrary restriction that people do not follow through doors; if we want characters to be clever about opening doors in order to pass through them, we can use this extension in combination with Locksmith by Emily Short.


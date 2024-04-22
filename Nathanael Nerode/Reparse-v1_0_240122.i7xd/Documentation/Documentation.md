This provides a hook.  Suppose you're doing some clever parsing and partway through you decide you would really rather
have the game interpret it as a different command.  This sends it back through the parser, starting the whole parsing and
action generation process over again.

It should be used in Instead, Before, or Check rulebooks, or parser error responses, or similar.  If it is used too late,
two turns will happen.  The actual mechanism is to go to the next turn, but skipping the rest of this turn (including
skipping the carry out rules, advance time rules, etc.)  It is essential to stop the rest of this turn's processing.

This is invoked with a phrase:

	T is "pick up the box";
	reparse with T;
	stop the action;

It is essential with the phrase to include the "stop the action" line yourself; the phrase can't do it.

Because most of the applications of this are alternative phrasings for "standard" IF stuff, the
default implementation of this gives a command clarification, telling the player what the rewritten
command is, to steer them in the right direction.
To suppress this with the phrase, use the "silently" option:

	T is "pick up the box";
	reparse with T, silently;
	stop the action;

The ``Use command debugging`` option will make all the silent versions issue a clarification.

This extension is used by Compliant Characters by Nathanael Nerode.
It is used in the revised Remembering by Aaron Reed (revised by Nathanael Nerode).

Changelog:

	1.0.240121: Broken out from Compliant Characters and made fancy for use in Remembering.


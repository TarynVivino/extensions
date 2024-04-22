Version 1.0.240122 of Reparse by Nathanael Nerode begins here.

"Provides a hook for the game, or other extensions, to send a different command through the parser."

Chapter - Core Reparsing

Section - Command Debugging

Use command debugging translates as a configuration flag.

Section - Special Reparse Flag

[Are we currently heading into a reparse?]
The special reparse flag is a truth state that varies.

Section - Revised Command Text For Reparsing

[This is the text to be reparsed]
The revised command text for reparsing is a text that varies.

Section - Reparse Silently Flag

[Should we issue no command clarification when we reparse?]
The reparse silently flag is a truth state that varies.

Section - Reparsing

[This is done when the action decides to kick the command back to reparse.]
[Sometimes we can't decide to do that until after the action has triggered.]

[The reparse is actually done by moving on to the next cycle in the turn sequence.  But we don't want to advance the turn count.]
[So this is injected just after the action, and before anything else happens.]
[This will terminate processing of the turn rulebook completely, in particular before time is advanced.]
The turn terminated for reparsing rule is listed before the early scene changing stage rule in the turn sequence rulebook.
This is the turn terminated for reparsing rule:
    if the special reparse flag is true, rule succeeds.

[Replace the command reading routine with one which simply processes our prepackaged command.]
For reading a command when the special reparse flag is true (this is the parse revised command rule):
	if the command debugging option is active or the reparse silently flag is false:
		say "([revised command text for reparsing])[command clarification break]";
	change the text of the player's command to the revised command text for reparsing;
	now the special reparse flag is false;

Section - Request reparsing by phrase

To reparse with/using the/a/-- command/-- (T - a text), silently:
	now the revised command text for reparsing is the substituted form of T;
	now the special reparse flag is true;
	if silently:
		now the reparse silently flag is true;
	otherwise:
		now the reparse silently flag is false;

Reparse ends here.

The basic operation of this extension is to run a phrase, then consider a rule or rulebook, and finally undo the phrase while preserving the outcome of the rule. For example:

	This is the check player's pulse rule:
		if the game ended in death, rule fails; otherwise rule succeeds.
	
	...
	
	hypothetically try drinking the poison and consider the check player's pulse rule;
	if the rule failed, say "Drinking the poison would be a bad idea.";

Here, the phrase we're hypothetically running is "try drinking the poison". The "check player's pulse" rule tests whether the player has died after drinking the poison. The extension then undoes the drinking action, but remembers the decision made by the check player's pulse rule.

In fact, we can hypothetically run any phrase, not just an action:

	To drink everything:
		repeat with X running through things that can be touched by the player:
			try drinking X.
	
	...
	
	hypothetically drink everything and consider the check player's pulse rule;

The player won't see any messages about things that happened hypothetically, because this extension captures the text printed during hypothetical execution. Our rule can check "[the hypothetical output]" to see what was printed. (If the rule itself prints anything, though, the player will see it.) For example:

	This is the check for interesting events rule:
		if "[the hypothetical output]" exactly matches the regular expression "\s*Time passes\.\s*", rule fails;
		otherwise rule succeeds.
	
	...
	
	hypothetically try waiting and consider the check for interesting events rule;

The maximum length of captured text is 256 characters by default; anything more will be thrown away. We can change this with a use option:

	Use hypothetical output length of at least 1024.

Section: Caveats

This extension requires an interpreter that supports undo. To the best of the author's knowledge, every Glulx interpreter supports undo, so this isn't much of an issue.

Avoid hypothetically running any code that uses undo, or that hypothetically runs some other code in turn.

If the hypothetical code changes the Glk library state (opening windows, closing streams, moving the cursor, etc.) these changes will not be rolled back when hypothetical execution is finished.

Section: Change Log

Version 2 fixes a paragraph spacing issue where multiple hypotheticals would cause extra line breaks; and prevents hypothetical changes to the random number generator, I/O system, and string decoding table from leaking back into reality.

Version 3 was updated for compatibility with 6L38 by Emily Short.

Version 4 was updated for compatibility with 6M62.


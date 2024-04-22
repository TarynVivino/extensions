Undo Output Control patches the I6 template routines Keyboard(); and Perform_Undo(); so that we can use I7 rulebooks to hook into the UNDO command. These allow us to do anything we like--write new messages for UNDO responses and error text, keep track of variables (partially) independently of the game state as restored by UNDO, and even suspend UNDO programmatically.

Section - Output rules

The basic rulebooks provided by Undo Output Control are:
	
	(1) before undoing an action rules
	(2) after undoing an action rules
	(3) report undoing an action rules

These rulebooks provide hooks into the following "moments" in the UNDO process: (1) before testing whether UNDO is allowed/possible; (2) after an action has been _successfully_ undone; and (3) after an action has been successfully undone but immediately before it is reported, optionally allowing us to replace Inform's default output with our own. The report undoing an action rules should end explicitly in either success or failure. The rulebook will end in failure by default, which means that Inform's default reporting for UNDO will be printed. If you want to substitute Inform's reporting with your own, end your report undoing an action rule with "rule succeeds" or equivalent (see the example for a demonstration).

The same is true of the more specialized rules:

	report prevented undo rules
	report interpreter-undo-incapacity rules
	report interpreter undo failure rules
	report nothing to be undone failure rules

All of these also require a rule to end explicitly with "success" in order to replace the default output.

A number of rules are provided as "before" and "after" counterparts of these rules:

	before prevented undo rules
	after prevented undo rules
	before interpreter-undo-incapacity rules
	after interpreter-undo-incapacity rules
	before interpreter undo failure rules
	after interpreter undo failure rules
	before nothing to be undone failure rules
	after nothing to be undone failure rules
	
The before, after, and report prevented undo rules apply only when Inform's built-in use undo prevention option is enabled.

It should be emphasized that, though these rules look like standard action rulebooks, they are not. UNDO is not an action, and these rules are limited to imitating the appearance of action rules. This is why "check undoing" and "instead of undoing" rulebooks are not provided. We have hooks into the output, but little else.

However, it should be noted that when the before undoing an action rulebook ends in explicit failure, undo will be prevented from occurring; this is one way (perhaps the simplest) of disabling UNDO. An example:

	Before undoing an action when the player is tired:
		say "You are too tired to bend space-time to your will.";
		rule fails.

The "Breaking Glass" example provides examples of ways to use both the before and after undoing entry points to accomplish interesting effects.


Section - Undo suspension

Undo Output Control provides a second mechanism for suspending UNDO. To turn UNDO on and off at will, we simply use these phrases:

	suspend undo
	reinstate undo

Note that these will not function if we have used Inform's built-in undo prevention, which functions globally.

We can also test whether UNDO is disabled using the "if undo is suspended" condition.

Finally, a rulebook is provided that allows us to control the reporting of a failed attempt to UNDO while undo is suspended:

	report attempt to undo-while-disabled rules

By default, these rules print the message "That action cannot be undone."

Be warned that if the player types UNDO immediately after you have reinstated it, there may be unexpected behavior, as the game can revert to the suspended state, but in such a way that the report attempt to undo-while-disabled rules do not fire.


Section - Removing the option to UNDO at the end of the game

Note that the "before undoing an action rule" is NOT consulted after the game has finished, so we will not be able to use it to block UNDO at that point. Instead, we should simply remove UNDO from the list of options that are presented at the end of the game ("Would you like to RESTART, RESTORE a saved game, QUIT or UNDO the last command?"). We can do so by removing it from the Table of Final Question Options, like this:

	When play begins:
		choose row with a final response rule of immediately undo rule in the Table of Final Question Options;
		delete the final question wording entry.

This can be done conditionally if needed. We just need to delete the table row before the command to end the game.


Section - Temporary suspension of game state saving

Each turn, after the player has entered a command but before the command is parsed, Inform saves the state of the game into memory. This is the saved state to which the next UNDO command will revert.  (When it comes back it will get a new command from the command line.)  We can stop the game from saving the undo state, if desired. Once we've disabled saving, an UNDO typed later will revert back to the last saved state. If there are no saved undo states available, a message will print ("You cannot undo any further" by default).

Undo Output Control provides the following phrases for controlling undo saves:

	disable saving of undo state
	enable saving of undo state

See the "Purgatory" example below for a demonstration of how this feature might be used.

Section - Changing vocabulary for UNDO and OOPS

As was mentioned above, UNDO is not an action. Along with OOPS, it is handled before the player's command is actually parsed. To decide whether the player has typed either of these commands, Inform looks at the first word--only!--of the player's input and compares it to a character string (defined as an I6 constant).

In v10 of Inform, there is a clean way to do this.  There are three "undo words" and three "oops words".  This is how to replace them (with their default values noted):

	Include (-
		Constant UNDO1__WD = 'undo';
	-) replacing "UNDO1__WD"
	Include (-
		Constant UNDO2__WD = 'undo';
	-) replacing "UNDO2__WD"
	Include (-
		Constant UNDO3__WD = 'undo';
	-) replacing "UNDO3__WD"
	Include (-
		Constant OOPS1__WD = 'oops';
	-) replacing "OOPS1__WD"
	Include (-
		Constant OOPS2__WD = 'o//';
	-) replacing "OOPS2__WD"
	Include (-
		Constant OOPS3__WD = 'oops';
	-) replacing "OOPS3__WD"

Note that oops word #2 is a single-letter abbreviation; two forward slashes are required after single-letter words for Inform to understand them.

If the word contains a space, it will never be matched, as follows; this can be used to disable oops:
	Include (-
		Constant OOPS2__WD = ' x';
	-) replacing "OOPS2__WD"

There was not a clean way to do this in earlier versions, and so older versions of this extension provided one.  If you were using the "to decide which value is undo word #3" facility from a previous version of this extension, please update your code.

Section - Undoing the current turn

While UNDO is not an action, it is possible to trigger undo from an action.  Under the hood, Inform saves the game after reading a command but before parsing it.  UNDO then restores to this point, with a signal to read a new command.  Inform must do the save very early in the command processing cycle in order to avoid any accidental side-effects in author-written parsing or action processing routines.  However,  UNDO (and OOPS) have to be processed before this save; otherwise they will restore to just before the player typed "UNDO", rather than before the previous command!

However, you can use this to your advantage.  If at the end of a very long and complicated turn which changed a lot of world state, you decide the player probably shouldn't have done that, you can issue an undo order and restore the game to just before the player issued that command.  This will undo the current turn -- not the previous turn.

	undo the current turn;

This can be combined with "disable saving of undo state", as demonstrated in "Purgatory II".

You can also prevent the player from undoing and still use this in your code.


Section - Repairing an empty command

This version integrates the extension Empty Command Handling by Daniel Stelzer, based on code by Matt Weiner.  Because Empty Command Handling replaces the same underlying library code as Undo Output Control, it cannot be used with Empty Command Handling; so the entirety of the extension has been integrated.

This extension adds a new activity, "repairing an empty command". When the player presses ENTER at the prompt, without typing anything, the "repairing an empty command" activity will be run before showing the parser error. This can be used to give better responses to empty input without hacking into the response system.

For instance:

Rule for repairing an empty command: change the text of the player's command to "look".

This happens early enough in parsing that even special commands like "undo" and "oops", or a sequence of commands separated by periods, can be inserted.

Section - Extension not compatible with Conditional Undo by Jesse McGrew

The current version of this extension is no longer compatible with Jesse McGrew's Conditional Undo extension, which doesn't compile with Inform v10.1 anyway.  Everything in Conditional Undo can be done by this extension but the interface is substantially different.

Section - Using this extension with Unified Glulx Input by Andrew Plotkin

Unified Glulx Input support is UNTESTED in Inform v10.1 and is quite likely to be broken.

Unified Glulx Input has its own method for turning UNDO on and off; these all work, as do the methods in this extension.

Unified Glulx Input has its own (superior) method for dealing with blank lines; "repairing an empty command" is not implemented.

Section - Changelog

	7.1.230728: Fix accidental -) which prevented compilation & additional conformity with core inform code.
7.0.230722: Update to current version of Inform (cleanups in the core code which we copy)
	6.0.220529: Example cleanups idenified by automated testing.
	6.0.220527: Example cleanups to facilitate automated testing.
	v6 - Update to Inform v10.1.0.  (Nathanael Nerode.)  Eliminate compatibility with Conditional Undo by Jesse McGrew.  Eliminate "undo word #1" in favor of new "Include (- -) replacing UNDO1__WD" syntax.
	v5 - Add "undo the current turn", documentation, and example.  (Nathanael Nerode)  Integrate Empty Command Handling by Daniel Stelzer.  Make compatible with Unified Glulx Input.
	v4 - Substantial updates by Nathanael Nerode.  Update to 6M62.  Fix bugs. Improve documentation.
	v3 - Removed unnecessary check of the "before undoing an action" rulebook at the end of the game. This caused an UNDO typed at the end of the game to fail silently.
	v2 - Added suspension of game state saving and the Breaking Glass and Purgatory examples. Also added the ability to change word constants. Fixed minor bug in operation of undo suspension.
	v1 - Initial release.

Section - Examples

	All the examples are by Erik Temple from the original Undo Output Control.


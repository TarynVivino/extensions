Version 2.0.1 of Reversed Persuasion Correction by Juhana Leinonen begins here.

"Automatically corrects commands given to NPCs where the order is reversed, for example HELLO, ALICE instead of ALICE, HELLO."

Use silent persuasion correction translates as (- Constant SILENT_REVERSING; -). 
Definition: a person is commandable if it can be seen by the player.
The looping-failsafe is a truth state that varies. Looping-failsafe is false.

After reading a command (this is the correct reversed persuasion rule):
	[chained commands are too complex to handle, so we'll skip the rule altogether if they turn up.]
	if the player's command matches the regular expression "\..+":
		continue the action;
	[If the player types in an ambiguous name (for example there are two Bobs in the room and the player commands BOB, HELLO), the parser jumps to asking the disambiguation question right in the middle of this rule. When the player answers, this rule fires again, so we'll have to handle that.]
	if the player's command includes "xxzzyyzzxx":
		continue the action;
	let T be indexed text;
	let T be the player's command;
	let original command be indexed text;
	let original command be the player's command;
	if the original command matches the regular expression ",":
		replace the regular expression "\s*,\s*" in T with " xxzzyyzzxx ";
		change the text of the player's command to T;
		now looping-failsafe is true;
		if the player's command includes "[a commandable person] xxzzyyzzxx": [the command was correct]
			if looping-failsafe is false:
				continue the action; [if we have already parsed the command successfully we don't need to go on]
			change the text of the player's command to the original command;
		otherwise:
			if looping-failsafe is false:
				continue the action;
			let T be the player's command;
			replace the regular expression "(.*) xxzzyyzzxx (\P*)" in T with "\2 xxzzyyzzxx \1"; [the \P takes only non-punctuation characters so commands like "how's it going, bob?" won't confuse the system]
			change the text of the player's command to T; 
			now looping-failsafe is true;
			if the player's command includes "[a commandable person] xxzzyyzzxx": [retrying to see whether switching the order makes it better]
				if looping-failsafe is false:
					continue the action;
				replace the regular expression " xxzzyyzzxx" in T with ",";
				change the text of the player's command to T; 
				if the silent persuasion correction option is not active:
					let the correct-command be the original command;
					replace the regular expression "(.*), *(\P*)" in correct-command with "\2, \1";
					say "([the correct-command])[command clarification break]";
			otherwise:
				if looping-failsafe is false:
					continue the action;
				let T be the player's command;
				replace the regular expression "(.*) xxzzyyzzxx (.*)" in T with "\2, \1";
				change the text of the player's command to T;
	now looping-failsafe is false.


Reversed Persuasion Correction ends here.


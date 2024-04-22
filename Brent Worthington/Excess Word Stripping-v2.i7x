Version 2 of Excess Word Stripping by Brent Worthington begins here.

"Allows commands that are only partly understood to be reparsed after trimming off the bits not understood."

The correct word count is a number that varies.

To decide what number is the/-- word number: (- wn -).

To decide what number is the/-- number of words matched: (- pcount2 -).

To decide what number is the/-- alternative number of words matched: (- pattern2-->0 -).

The whole command is an indexed text that varies. The first command is an indexed text that varies. The last command is an indexed text that varies.

The parser error flag is a truth state that varies. The parser error flag is false.

Rule for printing a parser error when the latest parser error is the only understood as far as error (this is the trim unrecognised words rule):
now the correct word count is the number of words matched;
if the correct word count is at least the number of words in the player's command, continue the activity;
now the whole command is the player's command;
now the parser error flag is true;
now the first command is "";
now the last command is "";
repeat with count running from 1 to the number of unpunctuated words in the whole command begin;
if the unpunctuated word number count in the whole command matches the regular expression "\b(my|this|these|that|those|his|her|their)\b", increment the correct word count;
if the unpunctuated word number count in the whole command matches the regular expression "\b(its|the|a|an|some|lit|lighted|unlit)\b", increment the correct word count;
if the count is greater than the correct word count begin;
if the last command is "" begin;
now the last command is unpunctuated word number count in the whole command;
otherwise;
now the last command is "[last command] [unpunctuated word number count in the whole command]";
end if;
otherwise;
if the first command is "" begin;
now the first command is unpunctuated word number count in the whole command;
otherwise;
now the first command is "[first command] [unpunctuated word number count in the whole command]";
end if;
end if;
end repeat;
carry out the clarifying a shortened command activity.

Clarifying a shortened command is an activity.

Last for clarifying a shortened command (this is the standard clarifying a shortened command rule): say "(first removing the text[if the last command is not empty] '[last command]'[end if])[command clarification break]".

Rule for reading a command when the parser error flag is true (this is the reparse a shortened command rule):
now the parser error flag is false;
change the text of the player's command to the first command;
say run paragraph on.

Excess Word Stripping ends here.

---- DOCUMENTATION ----

This extension allows commands that are only partly understood to be reparsed after trimming off the bits not understood. The aim of this is to try to catch more of what a player intends when they type a command with words that the parser doesn't understand. The extension is limited in its scope to just removing words from the end of phrases.

Example: * Matters of the Tart - In which the player's loquaciousness is trimmed down to the parser's level of understanding.

	*:"Matters of the Tart"

	Include Excess Word Stripping by Brent Worthington.

	The Kitchen is a room. "The kitchen is warm and inviting and enveloped in the smell of freshly cooked tart.".

	The oven is in the kitchen. The tart is on the oven.

	The description of the tart is "It's a small plum tart made without any sugar, so it should prove to be quite tart for a tart.".

	Test me with "take the tart with care / drop the tart savagely".

Example: * Cave-troll - Determining that the command the player typed is invalid, editing it, and re-examining it to see whether it now reads correctly.

	*:"Cave Troll"

	Include Excess Word Stripping by Brent Worthington.

	The Cave is a room.

	The troll is a man in the cave. "A troll looms over you. All you have is your sword."

	Instead of attacking the troll:
		say "Finally, violence is the answer to this one...";
		end the story.

	The player carries a sword.

	Test me with "attack troll with sword".

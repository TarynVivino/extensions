Version 2.0.1 of Commonly Unimplemented by Aaron Reed begins here.

"Responds to attempts to interact with unimplemented clothing, body parts, or generic surroundings. Requires Smarter Parser by Aaron Reed."

Chapter - Compatibility

Section - Inclusions

Include Version 16 of Smarter Parser by Aaron Reed.

Chapter - Sequence

The flexible stripping body parts rule is listed before the unnecessary possessives rule in the Smarter Parser rules. The usually no clothing rule is listed before the unnecessary possessives rule in the Smarter Parser rules. The generic surroundings rule is listed before the unnecessary possessives rule in the Smarter Parser rules.

Chapter - Altering Lists

Section - Utility Functions - unindexed

To decide what indexed text is remove_list_word (wd - indexed text) from (thelist - an indexed text):
	unless wd is empty:
		replace the regular expression "\|[wd]" in thelist with "";
		decide on thelist;
	
To decide what indexed text is remove_list_words (wds - list of indexed texts) from (thelist - an indexed text):
	repeat with wd running through wds:
		now thelist is remove_list_word "[wd]" from thelist;
	decide on thelist;
		
To show_list_words for (thelist - an indexed text):
	let output be indexed text;
	now output is thelist;
	replace the regular expression "\(~!\|" in output with "";
	replace the regular expression "\)~?" in output with "";
	replace the regular expression "\|" in output with ", ";
	say output;
	say line break.
	
Section - Forward-facing phrases

To release body part word (wd - indexed text) from Smarter Parser:
	now body_part_words is remove_list_word wd from body_part_words.

To release body part words (wds - list of indexed texts) from Smarter Parser:
	now body_part_words is remove_list_words wds from body_part_words.
	
To say body part words:
	show_list_words for body_part_words.

To release clothing word (wd - indexed text) from Smarter Parser:
	now clothing_words is remove_list_word wd from clothing_words.

To release clothing words (wds - list of indexed texts) from Smarter Parser:
	now clothing_words is remove_list_words wds from clothing_words.
	
To say clothing words:
	show_list_words for clothing_words.
	
To release surroundings word (wd - indexed text) from Smarter Parser:
	now surroundings_words is remove_list_word wd from surroundings_words.

To release surroundings words (wds - list of indexed texts) from Smarter Parser:
	now surroundings_words is remove_list_words wds from surroundings_words.
	
To say surroundings words:
	show_list_words for clothing_words.	


Chapter - Rules

Section - New Stripping Body Parts

body_part_words is an indexed text variable. body_part_words is "(~!|eye|head|skull|hair|nose|mouth|ear|cheek|forehead|face|neck|chest|gut|breast|belly|stomach|body|nipple|shoulder|collar|arm|wrist|hand|finger|knuckle|fingernail|waist|thigh|leg|knee|shin|ankle|foot|feet|toe|elbow|fist|thumb|tongue|lip|heart)~".

A smarter parser rule when sp_normal (this is the flexible stripping body parts rule):
	let last_word_pos be the number of words in reborn command;
	let last_word be indexed text;
	now last_word is word number last_word_pos in reborn command;
	if sp_regex last_word starts with body_part_words:
		identify error as flexible stripping body parts rule;
		replace word number last_word_pos in reborn command with "_body";
		if stripping "(on|in) ?(the|his|her|a|their|my)? _body" is fruitful or stripping "[apostrophe]?s _body" is fruitful, even within words: 
			identify error as flexible stripping body parts rule;
			reparse the command;
		else:
			reject the command.

Table of Smarter Parser Messages (continued)
rule name	message
flexible stripping body parts rule	"[as the parser]You do not normally need to refer to parts of the body.[as normal]"


Section - Clothing

clothing_words is an indexed text variable. clothing_words is "(~!|clothes|shirt|pant|jacket|sock|shoe|belt|hat|underwear|jean|trouser|pocket)~".

A smarter parser rule when sp_normal (this is the usually no clothing rule):
	let last_word_pos be the number of words in reborn command;
	let last_word be indexed text;
	now last_word is word number last_word_pos in reborn command;
	if sp_regex last_word starts with clothing_words:
		identify error as usually no clothing rule;
		reject the command.

Table of Smarter Parser Messages (continued)
rule name	message
usually no clothing rule	"[as the parser]You do not normally need to refer to articles of clothing.[as normal]"

Section - Surroundings

surroundings_words is an indexed text variable. surroundings_words is "(~!|ground|floor|wall|corner|ceiling|sky)~".

A smarter parser rule when sp_normal (this is the generic surroundings rule):
	let last_word_pos be the number of words in reborn command;
	let last_word be indexed text;
	now last_word is word number last_word_pos in reborn command;
	if sp_regex last_word starts with surroundings_words:
		identify error as generic surroundings rule;
		reject the command.

Table of Smarter Parser Messages (continued)
rule name		message
generic surroundings rule		"[as the parser]Unless specifically mentioned by the text, avoid general concepts like the floor and ceiling. Try typing LOOK and then using verbs like TAKE or EXAMINE on the things you see mentioned.[as normal]"

Commonly Unimplemented ends here.

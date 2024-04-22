Version 8.0.1 of Poor Man's Mistype by Aaron Reed begins here.

"Adds basic typo correction by checking the first few letters of misunderstood input against the printed names of nearby objects. Requires version 15 of Smarter Parser by Aaron Reed. Supports Scope Caching by Mike Ciul for faster performance."

[Versions:
 -- Version 8: Added support for Scope Caching for faster speed; moved position of first bad word check into Smarter Parser, so this now requires v15 of that.
 -- Version 7: Fixed a bug in GetFirstNonDictWord that was leaving the word counter in an unexpected place.
 -- Version 6: Doesn't try to correct one or two character words; catches misspelled articles and a few common misspelled verbs.
 -- Version 5: Documentation updates.
 -- Version 4: Updated for compatibility with Version 6 of Smarter Parser; fixed a bug where upper-case letters would break matches; fixed a bug where a comma in the command could lead to mistaken matches.
 -- Version 3: Fixed a documentation error.
 -- Version 2: Removed checking for misspelled verbs, since this has caused problems for some people; simplified removal of Smarter Parser rules.
]


Chapter - Compatibility

Section - Inclusions

Include Version 16 of Smarter Parser by Aaron Reed.

Chapter - Sequence

The Poor Man's Mistype rule is listed before the stripping unnecessary addendum rule in the Smarter Parser rules. The strip misspelled articles rule is listed before the Poor Man's Mistype rule in the Smarter Parser rules. 

Chapter - Rules

A smarter parser rule (this is the strip misspelled articles rule):
	if stripping "(teh|th)" is fruitful:
		identify error as strip misspelled articles rule;
		reparse the command.		

A smarter parser rule (this is the Poor Man's Mistype rule):
	let wnum be the position of first bad word;
	if wnum > 0:
		let badword be indexed text;
		now badword is word number wnum in reborn command;
		if the number of characters in badword < 3, no match;
		let first3 be indexed text;
		now first3 is "[character number 1 in badword][character number 2 in badword][character number 3 in badword]";
		let candidate be indexed text;
		repeat with item running through things enclosed by location:
			if item is visible:
				now candidate is printed name of item in lower case;
				if candidate matches the regular expression "\b[first3]":
					repeat with wordcounter running from 1 to the number of words in candidate:
						if word number wordcounter in candidate matches the regular expression "\b[first3]":
							replace the regular expression "\b[badword]\b" in the reborn command with "[word number wordcounter in candidate]";
							identify error as the Poor Man's Mistype rule;
							reparse the command.

A smarter parser rule (this is the most common verb misspellings rule):
	if the latest parser error is the not a verb I recognise error:
		if input contains "^(lok|loook|ook)":
			identify error as most common verb misspellings rule;
			replace the regular expression text matching subexpression 1 in the reborn command with "look";
			reparse the command;
		if input contains "^(tkae)":
			identify error as most common verb misspellings rule;
			replace the regular expression text matching subexpression 1 in the reborn command with "take";
			reparse the command.
			
Chapter - Faster Mistype (for use with Scope Caching by Mike Ciul)

The faster Poor Man's Mistype rule is listed instead of the Poor Man's Mistype rule in the smarter parser rules.

This is the faster Poor Man's Mistype rule:
	let wnum be the position of first bad word;
	if wnum > 0:
		let badword be indexed text;
		now badword is word number wnum in reborn command;
		if the number of characters in badword < 3, no match;
		let first3 be indexed text;
		now first3 is "[character number 1 in badword][character number 2 in badword][character number 3 in badword]";
		let candidate be indexed text;
		repeat with item running through marked visible things:
			now candidate is printed name of item in lower case;
			if candidate matches the regular expression "\b[first3]":
				repeat with wordcounter running from 1 to the number of words in candidate:
					if word number wordcounter in candidate matches the regular expression "\b[first3]":
						replace the regular expression "\b[badword]\b" in the reborn command with "[word number wordcounter in candidate]";
						identify error as the Poor Man's Mistype rule;
						reparse the command.
		

Poor Man's Mistype ends here.

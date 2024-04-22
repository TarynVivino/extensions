Version 4.2.1 of Achievements by Mikael Segercrantz begins here.

"A table-based way to assign scores for actions, rooms and objects."

Use scoring.

Chapter 1 - The objects

Section 1(a) - Table of Achievements

Table of Achievements
message (text)		points (a number)		used (a number)
--		--		--


Section 1(b) - Table of Scored Objects

Table of Scored Objects
object (a thing)		points (a number)		used (a number)
--		--		--	


Section 1(c) - Table of Scored Places

Table of Scored Places
loci (a room)		points (a number)		used (a number)
--		--		--


Section 1(d) - Globals

Achievement-Init is a number which varies. Achievement-Init is 0.

The achievement maximum score is a number which varies. The achievement maximum score is 0.


Section 1(e) - Text variables

Achievement in-that-game-you-scored-unranked is text that varies. Achievement in-that-game-you-scored-unranked is "In that game you scored [score] out of a possible [achievement maximum score], in [turn count] turn[s].[line break]".
Achievement in-that-game-you-scored-ranked is text that varies. Achievement in-that-game-you-scored-ranked is "In that game you scored [score] out of a possible [achievement maximum score], in [turn count] turn[s][achievement short-ranking]".
Achievement in-that-game-you-scored is text that varies. Achievement in-that-game-you-scored is "[if using ranking][achievement in-that-game-you-scored-ranked][otherwise][achievement in-that-game-you-scored-unranked][end if]".

Achievement you-have-scored-unranked is text that varies. Achievement you-have-scored-unranked is "You have so far scored [score] out of a possible [achievement maximum score], in [turn count] turn[s].[line break]".
Achievement you-have-scored-ranked is text that varies. Achievement you-have-scored-ranked is "You have so far scored [score] out of a possible [achievement maximum score], in [turn count] turn[s][achievement short-ranking]".
Achievement you-have-scored is text that varies. Achievement you-have-scored is "[if using ranking][achievement you-have-scored-ranked][otherwise][achievement you-have-scored-unranked][end if]".

Achievement you-have-not-received-unranked is text that varies. Achievement you-have-not-received-unranked is "You have not received any points yet.[line break]".
Achievement you-have-not-received-ranked is text that varies. Achievement you-have-not-received-ranked is "You have not received any points yet[achievement short-ranking]".
Achievement you-have-not-received is text that varies. Achievement you-have-not-received is "[if using ranking][achievement you-have-not-received-ranked][otherwise][achievement you-have-not-received-unranked][end if]".

Achievement for-only is text that varies. Achievement for-only is "for";

Achievement out-of-unranked is text that varies. Achievement out-of-unranked is "(out of [achievement maximum score])[line break]".
Achievement out-of-ranked is text that varies. Achievement out-of-ranked is "(out of [achievement maximum score])[line break][achievement long-ranking]".
Achievement out-of is text that varies. Achievement out-of is "[if using ranking][achievement out-of-ranked][otherwise][achievement out-of-unranked][end if]".

Achievement short-ranking is text that varies. Achievement short-ranking is ", giving you a rank of [announce the ranking].[line break]".
Achievement long-ranking is text that varies. Achievement long-ranking is "[line break]This gives you a rank of [announce the ranking].[line break]".

Achievement locating-various-objects is text that varies. Achievement locating-various-objects is "locating sundry items".
Achievement finding-various-places is text that varies. Achievement finding-various-places is "finding various places".

Chapter 2 - Rules


Section 2(a) - Overriding the standard rules

The announce the short score rule substitutes for the announce the score rule.
The announce the final score rule substitutes for the print final score rule.

Section 2(b) - Final question

Table of Final Question Options (continued)
final question wording	only if victorious		topic		final response rule		final response activity
"view the FULL score"	false			"full"		announce the achievements rule	--


Section 2(c) - Miscellaneous rules

To pad (n - a number):
	let m be n;
	if n is less than 0:
       		let n be n multiplied by -1;
		let n be n multiplied by 10;
	say "  ";
	if n is less than 10:
		say "   ";
	otherwise if n is less than 100:
		say "  ";
	otherwise if n is less than 1000:
		say " ";
	say m;
	say " ".


Section 2(d) - Full score replacement rules

This is the announce the died achievement score rule:
	say "[achievement in-that-game-you-scored]".

To announce the beginning of full score:
	say "[achievement you-have-scored]".

To announce the tabled part of full score:
	repeat through the Table of Achievements in used order:
		if the used entry is greater than 0:
			let n be the points entry;
			pad n;
			say "[achievement for-only] [message entry][line break]".

To announce the tabled objects of full score:
	let total be 0;
	repeat through the Table of Scored Objects:
		if the used entry is not 0, increase the total by the points entry;
	if total is not 0:
		pad total;
		say "[achievement for-only] [achievement locating-various-objects][line break]".

To announce the tabled rooms of full score:
	let total be 0;
	repeat through the Table of Scored Places:
		if the used entry is not 0, increase the total by the points entry;
	if total is not 0:
		pad total;
		say "[achievement for-only] [achievement finding-various-places][line break]".

To announce the end of full score:
	pad score;
	say "[achievement out-of]";

To announce the no score:
	say "[achievement you-have-not-received]".


Section 2(e) - Announce the achievements rule

This is the announce the achievements rule:
	if the score is greater than 0:
		announce the beginning of full score;
		announce the tabled part of full score;
		announce the tabled objects of full score;
		announce the tabled rooms of full score;
		announce the end of full score;
	otherwise:
		announce the no score.


Section 2(f) - Ranking

Table of Achievement Rankings
minimum (a number)	rank (text)
--	--


To decide whether using ranking:
	if the number of filled rows in the Table of Achievement Rankings is at least 1, decide yes;
	decide no.

To say announce the ranking:
	let mentioned be 0;
	let closest be -32767;
	let difference be 32767;
	repeat through the Table of Achievement Rankings:
		if score is at least the minimum entry and score - the minimum entry is less than difference:
			now difference is score - the minimum entry;
			now closest is the minimum entry;
	repeat through the Table of Achievement Rankings:
		if mentioned is 0 and closest is the minimum entry:
			now mentioned is 1;
			say "[rank entry]";
	if mentioned is 0, say "*** ERROR: Unknown rank ***".


Section 2(g) - Replacing "score"

This is the announce the short score rule:
	say "[achievement you-have-scored]".

This is the announce the final score rule:
	say "[achievement in-that-game-you-scored]".


Section 2(h) - Score achievement

To score the achievement with message (msg - text):
	choose row with message of msg in the Table of Achievements;
	if the used entry is 0:
		now the used entry is the turn count;
		increase the score by the points entry.


Section 2(i) - Score objects

To score found objects:
	repeat through the Table of Scored Objects:
		if the used entry is 0:
			if the player encloses the object entry:
				now the used entry is the turn count;
				increase the score by the points entry.


Section 2(j) - Score rooms

To score visited rooms:
	repeat through the Table of Scored Places:
		if the used entry is 0:
			if the location is the loci entry:
				now the used entry is the turn count;
				increase the score by the points entry.


Section 2(k) - Initialization

To perform initialization:
	let the total be 0;
	repeat through the Table of Scored Places:
		now the used entry is 0;
		increase the total by the points entry;
		if the loci entry is the location:
			now the used entry is -1;
			increase the score by the points entry;
	repeat through the Table of Scored Objects:
		now the used entry is 0;
		increase the total by the points entry;
		if the object entry is enclosed by the player:
			now the used entry is -1;
			increase the score by the points entry;
	repeat through the Table of Achievements:
		increase the total by the points entry;
		now the used entry is 0;
	now the achievement maximum score is the total.

Before printing the name of a room:
	if Achievement-Init is 0:
		perform initialization;
		now Achievement-Init is 1.


Section 2(l) - Every turn

Every turn (this is the scoring of rooms and objects rule):
	score found objects;
	score visited rooms.


Section 2(m) - Decisions

To decide whether the achievement (txt - text) is scored:
	repeat through the Table of Achievements:
		if the message entry is txt:
			if the used entry is not 0, decide yes;
	decide no.

To decide whether the object (obj - a thing) is scored:
	repeat through the Table of Scored Objects:
		if the object entry is obj:
			if the used entry is not 0, decide yes;
	decide no.

To decide whether the room (rm - a room) is scored:
	repeat through the Table of Scored Places:
		if the loci entry is rm:
			if the used entry is not 0, decide yes;
	decide no.


Chapter 3 - Vocabulary

Section 3(a) - Full score

Understand "full score" or "full" or "fullscore" as requesting the full score.
Requesting the full score is an action out of world.
Carry out requesting the full score: follow the announce the achievements rule.


Achievements ends here.

Version 3.0.2 of Notepad by Jim Aikin begins here.

"A system for creating an in-game notepad that the player can write on."

Section 1 - Definitions


A notepad is a kind of thing. A notepad has a text called memo. The memo of a notepad is usually "". A notepad has a list of objects called allowed-pens. The allowed-pens of a notepad is usually {}. A notepad has a truth state called pen-needed. The pen-needed of a notepad is usually true. A notepad can be edit-allowing or non-edit-allowing. A notepad is usually edit-allowing.

Termination type is a kind of value. The termination types are terminated and unterminated.

To decide which termination type is the terminor of (T - text):
	let N be the number of characters in T;
	let C be text;
	let C be character number N in T;
	if C is ".":
		decide on terminated;
	otherwise if C is "?":
		decide on terminated;
	otherwise if C is "!":
		decide on terminated;
	decide on unterminated.
	
Section 2 - Reading

To protest (he protests, they protest, he protested, it is protested, he is protesting) is a verb.
To report (he reports, they report, he reported, it is reported, he is reporting) is a verb.
To read (he reads, they read, he read, it is read, he is reading) is a verb.

Understand the command "read" as something new.

Reading is an action applying to one visible thing and requiring light. Understand "read [something]" as reading.

Check an actor reading (this is the ordinary check reading rule):
	if the actor is the player:
		if the noun is not a notepad:
			try examining the noun instead;
		otherwise if the memo of the noun is "":
			say "At [that] moment, [the noun] [are] blank." (A) instead;
	otherwise:
		if the noun is not a notepad:
			say "[The actor] [are] unable to do that." (B);
			rule succeeds;
		otherwise if the memo of the noun is "":
			say "'But [the noun] [are] blank,' [the actor] [protest]." (C);
			rule succeeds.

Carry out an actor reading (this is the ordinary carry out reading rule):
	if the actor is the player:
		if the memo of the noun is not "":
			let term be the terminor of the memo of the noun;
			say "On [the noun] [are] written [run paragraph on]" (A);
			if term is terminated:
				say "'[memo of the noun]'[paragraph break]" (B);
			otherwise:
				say "'[memo of the noun].'" (C);
		otherwise:
			say "Nothing [are] written on [the noun]." (D);
	otherwise:
		if the memo of the noun is not "":
			say "'On [the noun] [are] written ['][memo of the noun]['],' [the actor] [report]." (E);
		otherwise:
			say "'Nothing [regarding nothing][are] written on [the noun],' [the actor] [report]." (F).

After examining a notepad (called N) (this is the notepad output rule):
	if the memo of N is not "":
		let term be the terminor of the memo of N;
		say "On [the N] [are] written [run paragraph on]" (A);
		if term is terminated:
			say "'[memo of N]'[paragraph break]" (B);
		otherwise:
			say "'[memo of N].'" (C).

Section 3 - Writing It On

To write (he writes, they write, he wrote, it is written, he is writing) is a verb.

Writing it on is an action applying to one topic and one thing and requiring light. Understand "write [text] on [something]", "scribble [text] on [something]", "scribble [text] in [something]", "write [text] in [something]", "jot [text] in [something]", and "jot [text] on [something]" as writing it on.

Check an actor writing on something (this is the ordinary check writing it on rule):
	let carrying-pen be a truth state;
	let carrying-pen be false;
	if the actor is the player:
		if the second noun is not a notepad:
			say "[The actor] [can't write] anything on [the second noun]." (A) instead;
		otherwise if the second noun is non-edit-allowing:
			say "[The second noun] [are] [currently]write-protected, and [can't] be written on." (B) instead;
		if the pen-needed of the second noun is true:
			repeat with P running through the allowed-pens of the second noun:
				if the player carries P:
					now carrying-pen is true;
		otherwise:
			now carrying-pen is true;
		if carrying-pen is false:
			say "[The actor] [have] nothing to write with." (C) instead;
	otherwise:
		if the second noun is not a notepad:
			say "[The actor] [are] unable to write anything on [the second noun]." (D);
			rule succeeds;
		otherwise if the second noun is non-edit-allowing:
			say "[The second noun] [are] [currently]write-protected, and [can't] be written on." (E);
			rule succeeds;
		if the pen-needed of the second noun is true:
			repeat with P running through the allowed-pens of the second noun:
				if the actor carries P:
					now carrying-pen is true;
		otherwise:
			now carrying-pen is true;
		if carrying-pen is false:
			say "[The actor] [have] nothing to write with." (F);
			rule succeeds.	
	
Carry out an actor writing on something (this is the ordinary carry out writing it on rule):
	let T be text;
	let T be the topic understood;
	now the memo of the second noun is T;
	say "[The actor] [write] '[T]' on [the second noun]." (A).

Section 4 - Adding It To

Adding it to is an action applying to one topic and one thing and requiring light. Understand "add [text] to [something]" and "append [text] to [something]" as adding it to.

To add (he adds, they add, he added, it is added, he is adding) is a verb.

Check an actor adding to something (this is the ordinary check adding it to rule):
	let carrying-pen be a truth state;
	let carrying-pen be false;
	if the second noun is not a notepad:
		say "[The actor] [can't] write anything on [the second noun]." (A);
		rule succeeds;
	otherwise if the second noun is non-edit-allowing:
		say "[The second noun] [are] [currently]write-protected, and [can't] be written on." (B);
		rule succeeds;
	if the pen-needed of the second noun is true:
		now carrying-pen is false;
		repeat with P running through the allowed-pens of the second noun:
			if the actor carries P:
				now carrying-pen is true;
	otherwise:
		now carrying-pen is true;
	if carrying-pen is false:
		say "[The actor] [have] nothing to write with." (C);
		rule succeeds.
		
To say now:
	if the story tense is past tense:
		say "then";
	else:
		say "now".
		
To say that:
	if the story tense is present tense:
		say "the";
	else:
		say "that".

[Note: There is a trailing space in "currently ", and after [currently] in text output, there is NO space.]

To say currently:
	if the story tense is past tense:
		say "";
	else:
		say "currently ".

Carry out an actor adding to something (this is the ordinary carry out adding it to rule):
	let T be text;
	let T be the topic understood;
	let C be text;
	let C be the memo of the second noun;
	now the memo of the second noun is "[C] [T]";
	say "[The actor] [add] [run paragraph on]" (A);
	say "to the text on [the second noun]. The text [regarding nothing][are] [now] [run paragraph on]" (B);
	let term be the terminor of the memo of the second noun;
	if term is terminated:
		say "'[memo of the second noun]'[paragraph break]" (C);
	otherwise:
		say "'[memo of the second noun].'" (D).

Section 5 - Copying It To

To copy (he copies, they copy, he copied, it is copied, he is copying) is a verb.

Copying it to is an action applying to two things and requiring light. Understand "copy [something] on [something]", "copy [something] to [something]", "copy [something] onto [something]", and "duplicate [something] on [something]" as copying it to.

Check an actor copying something to something (this is the ordinary check copying it to rule):
	let carrying-pen be a truth state;
	let carrying-pen be false;
	if the noun is not a notepad:
		say "No text [can] be copied from [the noun]." (A) instead;
	otherwise if the second noun is not a notepad:
		say "[The actor] [run paragraph on]" (B);
		say "[can't] copy text onto [the second noun]!" (C);
		rule succeeds;
	otherwise if the noun is the second noun:
		say "[The actor] [run paragraph on]" (D);
		say "[can't] copy something to itself." (E);
		rule succeeds;
	otherwise if the second noun is non-edit-allowing:
		say "[The second noun] [are] [currently]write-protected, and [can't] be written on." (F);
		rule succeeds;
	otherwise if the memo of the noun is "":
		say "At [that] moment, nothing [are] written on [the noun]." (G) instead;
	if the pen-needed of the second noun is true:
		now carrying-pen is false;
		repeat with P running through the allowed-pens of the second noun:
			if the player carries P:
				now carrying-pen is true;
	otherwise:
		now carrying-pen is true;
	if carrying-pen is false:
		say "[The actor] [have] nothing to write on [the second noun] with." (H);
		rule succeeds.
		
Carry out an actor copying something to something (this is the ordinary carry out copying it to rule):
	let T be text;
	let T be the memo of the noun;
	now the memo of the second noun is T;
	say "[The actor] [copy] the contents of [the noun] to [the second noun], so that [the second noun] [now] [regarding nothing][read] [run paragraph on]" (A);
	let term be the terminor of the memo of the second noun;
	if term is terminated:
		say "'[memo of the second noun]'[paragraph break]" (B);
	otherwise:
		say "'[memo of the second noun].'" (C).

Section 6 - Erasing

To erase (he erases, they erase, he erased, it is erased, he is erasing) is a verb.

Erasing is an action applying to one thing and requiring light. Understand "erase [something]" as erasing.

Check an actor erasing (this is the ordinary check erasing rule):
	if the noun is not a notepad:
		say "There [regarding nothing][are] nothing on [the noun] to erase." (A);
		rule succeeds;
	otherwise if the memo of the noun is "":
		say "At [that] moment, nothing [regarding nothing][are] written on [the noun]." (B);
		rule succeeds;
	otherwise if the noun is non-edit-allowing:
		say "[The noun] [are] [currently]write-protected, and [can't] be written on." (C);
		rule succeeds.

Carry out an actor erasing (this is the ordinary carry out erasing rule):
	now the memo of the noun is "";
	say "[The actor] [erase] what was written on [the noun], leaving [them] blank." (A).

Section 7 - Erasing It From

To leave (he leaves, they leave, he left, it is left, he is leaving) is a verb.

To seem (he seems, they seem, he seemed, it is seemingly, he is seeming) is a verb.

Erasing it from is an action applying to one topic and one thing and requiring light. Understand "erase [text] from [something]" and "delete [text] from [something]" as erasing it from.

Check an actor erasing from something (this is the ordinary check erasing it from rule):
	if the second noun is not a notepad:
		say "[The actor] [can't] erase anything from [the second noun]." (A);
		rule succeeds;
	otherwise if the memo of the second noun is "":
		say "Nothing [regarding nothing][are] written on [the second noun], so nothing [can] be erased." (B);
		rule succeeds;
	otherwise if the second noun is non-edit-allowing:
		say "[The second noun] [are] [currently]write-protected, and [can't] be written on." (C);
		rule succeeds.

Carry out an actor erasing from something (this is the ordinary carry out erasing it from rule):
	let T be text;
	let T be the topic understood;
	let C be text;
	let C be the memo of the second noun;
	if C matches the text T, case insensitively:
		replace the text T in C with "", case insensitively;
		[this next line gets rid of extra spaces when words are deleted:]
		replace the text "\s{2,}" in C with " ";
		[we'll also get rid of a first or trailing space:]
		let char be text;
		let char be character number 1 in C;
		if char is " ":
			replace character number 1 in C with "";
		let N be the number of characters in C;
		let char be character number N in C;
		if char is " ":
			replace character number N in C with "";
		now the memo of the second noun is C;
		say "The erasure [leave] [the second noun] reading [run paragraph on]" (A);
		let term be the terminor of the memo of the second noun;
		if term is terminated:
			say "'[memo of the second noun]'[paragraph break]" (B);
		otherwise:
			say "'[memo of the second noun].'" (C);
	otherwise:
		if the actor is the player:
			say "The text '[T]' [seem] not to be written anywhere on [the second noun]." (D);
		otherwise:
			say "'The text ['][T]['] [seem] not to be written anywhere on [the second noun],' [the actor] [report]." (E).

Section 8 - Protecting and Unprotecting

Protecting is an action out of world applying to one thing. Understand "protect [something]" as protecting.

Check protecting (this is the standard check protecting rule):
	if the noun is not a notepad:
		say "That action can't be used with [the noun]." (A) instead;
	otherwise if the noun is non-edit-allowing:
		say "[The noun] is already write-protected." (B) instead.

Carry out protecting:
	now the noun is non-edit-allowing. 

Report protecting (this is the standard report protecting rule):
	say "You have write-protected the text on [the noun]." (A).

Unprotecting is an action out of world applying to one thing. Understand "unprotect [something]" as unprotecting.

Check unprotecting (this is the standard check unprotecting rule):
	if the noun is not a notepad:
		say "That action can't be used with [the noun]." (A) instead;
	otherwise if the noun is edit-allowing:
		say "[The noun] [are] not [currently]write-protected." (B) instead.

Carry out unprotecting:
	now the noun is edit-allowing.

Report unprotecting (this is the standard report unprotecting rule):
	say "[The noun] [are] no longer write-protected." (A).

Notepad ends here.

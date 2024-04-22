Version 1.0.220524 of Character Portraits by Nathanael Nerode begins here.

"Provides a complex system for customzing the printed descriptions of characters wearing or carrying lots of stuff, similar to the room description system in Standard Rules.  Requires Large Game Speedup by Nathanael Nerode."

Include Large Game Speedup by Nathanael Nerode. [Needs my version to iterate over components.]

[FIXME: include the relevant bits of Parts while not fighting with the other version.]

Chapter - Expose concealment test to Inform 7

to decide whether (A - an object) conceals (B - an object):
	(- TestConcealment({A},{B}) -)

Chapter - Table of Portrait Priorities Management

[This is modeled on the Table of Locale Priorities, but the optimized version from Large Game Speedup (by Andrew Plotkin).]

The portrait-table-count is a number which varies.

Table of Portrait Priorities
notable-object (an object)	portrait description priority (a number)
--							--
with blank rows for each thing.

[TODO: Brutal waste of memory here....]

[This is based on the optimized version from Large Game Speedup.]
To set the/-- portrait priority of (O - an object) to (N - a number):
	if O is a thing:
		if N <= 0:
			now O is mentioned;
		[search the active part of the table for O; also note the first null row]
		let rownum be 0;
		let blanknum be 0;
		repeat with I running from 1 to portrait-table-count:
			choose row I in the Table of Portrait Priorities;
			if the notable-object entry is nothing:
				if blanknum is 0:
					now blanknum is I;
				next;
			if the notable-object entry is O: [found it]
				if N > 0: [change the existing row]
					now the portrait description priority entry is N;
				else: [delete the existing row, by putting in "nothing"]
					now the notable-object entry is nothing;
					now the portrait description priority entry is 32767; [Max size for Z-machine and probably large enough]
				stop;
		if N > 0: [didn't find it, but it should be mentioned]
			if blanknum is 0: [add a new row]
				increment portrait-table-count;
				choose row portrait-table-count in the Table of Portrait Priorities;
			else: [use the found null row]
				choose row blanknum in the Table of Portrait Priorities;
			now the notable-object entry is O;
			now the portrait description priority entry is N.

Chapter - Choosing What to List

Choosing notable portrait objects of something is an activity on objects.

For choosing notable portrait objects of something (called subject) (this is the show held and worn items in portrait rule):
	[First collect carried and worn things.]
	let the held item be the first thing held by the subject;
	while the held item is a thing:
		if the held item is worn by the subject:
			set the portrait priority of the held item to 10;
		otherwise: [carried]
			set the portrait priority of the held item to 30;			
		now the held item is the next thing held after the held item;
	continue the activity.

For choosing notable portrait objects of something (called subject) (this is the show body parts in portrait rule):
	[Now we have to collect body parts.  We use the Large Game Speedup extension, Parts section, to avoid going through every object in the game.]
	let the candidate be the first component of the subject;
	while the candidate is a thing:
		[Only include *described* body parts.]
		if the candidate provides the property description and the description of the candidate is not "":
			set the portrait priority of the candidate to 20;
		now the candidate is the next component after the candidate;
	continue the activity.

For choosing notable portrait objects of something (called subject) (this is the hide concealed objects from portrait rule):
	repeat with I running from 1 to portrait-table-count:
		choose row I in the Table of Portrait Priorities;
		if the subject conceals the notable-object entry:
			now the notable-object entry is nothing;
			now the portrait description priority entry is 32767; [Max size for Z-machine and probably large enough]
	continue the activity.

Chapter - Printing the Portrait Description

To describe portrait for (O - object):
	carry out the printing the portrait description activity with O. [SUBROUTINE CALL]

Printing the portrait description of something is an activity on objects.

Listing worn items in portrait of something is an activity on objects.
Listing carried items in portrait of something is an activity on objects.
Listing body parts in portrait of something is an activity on objects.
Listing miscellaneous items in portrait of something is an activity on objects.

The portrait sentence count is a number that varies.

Before printing the portrait description of something (called subject) (this is the initialise portrait description rule):
	now the portrait sentence count is 0;
	now the portrait-table-count is 0;  [Mark the table as empty without blanking every single row]
	continue the activity;

Before printing the portrait description of something (called subject) (this is the find notable portrait objects rule):
	carry out the choosing notable portrait objects activity with the subject; [SUBROUTINE CALL]
	continue the activity;

For printing the portrait description of something (called subject) (this is the interesting portrait sentences rule):
	sort the Table of Portrait Priorities up to row portrait-table-count in portrait description priority order;
	repeat with I running from 1 to portrait-table-count:
		let O be the notable-object in row I of the Table of Portrait Priorities;
		if O is not nothing:
			carry out the printing a portrait sentence about activity with O; [SUBROUTINE CALL]
			[Note that this also delists scenery and concealed objects]
	continue the activity;

For printing the portrait description of something (called subject) (this is the she is also wearing rule):
	let the mentionable count be 0;
	let the marked count be 0;
	rapidly set all things not marked for listing;  [loops through all things]
	repeat with I running from 1 to portrait-table-count:
		choose row I in the Table of Portrait Priorities;
		if the notable-object entry is not nothing and the notable-object entry is worn by the subject:
			increase the mentionable count by 1;
			if the portrait description priority entry is greater than 0 and the notable-object entry is not mentioned:
				[ Mark items with positive priority, not mentioned, and worn ]
				now the notable-object entry is marked for listing;
				set pronouns from the notable-object entry;
				increase the marked count by 1;
	if the mentionable count is greater than 0:
		[note that mentioned things have not been marked for listing]
		begin the listing worn items in portrait activity with the subject;
		if the marked count is 0:
			abandon the listing worn items in portrait activity with the subject;
		otherwise:
			if handling the listing worn items in portrait activity with the subject:
				let also be a text;
				if the portrait sentence count is greater than zero:
					let also be "also ";
				say "[regarding the subject][They]['re] [also]wearing " (A);
				[ filter list recursion to unmentioned things; ] [Probably unnecessary]
				[Note that marked items only restricts this to the worn items.]
				list the contents of the subject, as a sentence, including contents,
					giving brief inventory information, tersely, not listing
					concealed items, listing marked items only;
				say ".  [run paragraph on]" (B);
				increment the portrait sentence count;
				[ unfilter list recursion; ]
			end the listing worn items in portrait activity with the subject;
	continue the activity.

For printing the portrait description of something (called subject) (this is the you can also see her body parts rule):
	let the mentionable count be 0;
	let the marked count be 0;
	rapidly set all things not marked for listing;  [loops through all things]
	let the body parts list be a list of things;
	repeat with I running from 1 to portrait-table-count:
		choose row I in the Table of Portrait Priorities;
		if the notable-object entry is not nothing and the notable-object entry is part of the subject:
			increase the mentionable count by 1;
			if the portrait description priority entry is greater than 0 and the notable-object entry is not mentioned:
				[ Mark items with positive priority, not mentioned, and a body part of the right person ]
				now the notable-object entry is marked for listing;
				add the notable-object entry to the body parts list;
				set pronouns from the notable-object entry;
				increase the marked count by 1;
	if the mentionable count is greater than 0:
		[note that mentioned things have not been marked for listing]
		begin the listing body parts in portrait activity with the subject;
		if the marked count is 0:
			abandon the listing body parts in portrait activity with the subject;
		otherwise:
			if handling the listing body parts in portrait activity with the subject:
				[FIXME: This needs better text handling.]
				say "[regarding the subject][Possessive] [body parts list] [are] visible.  [run paragraph on]" (A);
				increment the portrait sentence count;
			end the listing body parts in portrait activity with the subject;
	continue the activity.

For printing the portrait description of something (called subject) (this is the she is also carrying rule):
	let the mentionable count be 0;
	let the marked count be 0;
	rapidly set all things not marked for listing;  [loops through all things]
	repeat with I running from 1 to portrait-table-count:
		choose row I in the Table of Portrait Priorities;
		if the notable-object entry is not nothing and the notable-object entry is carried by the subject:
			increase the mentionable count by 1;
			if the portrait description priority entry is greater than 0 and the notable-object entry is not mentioned:
				[ Mark items with positive priority, not mentioned, and carried ]
				now the notable-object entry is marked for listing;
				set pronouns from the notable-object entry;
				increase the marked count by 1;
	if the mentionable count is greater than 0:
		[note that mentioned things have not been marked for listing]
		begin the listing carried items in portrait activity with the subject;
		if the marked count is 0:
			abandon the listing carried items in portrait activity with the subject;
		otherwise:
			if handling the listing carried items in portrait activity with the subject:
				let also be a text;
				if the portrait sentence count is greater than zero:
					let also be "also ";
				say "[regarding the subject][They]['re] [also]carrying " (A);
				[ filter list recursion to unmentioned things; ] [Probably unnecessary]
				[Note that marked items only restricts this to the carried items.]
				list the contents of the subject, as a sentence, including contents,
					giving brief inventory information, tersely, not listing
					concealed items, listing marked items only;
				say ".  [run paragraph on]" (B);
				increment the portrait sentence count;
				[ unfilter list recursion; ]
			end the listing carried items in portrait activity with the subject;
	continue the activity.
	
For printing the portrait description of something (called subject) (this is the portrait you-can-also-see rule):
	[This is actually quite unlikely; the story author would need to add something to the priority table, but
		fail to give it a sentence of its own.  Although this runs though all things to print... it rarely triggers,
		so we don't bother to try to make it efficient.]
	let the mentionable count be 0;
	let the marked count be 0;
	rapidly set all things not marked for listing;  [loops through all things]
	repeat with I running from 1 to portrait-table-count:
		choose row I in the Table of Portrait Priorities;
		if the notable-object entry is not nothing:
			increase the mentionable count by 1;
			if the portrait description priority entry is greater than 0
					and the notable-object entry is not mentioned
					and the notable-object entry is not held by the subject
					and the notable-object entry is not part of the subject:
				now the notable-object entry is marked for listing;
				set pronouns from the notable-object entry;
				increase the marked count by 1;
	if the mentionable count is greater than 0:
		[note that mentioned things have not been marked for listing]
		begin the listing miscellaneous items in portrait activity with the subject;
		if the marked count is 0:
			abandon the listing miscellaneous items in portrait activity with the subject;
		otherwise:
			if handling the listing miscellaneous items in portrait activity with the subject:
				let also be a text;
				if the portrait sentence count is greater than zero:
					let also be "also ";
				say "[We] [also][see] [a list of marked for listing things including contents].  [run paragraph on]" (A);
			end the listing miscellaneous items in portrait activity with the subject;
	continue the activity.

[This should ALWAYS be listed last.]
The finish portrait paragraph rule is listed last in the for printing the portrait description rulebook.
For printing the portrait description of something (called subject) (this is the finish portrait paragraph rule):
	say "[paragraph break]";

Chapter - Printing a portrait sentence

Printing a portrait sentence about something is an activity on objects.
[This is the one we implement.]

Writing a portrait sentence about something is an activity on objects.
[This is the activity which should be implemented by authors.]

For printing a portrait sentence about a thing (called the item)
	(this is the don't mention scenery in portrait descriptions rule):
	if the item is scenery:
		set the portrait priority of the item to 0;
	continue the activity.

[This is only used if the story author uses the last-resort "undescribed" property.]
For printing a portrait sentence about a thing (called the item)
	(this is the don't mention undescribed items in portrait descriptions rule):
	if the item is undescribed:
		set the locale priority of the item to 0;
	continue the activity.

For printing a portrait sentence about a thing (called the item)
	(this is the offer items to writing a portrait sentence about rule):
	if the item is not mentioned:
		say "[run paragraph on]";
		carry out the writing a portrait sentence about activity with the item; [SUBROUTINE CALL]
		if a paragraph break is pending: [TODO -- this is an intensely hacky way to handle this and arguably unacceptable]
			increase the portrait sentence count by 1;
			set pronouns from the item;
			now the item is mentioned;
			say "[run paragraph on]";
	continue the activity.

[ FIXME -- this is for people carrying trays -- do later]
[
Definition: a thing (called the item) is portrait-supportable if the item is not
scenery and the item is not mentioned and the item is not undescribed.

For printing a portrait sentence about a thing (called the item)
	(this is the describe what's on scenery supporters in portrait descriptions rule):
	if the item is scenery and the item does not enclose the player:
		if a portrait-supportable thing is on the item:
			set pronouns from the item;
			repeat with possibility running through things on the item:
				now the possibility is marked for listing;
				if the possibility is mentioned:
					now the possibility is not marked for listing;
			increase the portrait sentence count by 1;
			say "On [the item] " (A);
			list the contents of the item, as a sentence, including contents,
				giving brief inventory information, tersely, not listing
				concealed items, prefacing with is/are, listing marked items only;
			say ".[run paragraph on]";
	continue the activity.

For printing a portrait sentence about a thing (called the item)
	(this is the describe what's on mentioned supporters in portrait descriptions rule):
	if the item is mentioned and the item is not undescribed and the item is
		not scenery and the item does not enclose the player:
		if a portrait-supportable thing is on the item:
			set pronouns from the item;
			repeat with possibility running through things on the item:
				now the possibility is marked for listing;
				if the possibility is mentioned:
					now the possibility is not marked for listing;
			say "On [the item] " (A);
			list the contents of the item, as a sentence, including contents,
				giving brief inventory information, tersely, not listing
				concealed items, prefacing with is/are, listing marked items only;
			say ".[run paragraph on]";
	continue the activity.
]

Character Portraits ends here.

Version 6.2.1 of Atmospheric Effects by Mikael Segercrantz begins here.

"A table-based way to add atmospheric effects to rooms, regions, things and scenes."


Part 1 - Generalia

Chapter 1(a) - Kinds of value

Section 1(a)1 - Scenic type

A scenic type is a kind of value.
The scenic types are full random, fully random, random and ordered.

Section 1(a)2 - Running type

A running type is a kind of value.
The running types are run once, once, run forever and forever.

Section 1(a)3 - Further type

A further type is a kind of value.
The further types are default and stopping.

Section 1(a)4 - Ignoring type

An ignoring type is a kind of value.
The ignoring types are ignore and do not ignore.

Section 1(a)5 - Shown type

A shown type is a kind of value.
The shown types are already shown and unshown.


Chapter 1(b) - Modifications

Section 1(b)1 - Room

A room has a table-name called scenic table.
The scenic table of a room is usually the Table of Default Atmospherics.

A room has an ignoring type called ignoring.
The ignoring of a room is usually do not ignore.

Section 1(b)2 - Region

A region has a table-name called scenic table.
The scenic table of a region is usually the Table of Default Atmospherics.

A region has an ignoring type called ignoring.
The ignoring of a region is usually do not ignore.

A region has a shown type called isshown.
The isshown of a region is usually unshown.

Section 1(b)3 - Things

A thing has a table-name called scenic table.
The scenic table of a thing is usually the Table of Default Atmospherics.

A thing has an ignoring type called ignoring.
The ignoring of a thing is usually do not ignore.


Chapter 1(c) - Global tables

Section 1(c)1 - Table of Default Atmospherics

Table of Default Atmospherics
during (a scene)		initch (a number)		latch (a number)		aftcnt (a number)		curcnt (a number)		sctype (a scenic type)		runtype (a running type)		frtype (a further type)		igtype (an ignoring type)		subtable (a table name)
--

Section 1(c)2 - Table of Atmospheric Definition

Table of Atmospheric Definition
loci (an object)		ignoring (an ignoring type)			subtable (a table name)
--

Section 1(c)3 - Table of Default Messages

Table of Default Messages
used (a number)		message (text)
--

Section 1(c)4 - Table of Messages to Show

Table of Messages to Show
message (text)
with 20 blank rows


Chapter 1(d) - Other globals

Section 1(d)1 - The empty region

The empty region is a region.


Part 2 - Initialization

Chapter 2(a) - Corrections

Section 2(a)1 - Correct synonyms

To correct synonyms:
	repeat with r running through rooms:
		correct synonyms of r;
	repeat with r running through regions:
		correct synonyms of r;
	repeat with r running through things:
		correct synonyms of r.

Section 2(a)2 - Correct synonyms of

To correct synonyms of (r - an object):
	if r is a room or r is a region or r is a thing:
		repeat through the scenic table of r:
			if the scenic table of r is the Table of Default Atmospherics:
				now the runtype entry is run forever;
			if the subtable entry is the Table of Default Messages, now the runtype entry is run forever;
			if the sctype entry is full random, now the sctype entry is fully random;
			if the runtype entry is once, now the runtype entry is run once;
			if the runtype entry is forever, now the runtype entry is run forever.
	

Chapter 2(b) - Initialization

Section 2(b)1 - Initializing from Table of Atmospheric Definition

To initialize from table:
	repeat through the Table of Atmospheric Definition:
		if the loci entry is a room or the loci entry is a region or the loci entry is a thing:
			now the scenic table of the loci entry is the subtable entry;
			now the ignoring of the loci entry is the ignoring entry.

Section 2(b)2 - Initializing the locations

To initialize the locations:
	repeat with r running through rooms:
		initialize the location r;
	repeat with r running through regions:
		initialize the location r;
	repeat with r running through things:
		initialize the location r.

Section 2(b)3 - Initialize the location

To initialize the location (r - an object):
	if r is a room or r is a region or r is a thing:
		let tbl be the scenic table of r;
		repeat with n running from 1 to the number of rows in tbl:
			choose row n in tbl;
			if there is a subtable entry:
				if there is an initch entry:
					do nothing;
				otherwise:
					now the initch entry is 100;
				if there is a latch entry:
					do nothing;
				otherwise:
					now the latch entry is the initch entry;
				if there is an aftcnt entry:
					do nothing;
				otherwise:
					now the aftcnt entry is 0;
				if the aftcnt entry is less than 0, now the aftcnt entry is 0;
				now the curcnt entry  is 0;
				if there is an sctype entry:
					do nothing;
				otherwise:
					now the sctype entry  is random;
				if there is a runtype entry:
					do nothing;
				otherwise:
					now the runtype entry  is run forever;
				if there is an frtype entry:
					do nothing;
				otherwise:
					now the frtype entry  is stopping;
				if there is an igtype entry:
					do nothing;
				otherwise:
					now the igtype entry is do not ignore;
				if the subtable entry is the Table of Default Messages:
					now the frtype entry  is stopping;
					now the runtype entry is run forever;
				repeat through the subtable entry:
					now the used entry  is 0.

Section 2(b)4 - When play begins

When play begins:
	initialize from table;
	initialize the locations;
	correct synonyms.


Part 3 - Decisions and counting

Chapter 3(a) - Counting

Section 3(a)1 - Number of used rows

To decide what number is the number of used rows in (tbl - a table-name):
	let count be 0;
	repeat through tbl:
		if there is a used entry:
			if the used entry is greater than 0, increase the count by 1;
	decide on count.

Section 3(a)2 - Number of free rows

To decide what number is the number of free rows in (tbl - a table-name):
	let count be 0;
	repeat through tbl:
		if there is a used entry:
			if the used entry is 0, increase the count by 1;
	decide on count.


Chapter 3(b) - Numerical decisions

Section 3(b)1 - Maximum number

To decide what number is the largest number in (tbl - a table-name):
	let current be 0;
	repeat through tbl:
		if there is a used entry:
			if the used entry is greater than current, now current is the used entry;
	decide on current.


Chapter 3(c) - Decisions

Section 3(c)1 - A scenic is shown

To decide whether a scenic with initch (ic - a number) latch (lc - a number) aftcnt (ac - a number) curcnt (cc - a number) is shown:
	if ac is 0:
		if a random chance of ic in 100 succeeds, decide yes;
		decide no;
	otherwise:
		if cc is less than ac:
			if a random chance of ic in 100 succeeds, decide yes;
			decide no;
		otherwise:
			if a random chance of lc in 100 succeeds, decide yes;
			decide no.


Part 4 - Saying

Chapter 4(a) - General

Section 4(a)1 - Display row

To display row (row number - a number) in (tbl - a table-name) running (runtype - a running type):
	let current row be 0;
	sort tbl in used order;
	repeat with i running from 1 to the number of rows in tbl:
		choose row i in tbl;
		if there is a message entry:
			if current row is less than row number, increase current row by 1;
			if current row is row number and the used entry is 0:
				increase current row by 1;
				let txt be the message entry;
				choose a blank row in the Table of Messages to Show;
				now the message entry  is txt;
				choose row i in tbl;
				now the used entry is the turn count;
				if runtype is run once, blank out the whole row.

Section 4(a)2 - Clean all messages

To clean all messages in (tbl - a table-name):
	repeat through tbl:
		now the used entry is 0.


Chapter 4(b) - Rules for fully random messages

Section 4(b)1 - To say a fully random

To say a fully random scenic message of (tbl - a table-name) running (runtype - a running type):
	let row number be a random number between 1 and the number of filled rows in tbl;
	display row row number in tbl running runtype;
	clean all messages in tbl.


Chapter 4(c) - Rules for random messages

Section 4(c)1 - To say a random

To say a random scenic message of (tbl - a table-name) running (runtype - a running type):
	let current count be the number of free rows in tbl;
	let maximum be the largest number in tbl;
	let original count be current count;
	if current count is 0:
		clean messages of tbl with maximum;
		let current count be the number of filled rows in tbl minus 1;
		if the number of filled rows in tbl is 1:
			clean last message of tbl;
			let current count be the number of filled rows in tbl;
	let row number be a random number between 1 and current count;
	let current row be 0;
	display row row number in tbl running runtype;
	if the original count is 0 and the number of filled rows in tbl is greater than 0 and maximum is greater than 0:
		choose row with used of maximum in tbl;
		now the used entry is 0.

Section 4(c)2 - Clean messages

To clean messages of (tbl - a table-name) with (maximum - a number):
	repeat through tbl:
		if the used entry is less than maximum, now the used entry is 0.

Section 4(c)3 - Clean last message

To clean last message of (tbl - a table-name):
	clean all messages in tbl.


Chapter 4(d) - Rules for ordered messages

Section 4(d)1 - To say an ordered

To say an ordered scenic message of (tbl - a table-name) running (runtype - a running type):
	let current count be the number of free rows in tbl;
	let maximum be the largest number in tbl;
	let original count be current count;
	if current count is 0:
		let current count be 1;
		clean messages of tbl with maximum;
		if the number of filled rows in tbl is 1, clean last message of tbl;
	display row 1 in tbl running runtype;
	if the original count is 0 and the number of filled rows in tbl is greater than 0 and maximum is greater than 0:
		choose row with used of maximum in tbl;
		now the used entry is 0.


Part 5 - Common phrases for rooms, regions and things

Chapter 5(a) - Displaying

Section 5(a)1 - Display messages of

To display messages of (r - an object):
	if r is a room or r is a region or r is a thing:
		let tbl be the scenic table of r;
		let ign be 0;
		repeat with n running from 1 to the number of rows in tbl:
			choose row n in tbl;
			let doshow be 0;
			if there is a during entry:
				if the during entry is happening, now doshow is 1;
			otherwise:
				now doshow is 1;
			if there is a subtable entry:
				do nothing;
			otherwise:
				now doshow is 0;
			if ign is 1, now doshow is 0;
			if doshow is 1:
				if a scenic with initch initch entry latch latch entry aftcnt aftcnt entry curcnt curcnt entry is shown:
					let cc be the curcnt entry;
					increase cc by 1;
					if cc is greater than the number of filled rows in tbl, now cc is the number of filled rows in tbl;
					now the curcnt entry is cc;
					let rtype be the runtype entry;
					let stbl be the subtable entry;
					let scenic be the sctype entry;
					if scenic is fully random, say a fully random scenic message of stbl running rtype;
					if scenic is random, say a random scenic message of the stbl running rtype;
					if scenic is ordered, say an ordered scenic message of stbl running rtype;
					choose row n in tbl;
					if the igtype entry is ignore, now ign is 1;
					if the number of filled rows in the subtable entry is 0 and the frtype entry is default:
						now the subtable entry is the Table of Default Messages;
						now the frtype entry is stopping;
						now the runtype entry is run forever.

Section 5(a)2 - Display all messages

To display all messages:
	let nummessages be the number of filled rows in the Table of Messages to Show;
	sort the Table of Messages to Show in random order;
	repeat through the Table of Messages to Show:
		say "[message entry] ";
		blank out the whole row;
	if nummessages is greater than 0, say "[paragraph break]".


Part 6 - Rooms

Chapter 6(a) - Every turn in rooms

Section 6(a)1 - Check room messages

To check room messages:
	let shw be 1;
	repeat through the Table of Atmospheric Definition:
		if the ignoring entry is ignore:
			if the loci entry is a thing:
				if the player can see the loci entry, now shw is 0;
	if shw is 1, display messages of location.


Part 7 - Regions

Chapter 7(a) - Every turn in regions

Section 7(a)1 - Check region messages

To check region messages:
	let shw be 1;
	repeat through the Table of Atmospheric Definition:
		if the ignoring entry is ignore:
			if the loci entry is a thing:
				if the player can see the loci entry, now shw  is 0;
			otherwise:
				if the loci entry is a room:
					if the loci entry is the location, now shw is 0;
	if shw is 1:
		clean regions;
		let count be the number of located regions;
		repeat with n running from 1 to count:
			let the final region be the smallest unshown region;
			if the final region is not the empty region:
				display messages of the final region;
				now isshown of the final region is already shown;
			otherwise:
				now n is count.

Section 7(a)2 - Clean regions

To clean regions:
	repeat with r running through regions:
		now isshown of r is unshown;
	now isshown of the empty region is already shown.

Section 7(a)3 - The number of located regions

To decide what number is the number of located regions:
	let count be 0;
	repeat with r running through regions:
		if the player is regionally in r and isshown of r is unshown, increase count by 1;
	decide on count.

Section 7(a)4 - The smallest unshown region

To decide which region is the smallest unshown region:
	let final region be the empty region;
	repeat with r running through regions:
		if final region is the empty region:
			if the player is regionally in r:
				if isshown of r is unshown:
					let final region be r;
				repeat through the Table of Atmospheric Definition:
					if the loci entry is r and the ignoring entry is ignore:
						let final region be r;
	repeat with r running through regions:
		if the player is regionally in r:
			if r is in the final region:
				if isshown of r is unshown:
					let final region be r;
				repeat through the Table of Atmospheric Definition:
					if the loci entry is r and the ignoring entry is ignore:
						let final region be r;
	if isshown of the final region is already shown:
		let final region be the empty region;
	decide on the final region.


Part 8 - Things

Chapter 8(a) - Every turn in the presence of

Section 8(a)1 - Check thing messages

To check thing messages:
	repeat with t running through things:
		if the player can see t:
			display messages of t.


Part 9 - Overridables

Chapter 9(a) - Before reading a command

Section 9(a)1 - The scenic messaging rule

A first every turn rule (this is the scenic messaging rule):
	correct synonyms;
	check thing messages;
	check room messages;
	check region messages.

Section 9(a)2 - The scenic displaying rule

A last before reading a command rule (this is the scenic displaying rule):
	display all messages.


Atmospheric Effects ends here.

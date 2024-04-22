Version 7.1.240115 of Large Game Speedup by Nathanael Nerode begins here.

"Performance improvements for games with many objects, or with nested loops over objects, by avoiding looping over all objects."

"based on the extension of the same name by Andrew Plotkin"

Use authorial modesty.

[This broke in 6M62, but it's still very important.  Updated by Nathanael Nerode.]
[It broke again in 10.1.0, and it's still just as important.  Updated again.]
[Broke again with Inform 2023-07-22.  Updated again.]
[Broke again with Inform 2024-01-07.  Updated to use IssueRTP.]

Chapter - Empty

[These adjectives are much faster than "if nothing is in..." or "if the number of things in ... is zero". (Note that the Standard Rules do not define "empty" on containers and supporters; these adjectives are Andrew Plotkin's invention.)]

Definition: a container is empty rather than non-empty if the first thing held by it is nothing.
Definition: a supporter is empty rather than non-empty if the first thing held by it is nothing.

Chapter - Mentioned

Section - Core Fast Functions

[We have to clear these flags for every thing, almost every turn. It's worth having a routine that skips I7's usual SetEitherOrProperty() mechanism and all its safety checks.]

[It's not clear whether this is as necessary in v10 as it was before, but we do it anyway.  In v10, objectloop(obj ofclass K2_thing) IS optimized -- that, I did check.]

To rapidly set all things not mentioned: (- OptimizedAllThingsUnsetMentioned(); -).
To rapidly set all things not marked for listing: (- OptimizedAllThingsUnsetWorkflag(); -).

Include (-
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
! Large Game Speedup: OptimizedAllThingsUnsetMentioned
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
[ OptimizedAllThingsUnsetMentioned obj;
	objectloop(obj ofclass K2_thing) {
		give obj ~mentioned;
	}
];
-)

Include (-
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
! Large Game Speedup: OptimizedAllThingsUnsetWorkflag
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
[ OptimizedAllThingsUnsetWorkflag obj;
	objectloop(obj ofclass K2_thing) {
		give obj ~workflag;
	}
];
-)

This is the optimized declare everything unmentioned each turn rule:
	rapidly set all things not mentioned;

This is the optimized declare everything unmentioned for looking rule:
	rapidly set all things not mentioned;

Section - Replacing the Unmentioning Rules

[ Gets its own section for ease of overriding ]

[ In the new version, things aren't declared unmentioned during startup pre-start.  Relies on initialization. ]

[ Not clear that this one is *desirable*, even though it's in the standard rules: a bit redundant ]
The optimized declare everything unmentioned each turn rule is listed instead of
	the declare everything initially unmentioned rule
	in the turn sequence rulebook.

The optimized declare everything unmentioned for looking rule is listed instead of
	the declare everything unmentioned rule
	in the carry out looking rulebook.

Chapter - Table of Locale Priorities

Section - Table Sort Partial

Include (-
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
! Large Game Speedup: TableSortPartial
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
! Sort the first N rows of a table, rather than the whole thing. The rest
! of the table is untouched. Blank rows are sorted down to position N (not
! to the very end).
[ TableSortPartial tab rows col dir test_flag algorithm i j k f;
	for (i=1:i<=tab-->0:i++) {
		j = tab-->i; ! Address of column table
		if ((j-->1) & TB_COLUMN_DONTSORTME) {
			IssueRTP("SortedTableWithFixedOrdering",
				"Tried to sort a table whose ordering must remain fixed.", BasicInformKitRTPs);
			print "*** Tried to sort a table whose ordering must remain fixed: table '",
				(PrintTableName) tab, "'.^";
			return;
		}
	}
	if (col >= 100) col=TableFindCol(tab, col, false);
	k = rows; ! Not the entire table
	k = TableMoveBlanksToBack(tab, 1, k);
	if (test_flag) {
		print "After moving blanks to back:^"; TableColumnDebug(tab, col);
	}

	SetSortDomain(TableSwapRows, TableCompareRows);
	SortArray(tab, col, dir, k, test_flag, algorithm);

	if (test_flag) {
		print "Final state:^"; TableColumnDebug(tab, col);
	}
];
-)

To sort (T - table name) up to row (N - number) in (TC - table column) order
        (documented at ph_sortcolumn):
        (- TableSortPartial({T}, {N}, {TC}, 1); -).

Section - Set locale priority by building partial table (for use without Room Description Control by Emily Short)

[Room Description Control never hits any of this code so don't bother fixing it.]

[We never want to search (or sort) through the entire Table of Locale Priorities, so we manually keep track of the number of "live" rows. We'll also avoid use of the I7 notion of blank rows. Unused rows will be marked by "nothing" in the object column.]
The locale-table-count is a number that varies.

[This replacement phrase is heavily optimized. It behaves the same as the standard version, except that deleted rows get "nothing" in the object column instead of being marked blank.]
To set the/-- locale priority of (O - an object) to (N - a number):
	[say "[bracket][O] - [N][close bracket]";]
	if O is a thing:
		if N <= 0, now O is mentioned;
		[search the active part of the table for O; also note the first null row]
		let blanknum be 0;
		repeat with I running from 1 to locale-table-count:
			choose row I in the Table of Locale Priorities;
			let ent be the notable-object in row I of  the Table of Locale Priorities;
			if the notable-object entry is nothing:
				if blanknum is 0:
					now blanknum is I;
				next;
			if the notable-object entry is O: [ found it ]
				if N > 0: [change the existing row]
					now the locale description priority entry is N;
				else: [delete the existing row, by putting in "nothing"]
					now the notable-object entry is nothing;
					now the locale description priority entry is 32767; [Max size for Z-machine and probably large enough]
				stop; 
		if N > 0: [didn't find it, but it should be mentioned]
			if blanknum is 0: [add a new row]
				increment locale-table-count;
				choose row locale-table-count in the Table of Locale Priorities;
			else: [use the found null row]
				choose row blanknum in the Table of Locale Priorities;
			now the notable-object entry is O;
			now the locale description priority entry is N;

The optimized initialise locale description rule is listed instead of the initialise locale description rule in the before printing the locale description rulebook.
Before printing the locale description
	(this is the optimized initialise locale description rule):
	now the locale paragraph count is 0;
	now the locale-table-count is zero.   [Mark the table as empty without blanking every single row]

The optimized interesting locale paragraphs rule is listed instead of the interesting locale paragraphs rule in the for printing the locale description rulebook.
For printing the locale description
	(this is the optimized interesting locale paragraphs rule):
	sort the Table of Locale Priorities up to row locale-table-count in locale description priority order;
	repeat with I running from 1 to locale-table-count:
		choose row I in the Table of Locale Priorities;
		if the notable-object entry is not nothing:
			carry out the printing a locale paragraph about activity with the notable-object entry;
	continue the activity.

The optimized you-can-also-see rule is listed instead of the you-can-also-see rule in the for printing the locale description rulebook.
For printing the locale description
	(this is the optimized you-can-also-see rule):
	let the domain be the parameter-object; [Sadly "of something (called domain)" breaks the rule.  No idea why.]
	let the mentionable count be 0;
	let the marked count be 0;
	rapidly set all things not marked for listing;  [loops through all things]
	repeat with I running from 1 to locale-table-count:
		choose row I in the Table of Locale Priorities;
		[ say "[the notable-object entry] - [the locale description priority entry]."; ]
		if the notable-object entry is not nothing:
			increase the mentionable count by 1;
			if the locale description priority entry is greater than 0 and the notable-object entry is not mentioned:
				now the notable-object entry is marked for listing;
				increase the marked count by 1;
	if the mentionable count is greater than 0:
		[note that mentioned things have not been marked for listing]
		begin the listing nondescript items activity with the domain;
		if the marked count is 0:
			abandon the listing nondescript items activity with the domain;
		otherwise:
			if handling the listing nondescript items activity with the domain:
				let the common holder be nothing;
				let contents form of list be true;
				[ Determine whether we can use the optimized contents form first ]
				repeat with I running from 1 to locale-table-count:
					let list item be the notable-object in row I of the Table of Locale Priorities;
					if list item is nothing or list item is not marked for listing:
						next;
					if the holder of the list item is not the common holder:
						if the common holder is nothing:
							now the common holder is the holder of the list item;
						otherwise:
							now contents form of list is false;
					if the list item is mentioned:
						[Should never reach this, but doesn't hurt]
						now the list item is not marked for listing;
				if the domain is the location:
					say "[We] " (A);
				otherwise if the domain is a supporter or the domain is an animal:
					say "On [the domain] [we] " (B);
				otherwise:
					say "In [the domain] [we] " (C);
				if the locale paragraph count is greater than 0:
					say "[regarding the player][can] also see " (D);
				otherwise:
					say "[regarding the player][can] see " (E);
				filter list recursion to unmentioned things;
				if contents form of list is true and the common holder is not nothing:
					list the contents of the common holder, as a sentence, including contents,
						giving brief inventory information, tersely, not listing
						concealed items, listing marked items only;
				otherwise:
					say "[a list of marked for listing things including contents]" (F); [loops through all things]
				unfilter list recursion;
				if the domain is the location:
					say " [here]" (G);
				say ".[paragraph break]" (H);
			end the listing nondescript items activity with the domain;
	continue the activity.

Chapter - Improved WriteListFrom

[This replacement is more efficient in the common cases of ObjectTreeIterator and MarkedListIterator.]

Include (-
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
! Large Game Speedup: ListFilterContents
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
! Set/clear the list_filter_permits attribute, by using list_filter_routine.
! Do this recursively on the object and its contents (if any).
[ ListFilterContents a o;
	if ((list_filter_routine) && (list_filter_routine(a) == false))
		give a ~list_filter_permits;
	else
		give a list_filter_permits;
		
	objectloop (o in a) {
		ListFilterContents(o);
	}
];
-)

Include (-
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
! Large Game Speedup: replacement for WriteListFrom in ListWriter.i6t
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
[ WriteListFrom first in_style depth noactivity iter i a ol;
	@push c_iterator; @push c_style; @push c_depth; @push c_margin;
	if (iter) c_iterator = iter; else c_iterator = ObjectTreeIterator;
	c_style = in_style; c_depth = depth;
	c_margin = 0; if (in_style & EXTRAINDENT_BIT) c_margin = 1;

	! Set or clear the list_filter_permits flag. Try to do it efficiently.
	if (c_iterator == ObjectTreeIterator) {
		! For the tree iterator, we follow the tree.
		for (a = first : a : a = sibling(a)) {
			ListFilterContents(a);
		}
	}
	else if (c_iterator == MarkedListIterator) {
		! For the list iterator, we follow the list.
		for (i=0: i<MarkedObjectLength: i++) {
			a = MarkedObjectArray-->i;
			ListFilterContents(a);
		}
	}
	else {
		! The sad inefficient old way -- loops through all objects.
		! (We don't bother with recursion because we're hitting all objects
		! anyway.)
		objectloop (a ofclass Object) {
			if ((list_filter_routine) && (list_filter_routine(a) == false))
				give a ~list_filter_permits;
			else
				give a list_filter_permits;
		}
	}

	first = c_iterator(first, depth, 0, START_ITF);
	if (first == nothing) {
		if (in_style & ISARE_BIT ~= 0) LW_Response('W'); else LW_Response('Y');
		if (in_style & NEWLINE_BIT ~= 0) new_line;
	} else {
		if ((noactivity) || (iter)) {
			WriteListR(first, c_depth, true);
			say__p = 1;
		} else {
			#ifndef STATIC_OBJECT_GROUPING;
			! loops through all objects
			objectloop (ol provides list_together) 
				BlkValueCopy(ol.list_together, EMPTY_TEXT_VALUE);
			#endif; ! STATIC_OBJECT_GROUPING
			CarryOutActivity(LISTING_CONTENTS_ACT, parent(first));
		}
	}

	@pull c_margin; @pull c_depth; @pull c_style; @pull c_iterator;
];
-) replacing "WriteListFrom".

Chapter - Faster Listing Phrases

[Add a set of "say the list of..." phrases that are more efficient for the common case of a container/supporter.]

Include (-
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
! Large Game Speedup: WriteListOfMarkedContentsObjects
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
[ WriteListOfMarkedContentsObjects in_style common_parent
	obj first length;

	objectloop (obj in common_parent && obj has workflag2) {
		length++;
		if (first == nothing) { first = obj; }
	}

	if (length == 0) {
		if (in_style & ISARE_BIT ~= 0) LW_Response('W');
		else if (in_style & CFIRSTART_BIT ~= 0) LW_Response('X');
		else LW_Response('Y');
	} else {
		@push MarkedObjectArray; @push MarkedObjectLength;
		MarkedObjectArray = RequisitionStack(length);
		MarkedObjectLength = length;
		if (MarkedObjectArray == 0) {
			return IssueRTP("ListWriterRanOutOfMemory", "The list-writer has run out of memory.^", BasicInformKitRTPs); 
		}

		! common_parent is always set
		ObjectTreeCoalesce(child(common_parent));
		length = 0;
		objectloop (obj in common_parent) ! object tree order
			if (obj has workflag2) MarkedObjectArray-->length++ = obj;

		WriteListFrom(first, in_style, 0, false, MarkedListIterator);

		FreeStack(MarkedObjectArray);
		@pull MarkedObjectLength; @pull MarkedObjectArray;
	}
	prior_named_list = length;
	return;
];
-)

To say a list of (OS - description of objects) *in (parent - object):
	(-
		objectloop ({-my:1} in {parent}) if ({-matches-description:1:OS})
		give {-my:1} workflag2; else give {-my:1} ~workflag2;
		WriteListOfMarkedContentsObjects(ENGLISH_BIT, {parent});
	 -).
To say A list of (OS - description of objects) *in (parent - object):
	(-
		objectloop ({-my:1} in {parent}) if ({-matches-description:1:OS})
		give {-my:1} workflag2; else give {-my:1} ~workflag2;
		WriteListOfMarkedContentsObjects(ENGLISH_BIT+CFIRSTART_BIT, {parent});
		 -).
To say list of (OS - description of objects) *in (parent - object):
	(-
		objectloop ({-my:1} in {parent}) if ({-matches-description:1:OS})
		give {-my:1} workflag2; else give {-my:1} ~workflag2;
		WriteListOfMarkedContentsObjects(ENGLISH_BIT+NOARTICLE_BIT, {parent});
		 -).
To say the list of (OS - description of objects) *in (parent - object):
	(-
		objectloop ({-my:1} in {parent}) if ({-matches-description:1:OS})
		give {-my:1} workflag2; else give {-my:1} ~workflag2;
		WriteListOfMarkedContentsObjects(ENGLISH_BIT+DEFART_BIT, {parent});
		 -).
To say The list of (OS - description of objects) *in (parent - object):
	(-
		objectloop ({-my:1} in {parent}) if ({-matches-description:1:OS})
		give {-my:1} workflag2; else give {-my:1} ~workflag2;
		WriteListOfMarkedContentsObjects(ENGLISH_BIT+DEFART_BIT+CFIRSTART_BIT, {parent});
		 -).
To say is-are a list of (OS - description of objects) *in (parent - object):
	(-
		objectloop ({-my:1} in {parent}) if ({-matches-description:1:OS})
		give {-my:1} workflag2; else give {-my:1} ~workflag2;
		WriteListOfMarkedContentsObjects(ENGLISH_BIT+ISARE_BIT, {parent});
		 -).
To say is-are list of (OS - description of objects) *in (parent - object):
	(-
		objectloop ({-my:1} in {parent}) if ({-matches-description:1:OS})
		give {-my:1} workflag2; else give {-my:1} ~workflag2;
		WriteListOfMarkedContentsObjects(ENGLISH_BIT+ISARE_BIT+NOARTICLE_BIT, {parent});
		 -).
To say is-are the list of (OS - description of objects) *in (parent - object):
	(-
		objectloop ({-my:1} in {parent}) if ({-matches-description:1:OS})
		give {-my:1} workflag2; else give {-my:1} ~workflag2;
		WriteListOfMarkedContentsObjects(ENGLISH_BIT+DEFART_BIT+ISARE_BIT, {parent});
		 -).

Chapter - Part Of

to decide which thing is the/-- first component of (obj - an object):
	(- ({obj}.component_child) -);

to decide which thing is the/-- next component after (obj - an object):
	(- ({obj}.component_sibling) -);

to decide which list of objects is the/-- list of components of (obj - an object):
	let L be a list of objects;
	let item be the first component of obj;
	while item is not nothing:
		add item to L;
		let item be the next component after item;
	decide on L;

[
Chapter - Static Object Grouping

[This is *untested* in 6M62 and 10.1.0 and 10.2.]

Use static object grouping translates as the configuration flag STATIC_OBJECT_GROUPING.

The initially listing contents rules are a rulebook.

When play begins (this is the initially list contents rule):
	if the static object grouping option is active:
		follow the initially listing contents rules.

To initially group (OS - description of objects) together: (- InitiallyGroupTogether({OS}, {-list-together:unarticled}); -).
To initially group (OS - description of objects) together giving articles: (- InitiallyGroupTogether({OS}, {-list-together:articled}); -).
To initially group (OS - description of objects) together as (T - text): (- InitiallyGroupTogether({OS}, {-by-reference:T}); -).

Include (-
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
! Large Game Speedup: InitiallyGroupTogether
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
! We've commented out the code in WriteListFrom that clears the list_together flag.
! It is set to the empty text for all objects at the beginning of the game, however, because of the way default values work.
! We set all the real list_together connections here at the beginning of the game.
[ InitiallyGroupTogether desc func  obj;
	obj = nothing;
	while (obj = desc(-2, obj)) {
		obj.list_together = func;
	}
];
-).
]

Large Game Speedup ends here.

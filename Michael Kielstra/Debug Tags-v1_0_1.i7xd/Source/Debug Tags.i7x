Version 1.0.1 of Debug Tags by Michael Kielstra begins here.

"Take quick notes about what needs doing: bugs, ideas, et cetera.  Helpful for debugging."

Use authorial modesty.

Book 0 - Basic setup
[Define debug tags and serious debug tags here, so that any that stay in the game by accident don't mess things up too badly.]

A debug tag is a kind of thing.  A debug tag is usually scenery.  A debug tag has a text called the type.  A debug tag has a number called the priority. A debug tag has a text called the assignee.

A serious debug tag is a kind of debug tag.

Book 1 - Rules and commands - Not for release

The type of a debug tag is usually "TODO".  The priority of a debug tag is usually 100.  Understand "debug tag" as a debug tag. 

The type of a serious debug tag is usually "STOPSHIP".  The priority of a serious debug tag is usually 10.

The urgency threshold is a number that varies.  The urgent tags message is a text that varies.

To display (the tag - a debug tag):
	say "[the type of the tag]: [the tag][if the location of the tag is not nowhere] (in [the location of the tag])[end if][if the assignee of the tag is not empty].  Assigned to [the assignee of the tag][end if]."

Carry out examining a debug tag (called the tag):
	display the tag instead.

Listing tags is an action applying to nothing.  Understand "tags" as listing tags.

Carry out listing tags:
	If the urgency threshold is 0:
		now the urgency threshold is 99;
	Let T be the list of debug tags;
	If T is not empty:
		sort T in priority order;
		if the priority of entry 1 of T is less than the urgency threshold:
			if the urgent tags message is empty:
				now the urgent tags message is "DO NOT RELEASE: SERIOUSLY INCOMPLETE";
			say "[the urgent tags message][paragraph break]";
		repeat with the tag running through T:
			display the tag;
	Otherwise:
		say "[paragraph break]".

When play begins:
	try listing tags.
		
Book 2 - Defining tags
[Once again, this goes out to release as well.]

TODO, XXX, HACK, NOTE, QUESTION, ALERT, CAVEAT, IDEA are kinds of debug tags.

STOPSHIP, FIXME, BUG are kinds of serious debug tags.

Book 3 - Destroying tags - Only for release
[Delete all tags in rooms at the beginning of released games.]

When play begins:
	repeat with the current tag running through debug tags:
		now the current tag is nowhere.

Debug Tags ends here.

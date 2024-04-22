Version 14.1.220525 of Room Description Control by Emily Short begins here.

"A framework by which the author can considerably change the listing of objects in a room description. Includes facilities for concealing objects arbitrarily and changing the order in which objects are listed."

[Need this for debugging code left in]
Paragraph-debug-state is a number that varies. Paragraph-debug-state is 0.

Section 0 - Data Structure

[This is in its own section so authors can replace it with more or fewer rows.]

Table of Seen Things
output subject	current rank
an object	a number
with 60 blank rows.

Section 1 - Priority and Concealment Rules

The new object description rule is listed instead of the room description paragraphs about objects rule in the carry out looking rules.

When play begins (this is the mark everything unmentioned when play begins rule):
	now every thing is unmentioned.
	
Before reading a command (this is the mark everything unmentioned rule):
	now every thing is unmentioned.

This is the new object description rule:
	follow the description-priority rules.
	
The description-priority rules are a rulebook.

A description-priority rule (this is the marking rule):
	now every thing is not marked for listing;
	call the swift rule on everything in scope.

[ New implementation: one loop ]
A description-priority rule (this is the mentioning tedious things rule):
	repeat with item running through every thing:
		if item is undescribed:
			now item is not marked for listing; [ Usually the player ]
		if item is enclosed by the player:
			now item is not marked for listing;
		if item is scenery:
			now item is not marked for listing;

[ Old implementation: three loops over all objects ]
[
	now the player is not marked for listing;
	now every thing enclosed by the player is not marked for listing;
	now every scenery thing is not marked for listing;
]

A description-priority rule (this is the determining concealment rule): 
	follow the description-concealing rules.
	
The description-concealing rules are a rulebook. 

A description-concealing rule (this is the concealing parts rule): 
	now everything that is part of something is not marked for listing.

A description-concealing rule (this is the ordinary-concealment rule):
	repeat with special-target running through marked for listing people:
		repeat with second special-target running through things carried by special-target:
			if special-target conceals second special-target:
				now second special-target is not marked for listing.

A description-concealing rule (this is the don't mention things out of play rule):
	repeat with special-target running through marked for listing things:
		if the holder of the special-target is nothing, now the special-target is not marked for listing.

A description-priority rule (this is the loading table rule):
	blank out the whole of the Table of Seen Things;
	repeat with item running through mentionable things:
		choose a blank row in the Table of Seen Things;
		now output subject entry is item.

lowest-rank is a number that varies.

A description-priority rule (this is the description-ranking rule): 
	now lowest-rank is 1000;
	repeat through the Table of Seen Things
	begin;  
		now the description-rank of the output subject entry is 0;
		follow the ranking rules for the output subject entry;
		now the current rank entry is the description-rank of the output subject entry;
		if description-rank of the output subject entry is less than lowest-rank, now lowest-rank is description-rank of the output subject entry;
	end repeat;
	sort the Table of Seen Things in reverse current rank order; 

A description-priority rule (this is the reporting descriptions rule):
	repeat through the Table of Seen Things:
		if the output subject entry is unmentioned:
			if paragraph-debug-state is at least 2:
				say "[bracket]reporting for: [output subject entry][close bracket]"; [debugging code]
				now the output subject entry is unmentioned; [reset side effects of debugging code]
			carry out the writing a paragraph about activity with the output subject entry;
	
[A description-priority rule (this is the final description rule):
	say paragraph break.]

After printing the name of something (called special-target) while writing a paragraph about something (this is the don't write a paragraph about something twice rule):
	now the special-target is not marked for listing;
	now the special-target is mentioned.
	
A thing has a number called description-rank.

Ranking rules are an object-based rulebook.

Definition: a thing is mentionable if it is marked for listing and it is unmentioned.
Definition: a thing is unmentionable if it is not mentionable.

Definition: a thing is descriptively dull if the description-rank of it is lowest-rank.

[This portion makes sure that items that are listed together in groups get properly flagged 'mentioned':]

After printing the plural name of something (called target) (this is the write only one paragraph about a group of identical objects rule):
	repeat with item running through things held by the holder of target
	begin; 
		if the item nominally matches the target
		begin;
			now the item is mentioned;
		end if;
	end repeat;

To decide whether (X - a thing) nominally matches (Y - a thing):
	(- ({X}.list_together == {Y}.list_together) -)

[Used to be: "To call (RL - an objects based rule) on everything in scope:",  but 6M62 will only have it this way]
To call (RL - a rule) on everything in scope:
(-
   processing_rule = {RL};
   LoopOverScope(Process_single_item);
-)

The scope processing rules are an object-based rulebook.

Include (-
  Global processing_rule = 0;

  [ Process_single_item o;
     FollowRulebook(processing_rule, o, true);
  ];
-) after "Definitions.i6t".

A scope processing rule for a thing (called n) (this is the swift rule): now n is marked for listing. 

Section 2 - Entering and Leaving

The new describe contents rule is listed instead of the describe contents entered into rule in the report entering rulebook.

This is the new describe contents rule:
	if the person asked is the player, follow the description-priority rules.

A description-concealing rule while entering a container (called special-target) (this is the don't describe things outside the player's container rule):
	repeat with item running through marked for listing things:
		if item is not enclosed by special-target, now the item is not marked for listing.

Section 3 - Debugging - Not for release

para-debugging is an action out of world applying to one number.
para-debug-off is an action out of world.
para-debug-on is an action out of world.
Understand "paragraphs [number]" as para-debugging.

Understand "paragraphs off" as para-debug-off.
Carry out para-debug-off (this is the paragraph debugging off redirect rule):
	try para-debugging 0 instead;

Understand "paragraphs" or "paragraphs on" as para-debug-on.
Carry out para-debug-on (this is the paragraph debugging on redirect rule):
	try para-debugging 1 instead;

Carry out para-debugging a number (called n) (this is the default carry out paragraph debugging rule):
	if n < 0, now n is 0;
	if n > 2, now n is 2;
	now paragraph-debug-state is n.

Report para-debugging (this is the default report paragraph debugging rule):
	say "Paragraph debugging is now [if paragraph-debug-state is 2]level 2[else if paragraph-debug-state is 1]on[otherwise]off[end if]." (A)

The table-debugging rule is listed after the description-ranking rule in the description-priority rules.
The table-debugging rule is listed before the reporting descriptions rule in the description-priority rules. [After isn't good enough; it comes too late.]

This is the table-debugging rule:
	if paragraph-debug-state is at least 1:
		repeat through the Table of Seen things:
			if the output subject entry is unmentioned:
				say "[output subject entry]: rank [current rank entry][line break]";
				now output subject entry is unmentioned;
			otherwise:
				say "[output subject entry]: rank [current rank entry] (already mentioned)[line break]";
		say "[line break]";

Room Description Control ends here.

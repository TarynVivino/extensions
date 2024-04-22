Version 5.1.2 of Trinity Inventory by Mikael Segercrantz begins here.

"Provides a framework for listing inventories in natural sentences, akin to Infocom's game Trinity. Separates carried and worn objects, followed by objects that contains other objects. What's listed in the third section is customizable via a rulebook. Objects can be marked as not listed when carried or worn as well as marked as having their contents listed in the inventory when they're empty. This extension is based upon the extension Written Inventory by Jon Ingold."

[Updated for Inform 6L02 by Matt Weiner as of July 1, 2014. There should be no changes in performance, but you may wish to triple-check the behavior of the adaptive text.]

Chapter 1 - Modifications

Section 1a - Modifying the thing kind

A thing can be listed when worn or unlisted when worn. A thing is usually listed when worn.
A thing can be listed when carried or unlisted when carried. A thing is usually listed when carried.
A thing can be empty-listed or not empty-listed. A thing is usually not empty-listed.
A thing has a text called inventory listing. The inventory listing of a thing is usually "".


Section 1b - Removing standard rules from the carry out taking inventory rulebook

The print empty inventory rule is not listed in the carry out taking inventory rules. The print standard inventory rule is not listed in the carry out taking inventory rules.


Chapter 2 - Definitions and phrases

Section 2a - Encasement relation

Encasement relates a thing (called X) to a thing (called Y) when X is part of Y or X is held by Y or the holder of Y is X. The verb to be encased by implies the encasement relation.


Section 2b - Empty and non-empty definitions

Definition: a container is empty if the number of things in it is zero.
Definition: a player's holdall is empty if the number of things in it is zero.
Definition: a supporter is empty if the number of things on it is zero.
Definition: a thing is empty if the number of things encased by it is zero.

Definition: a thing is non-empty if it is not empty.


Section 2c - Specially-inventoried

Definition: a thing is specially-inventoried if the inventory listing of it is not "".
Definition: a thing is normally-inventoried if it is not specially-inventoried.


Chapter 3 - Visibility

Section 3a - Contents of a container are visible

To decide whether the contents of (item - a container) are visible:
	if the item is transparent:
		decide yes;
	otherwise:
		if the item is open, decide yes;
		otherwise decide no.


Section 3b- Contents of a player's holdall are visible

To decide whether the contents of (item - a player's holdall) are visible:
	if the item is transparent:
		decide yes;
	otherwise:
		if the item is open, decide yes;
		otherwise decide no.


Section 3c - Contents of a supporter are visible

To decide whether the contents of (item - a supporter) are visible:
	decide yes.


Section 3d - Contents of a thing are visible

To decide whether the contents of (item - a thing) are visible:
	decide yes.
		

Chapter 4 - Activities

Section 4a - The inventory listing the contents activity

Inventory listing the contents of something is an activity.


Section 4b - Marker for having used ", and"

TI first option anded is a number which varies. TI first option anded is 0.


Section 4c - Container inventory contents rule

Rule for inventory listing the contents of a container (called the item) (this is the container inventory contents rule):
	if TI first option anded is greater than 1:
		if a random chance of TI first option anded in 10 succeeds, now TI first option anded is 0;
	if TI first option anded is greater than 0, now TI first option anded is TI first option anded plus 1;
	if the number of listed when carried things encased by the item is at least one:
		if TI first option anded is 0:
			say ", and [we] [have]" (A);
			now TI first option anded is 1;
		otherwise:
			say ". [We] also [have]" (B);
		now content-listing is true;
		say " [list of listed when carried things in the item] in " (C);
		now content-listing is false;
		now articulating is true;
		if the item is specially-inventoried, say "[item]" (D);
		otherwise say "[the item]" (E);
		now articulating is false;
	otherwise:
		if TI first option anded is 0:
			now articulating is true;
			say ", and [if item is specially-inventoried][item][otherwise][the item][end if]" (F);
			now articulating is false;
			now TI first option anded is 1;
		otherwise:
			now articulating is true;
			if the item is specially-inventoried, say ". [Item]" (G);
			otherwise say ". [The item]" (H);
			now articulating is false;
		say " [regarding the item][are] empty" (I).


Section 4d - Player's holdall inventory contents rule

Rule for inventory listing the contents of a player's holdall (called the item) (this is the holdall inventory contents rule):
	if TI first option anded is greater than 1:
		if a random chance of TI first option anded in 10 succeeds, now TI first option anded is 0;
	if TI first option anded is greater than 0, now TI first option anded is TI first option anded plus 1;
	if the number of listed when carried things encased by the item is at least one:
		if TI first option anded is 0:
			say ", and [we] [have]" (A);
			now TI first option anded is 1;
		otherwise:
			say ". [We] also [have]" (B);
		now content-listing is true;
		say " [list of listed when carried things in the item] in " (C);
		now content-listing is false;
		now articulating is true;
		if the item is specially-inventoried, say "[item]" (D);
		otherwise say "[the item]" (E);
		now articulating is false;
	otherwise:
		if TI first option anded is 0:
			now articulating is true;
			say ", and [if item is specially-inventoried][item][otherwise][the item][end if]" (F);
			now articulating is false;
			now TI first option anded is 1;
		otherwise:
			now articulating is true;
			if the item is specially-inventoried, say ". [Item]" (G);
			otherwise say ". [The item]" (H);
			now articulating is false;
		say " [regarding the item][are] empty" (I).


Section 4e - Supporter inventory contents rule

Rule for inventory listing the contents of a supporter (called the item) (this is the supporter inventory contents rule):
	if TI first option anded is greater than 1:
		if a random chance of TI first option anded in 10 succeeds, now TI first option anded is 0;
	if TI first option anded is greater than 0, now TI first option anded is TI first option anded plus 1;
	if the number of listed when carried things encased by the item is at least one:
		if TI first option anded is 0:
			say ", and [we] [have]" (A);
			now TI first option anded is 1;
		otherwise:
			say ". [We] also [have]" (B);
		now content-listing is true;
		say " [list of listed when carried things on the item] on " (C);
		now content-listing is false;
		now articulating is true;
		if the item is specially-inventoried, say "[item]" (D);
		otherwise say "[the item]" (E);
		now articulating is false;
	otherwise:
		if TI first option anded is 0:
			now articulating is true;
			say ", and [if item is specially-inventoried][item][otherwise][the item][end if]" (F);
			now articulating is false;
			now TI first option anded is 1;
		otherwise:
			now articulating is true;
			if the item is specially-inventoried, say ". [Item]" (G);
			otherwise say ". [The item]" (H);
			now articulating is false;
		say " [regarding the item][have] nothing on [them]" (I).


Section 4f - Thing inventory contents rule

Rule for inventory listing the contents of a thing (called the item) (this is the thing inventory contents rule):
	do nothing.


Chapter 5 - Our own carry out taking inventory rules

Section 5a - Inventory intro rule

First carry out taking inventory (this is the inventory intro rule):
	say "[We]['re] [run paragraph on]" (A).


Section 5b - Empty inventory rule

Carry out taking inventory when the number of listed when carried things carried by the player is zero (this is the empty inventory rule):
	say "not holding anything[run paragraph on]" (A).


Section 5c - Non-empty inventory rule

Carry out taking inventory when the number of listed when carried things carried by the player is at least one (this is the non-empty inventory rule):
	say "holding [list of listed when carried things carried by the player][run paragraph on]" (A).


Section 5d - Empty wearing rule

Carry out taking inventory when the number of listed when worn things worn by the player is zero (this is the empty wearing rule):
	say "[run paragraph on]" (A).


Section 5e - Non-empty wearing rule

Carry out taking inventory when the number of listed when worn things worn by the player is at least one (this is the non-empty wearing rule):
	if the number of listed when carried things carried by the player is zero, say ", but [we]['re]" (A);
	if the number of listed when carried things carried by the player is at least one, say ". [We]['re]" (B);
	say " wearing [list of listed when worn things worn by the player][run paragraph on]" (C).


Section 5f - Set-up second-level inventory list rule

Carry out taking inventory (this is the set-up second-level inventory list rule):
	now everything is unmentioned;
	now the player is mentioned;
	now everything unlisted when carried is mentioned;
	now TI first option anded is 0;
	now articulating is false;
	now content-listing is false;
	if the number of listed when carried things carried by the player is at least one, now TI first option anded is 1;
	if the number of listed when carried things carried by the player is zero and the number of listed when worn things worn by the player is at least one, now TI first option anded is 1;
	if the number of listed when worn things worn by the player is zero, now TI first option anded is 0;
	if the number of listed when carried things carried by the player is at least one and the number of listed when worn things worn by the player is one, now TI first option anded is 0.


Section 5g - Deliver second-level inventory list rule

Carry out taking inventory (this is the deliver second-level inventory list rule):
	let item be a random unmentioned non-empty thing encased by something mentioned;
	if item is nothing, let item be a random unmentioned empty empty-listed thing encased by something mentioned;
	while item is a thing:
		if the contents of item are visible:
			if the number of listed when carried things encased by the item is at least one, carry out the inventory listing the contents activity with the item;
			if the number of listed when carried things encased by the item is zero and the item is empty-listed, carry out the inventory listing the contents activity with the item;
		now the item is mentioned;
		let item be a random unmentioned non-empty thing encased by something mentioned;
		if item is nothing, let item be a random unmentioned empty empty-listed thing encased by something mentioned;
	say ". [run paragraph on]" (A);

Section 5h - Inventory outro rule

Last carry out taking inventory (this is the inventory outro rule):
	say "[paragraph break]" (A).


Chapter 6 - Item-specific rules

Section 6a - Truth states

Articulating is a truth state that varies. Articulating is false.
Content-listing is a truth state that varies. Content-listing is false.


Section 6b - A specially-inventoried thing

Rule for printing the name of a specially-inventoried thing (called the target) while taking inventory (this is the inventory special rule):
	say "[inventory listing of target]" (A);
	if content-listing is true, now target is unmentioned.


Section 6c - Other things

Rule for printing the name of a normally-inventoried thing (called the target) while taking inventory and articulating is false (this is the inventory normal rule):
	say "[target with article]" (A);
	if content-listing is true, now target is unmentioned.


Chapter 7 - Articles

Section 7a - Article for target

To say (target - a thing) with article:
	now articulating is true;
	if the target is proper-named, say "[definite article for target]";
	otherwise say "[indefinite article for target]";
	now articulating is false.

Section 7b - Indefinite article for target

To say indefinite article for (target - a thing):
	(- print (a) {target}; -).


Section 7c - Definite article for target

To say definite article for (target - a thing):
	(- print (the) {target}; -).


Trinity Inventory ends here.

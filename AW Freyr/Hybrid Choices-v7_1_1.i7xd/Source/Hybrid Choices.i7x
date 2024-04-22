Version 7.1.1 of Hybrid Choices by AW Freyr begins here.

"Provides a choice-based interface that can be freely switched between interactive and non-interactive modes. Basically, it does CYOA."

Part - CYOA Mode

The CYOA mode is a truth state that varies.

To decide if in CYOA mode:
	decide on whether or not CYOA mode is true;

To decide if not in CYOA mode:
	if CYOA mode is true, no;
	yes.

To execute page turning:
	let passed pages be a list of pages;
	let finish condition be a truth state;
	[if the description of X is not "":
		say the description of X;
		say paragraph break;]
	while the finish condition is false:
		follow the page-switch rules for the current page;
		[if a page relates to the current page by the page-flipping relation:]
		if the current page flips to a page (called p1):
			add the current page to the passed pages;
			unless the current page is a one-off and the current page is previously displayed:
				if in cyoa debug mode:
					say "[bracket]Working through [current page] to [destination page]...[close bracket]";
				if the description of the current page is not "":
					say the description of the current page;
					say paragraph break;
				follow the page-output rules for the current page;
				follow the page-toggle rules for the current page;
				now the current page is previously displayed;
			else if in cyoa debug mode:
				say "[bracket]Skipping past [current page]...[close bracket]";
			now the current page is p1;
			if the current page is listed in the passed pages:
				if in cyoa debug mode:
					say "[bracket]It appears that you may have accidently created an infinite loop by following a previous page. I am now failsafing to the previous page.[close bracket]";
				now the current page is the previous page;
				break;
		else:
			now the finish condition is true;
			now the current page is previously displayed;
			if in cyoa debug mode:
				say "[bracket]Working through [current page]...[close bracket]";
			follow the page-toggle rules for the current page;
			if the current page is a dead-end:
				if the description of the current page is not "":
					say the description of the current page;
					say paragraph break;
				follow the page-output rules for the current page;
				now the current page is the previous page;
				follow the page-toggle rules for the current page;
				follow the page-output rules for the current page.



To turn to (x - a page):
	now the previous page is the current page;
	now the current page is X;
	execute page turning;
	try looking.

To switch to CYOA at (x - a page), without looking:
	now the current page is X;
	now CYOA mode is true;
	set choice-window;
	execute page turning;
	unless without looking:
		try looking.

To switch from CYOA, without looking:
	now CYOA mode is false;
	unset choice-window;
	unless without looking:
		try looking.

Part - Pages and Choices

A page is a kind of object.
The no-page is a page.
A page has a text called a description.
A page can be previously displayed.
A page has a text called a cdesc.

The current page is a page that varies.
The previous page is a page that varies.

To decide whether reading (X - a page):
	if X is the current page and in CYOA mode:
		decide yes;
	decide no.

Part - Showing Choices

Table of Currently Available Choices
index	decision	choice-order
(number)	(object)	(number)
with 32 blank rows.

Page-turning relates various pages to various pages.
The verb to turn to implies the page-turning relation.
The verb to be turned to by implies the reversed page-turning relation.
The verb to be for implies the reversed page-turning relation.

To clear choices:
	blank out the whole of Table of Currently Available Choices.

Choice-displaying something is an activity on an object.

The assigned index is a number that varies.

[To say note dead-end for (X - a choice):
    	if in cyoa debug mode:
		if the next page of X offers no choices or the next page of X passes to nothing:
			say "**".]

[EXPERIMENTAL]

Choice-priority is an object based rulebook producing a number.

Last choice-priority rule:
	rule succeeds with result 50.
	
To populate choice list with (n - an object):
	if n is a decision listed in the table of currently available choices, stop;
	choose a blank row from the table of currently available choices;
	now the decision entry is n;
	now the choice-order entry is the number produced by the choice-priority rules for n.

To populate choice list with (n - a description of objects):
	repeat with the item running through n:
		populate choice list with item.

To populate choice lists for (n - a page):
	repeat with K running through pages turned to by N:
		follow the choice-switch rules for K;
		unless rule failed:
			populate choice list with K;
	sort the table of currently available choices in choice-order order;
	repeat through the table of currently available choices:
		increment assigned index;
		now the index entry is the assigned index.

Rule for choice-displaying a page (called X) (this is the print choice description rule):
	say "[cdesc of X]" (A).

Rule for choice-displaying an object (called X) (this is the print choice descriptions for objects rule):
	say "[X]" (A).

Displaying available decisions of something is an activity on pages.

Rule for displaying available decisions of a page (called N) (this is the display all choices rule):
	populate choice lists for N;
	repeat through the table of currently available choices:
		say "[index entry]) " (A);
		carry out the choice-displaying activity with the decision entry;
		say "[line break]" (B);
	now the assigned index is 0.

[/EXPERIMENTAL]

[Before choice-displaying a page (called X) (this is the bookkeeping tasks whilst choice displaying rule):
	increment the assigned index;
	choose a blank row from the table of currently available choices;
	now the index entry is the assigned index;
	now the decision entry is X.

Before choice-displaying a page (this is the show choice number rule):
	say "[assigned index]) ".

Rule for choice-displaying a page (called X) (this is the print choice description rule):
	say "[cdesc of X][line break]".

Displaying available decisions of something is an activity on pages.

Rule for displaying available decisions of a page (called N):
	clear choices;
	let F be a truth state;
	if N turns to a page:
		repeat with K running through pages turned to by N:
			follow the choice-switch rules for K;
			unless the rule failed:
				carry out the choice-displaying activity with K;
		if F is true:
			say line break;
	now the assigned index is 0.]
	
section - Suppressing Choices Depending on Conditions

The choice-switch rules is a page based rulebook.

section - Toggling Conditions After Selecting a Choice

The page-switch rules are a page based rulebook.
The page-toggle rules are a page based rulebook.

section - Displaying Complex Output

The page-output rules are a page based rulebook.

Chapter - Understanding Choices

Choosing is an action applying to a number.
Understand "[a number]" as choosing when in CYOA mode.

Check choosing (this is the can't choose when not in CYOA mode rule):
	if not in CYOA mode:
		say "You don't have a choice to make... you are playing in interactive mode." (A) instead.
[Check choosing (this is the can't choose whilst no choices are offered rule):
	if the current page turns to no pages:
		say "This page doesn't offer any choices." (A) instead.]
Check choosing (this is the can't choose a number for a non-existent choice rule):
	if the number understood is not an index listed in the table of currently available choices:
		say "There is no choice corresponding to that number." (A) instead.

A page has an object called a cyoa teleport. The cyoa teleport is usually nowhere. A page can be no-look.

Carry out choosing (this is the standard carry out choosing rule):
	let K be the decision corresponding to an index of number understood in the table of currently available choices;
	carry out the selecting activity with K;
	try looking;
	if the current page is an end-page or the current page is no-page:
		switch from cyoa.
[	if the cyoa teleport of the current page is a room and the current page is no-look:
		move the player to the cyoa teleport of the current page, without printing a room description;
	else if the cyoa teleport of the current page is a room:
		move the player to the cyoa teleport of the current page.]

Chapter - Selecting Activity

Page-flipping relates various pages to one page (called the destination page).
The verb to flip to implies the page-flipping relation.
The verb to be flipped to by implies the reversed page-flipping relation.

A page can be an end-page.

Selecting something is an activity on objects.

noPCS is a truth state that varies.

Before selecting an object (called x) (this is the print choice selection rule):
	if noPCS is false:
		say "[italic type][bracket]" (A);
		carry out the choice-displaying activity with x;
		say "[close bracket][roman type][paragraph break]" (B).

[Before selecting an object (called x) when x is not a page (this is the print object selection rule):
	say "[italic type][bracket][X][close bracket][roman type][paragraph break]".]

Before selecting (this is the clear choices after selecting rule):
	clear choices.

section a - selecting a page

Rule for selecting a page (called x) (this is the standard change pages rule):
	now the previous page is the current page;
	now the current page is X;
	execute page turning.

section b - selecting not a page

The general choose object rules are an object based rulebook.

The object-choice-handler is an object based rulebook that varies. The object-choice-handler are the general choose object rules.

Rule for selecting an object (called x) (this is the standard handled selected objects rule):
	now the previous page is the current page;
	now the current page is no-page;
	follow the object-choice-handler for x.


Chapter - Refresh Pages

Carry out looking when in CYOA mode (this is the print passage whilst looking in cyoa mode rule):
	if in cyoa debug mode:
		say "[bracket]Looking at [current page][close bracket]..." (A);
	if the description of the current page is not "":
		say the description of the current page;
		say paragraph break;
	follow the page-output rules for the current page;
	now the current page is previously displayed;
	refresh choices;
	rule succeeds.

Chapter - Page Options

section a - One-Off Pages

A page can be one-off.

A choice-switch rule for a one-off page (called F) (this is the don't display choices turning to one-off pages again rule):
	if F is previously displayed, rule fails.

section b - Dead Ends

A page can be a dead-end. 

section c - Item-Dependent

Item-dependency relates various pages to one thing (called the required item).
The verb to be item-dependent on implies the item-dependency relation.

Item-cancellation relates various pages to one thing (called the canceling item).
The verb to be item-canceled by implies the item-cancellation relation.

A choice-switch rule for a page (called Z) (this is the don't display choices without the required item rule):
	if Z is item-dependent on something:
		if the required item of Z is not enclosed by the player:
			rule fails.

A choice-switch rule for a page (called Z) (this is the don't display choices with the canceling item rule):
	if Z is item-canceled by something:
		if canceling item of Z is enclosed by the player:
			rule fails.

section d - Page-Dependent

Page-dependency relates various pages to various pages.
The verb to need means the page-dependency relation.

Page-cancellation relates various pages to various pages.
The verb to cancel means the page-cancellation relation.

A choice-switch rule for a page (called Z) (this is the don't display choices without the required pages rule):
	repeat with X running through pages which are needed by Z:
		if X is not previously displayed:
			rule fails.
	

A choice-switch rule for a page (called Z) (this is the don't display choices with a canceled page rule):
	repeat with X running through pages which cancel Z:
		if X is previously displayed:
			rule fails.

[A page has a list of pages called the required pages. The required pages are usually {}.
A page can be requirement-intensive or requirement-lax. A page is usually requirement-intensive.

A page has a list of pages called the canceling pages. The canceling pages are usually {}.
A page can be canceling-intensive or canceling-lax. A page is usually canceling-lax.]

[A choice-switch rule for a page (called Z) (this is the don't display choices without the required pages rule):
	unless the required pages of Z is {}:
		if Z is requirement-intensive:
			repeat with X running through the required pages of Z:
				if X is not previously displayed:
					rule fails;
		else if Z is requirement-lax:
			let N be a truth state;
			repeat with X running through the required pages of Z:
				if X is previously displayed:
					now N is true;
					break;
			if N is false:
				rule fails.

A choice-switch rule for a page (called Z) (this is the don't display choices with the canceling pages rule):
	unless the canceling pages of Z is {}:
		if Z is canceling-intensive:
			let N be a truth state;
			repeat with X running through the required pages of Z:
				if X is not previously displayed:
					now N is true;
					break;
			if N is false:
				rule fails;
		else if Z is canceling-lax:
			repeat with X running through the required pages of Z:
				if X is previously displayed:
					rule fails.]

section e - Activating/Deactivating

A page can be active or inactive. A page is usually active.

A choice-switch rule for a page (called Z) (this is the don't display choices to inactive pages rule):
	if Z is inactive, rule fails.

To activate (x - a page):
	now x is active.
To deactivate (x - a page):
	now x is inactive

To activate (x - a list of pages):
	repeat with Y running through X:
		now Y is active.
To deactivate (x - a list of pages):
	repeat with Y running through X:
		now Y is inactive.

To activate (x - a description of pages):
	repeat with Y running through X:
		if Y matches X:
			now Y is active.
To deactivate (x - a description of pages):
	repeat with Y running through X:
		if Y matches X:
			now Y is inactive.

[Page-activation relates various pages to various pages.
Page-deactivation relates various pages to various pages.

The verb to 

A page has a list of pages called the activated pages. The activated pages are usually {}.
A page has a list of pages called the deactivated pages. The deactivated pages are usually {}.

A page-toggle for a page (called X):
	if the activated pages of X is not {}:
		activate the activated pages of X;
	if the deactivated pages of X is not {}:
		deactivate the deactivated pages of X.]

Chapter - Item Invoking

Item-invoking disabled is a truth state that varies.
Item-invoking disabled is true.

Item-invoking is an action applying to one visible thing.
Understand "[a thing]" as item-invoking when in cyoa mode and item-invoking disabled is false.

Check item-invoking (this is the can't use item-invoking mode outside of CYOA rule):
	unless in cyoa mode:
		say "[We] can't use items like that outside of choice mode, [we] [have] to actually describe how [we] [are] going to use it." (A) instead.

Report item-invoking (this is the block item-invoking rule):
	say "[The noun] can't be used here." (A) instead.

Chapter - CYOA Teleport

To CYOA teleport to (Z - an object):
	move player to Z, without printing a room description

Part - Cyoa Debug Mode

The CYOA debug boolean is a truth state that varies.

To decide if in cyoa debug mode:
	if the CYOA debug boolean is true:
		decide yes;
	decide no.

section a - Toggling Debug Mode (not for release)

Toggling cyoa debug mode is an action out of world applying to nothing.

Understand "cyoa debug" as toggling cyoa debug mode.

Carry out toggling cyoa debug mode (this is the toggle cyoa debug rule):
	if CYOA debug boolean is false:
		now CYOA debug boolean is true;
		say "Debug mode now on." (A);
	else:
		now CYOA debug boolean is false;
		say "Debug mode now off." (B).

Part - Parser

The reading a command activity has a truth state called the command accepted.

The CYOA error message is a text that varies. The CYOA error message is "That command isn't available in choice mode."
		
After reading a command when in cyoa mode (this is the accept numbers rule):
	if the player's command matches "[a number]", now the command accepted is true.
		
Last after reading a command when in cyoa mode (this is the print cyoa error message rule):
	if the command accepted is false:
		say "[CYOA error message][paragraph break]" (A);
		reject the player's command;
	else:
		now the command accepted is true.

Chapter - Accept Testing Commands (not for release)

After reading a command when in CYOA mode (this is the accept testing commands during CYOA rule):
	if the player's command matches "cyoa debug", now the command accepted is true;
	if the player's command includes "showme", now the command accepted is true;
	if the player's command includes "rules", now the command accepted is true;
	if the player's command includes "test", now the command accepted is true;
	if the player's command includes "relations", now the command accepted is true.

Chapter - Accept System Commands

After reading a command when in cyoa mode (this is the accept system commands during CYOA rule):
	if the player's command matches "l/look/i/inv/inventory/q/quit/save/restore/restart/g/undo", now the command accepted is true.

Chapter - Accept Examining Commands

Use cyoa examining translates as (- Constant CYOA_EXAMINING; -).

After reading a command when in cyoa mode and the cyoa examining option is active (this is the accept examining rule):
	if the player's command includes "x/examine", now the command accepted is true.

Chapter - Accept Item Commands

After reading a command when in cyoa mode (this is the accept items rule):
	if the player's command matches "[a thing]", now the command accepted is true.

Part - Time

[The don't pass time during CYOA mode rule is listed before the every turn stage rule in the turn sequence rules. 
This is the don't pass time during CYOA mode rule: if in CYOA mode, rule succeeds.]

First every turn when in cyoa mode (this is the prevent every turn events rule):
	rule succeeds.
	
Part - Choice Window (for use with Flexible Windows by Jon Ingold)

The choice window size is a number that varies. The choice window size is 20.

The choice window is a text buffer g-window spawned by the main window. The position is g-placebelow. The scale method of the choice window is g-proportional. The measurement of the choice window is 20.

When play begins (this is the set the choice-window size rule):
	now the measurement of the choice window is the choice window size.

For refreshing the choice window (this is the construct choices rule):
	 [move focus to choice-window, clearing the window;]
	 carry out the displaying available decisions activity with the current page.
	 [return to main screen.]

To set choice-window:
	open up choice window.
To unset choice-window:
	shut down choice window.
To refresh choices:
	refresh the choice window;

Part - Windowless CYOA (for use without Flexible Windows by Jon Ingold)

To set choice-window:
	do nothing.
To unset choice-window:
	do nothing.
To refresh choices:
	 carry out the displaying available decisions activity with the current page.

[Book - Testing

The only room is a room.

After looking for the first time:
	switch to cyoa at p1.

P1 is a page.

P2 is a page. The cdesc is "P2". It is for P1.

P3 is a page. The cdesc is "P3". It is for P2.

P4 is a page. It is flipped to by P3.
"Whoa. Interesting.".

P5 is a page. It is flipped to by P4.
"Damn man. That's crazy shit."

P6 is a page. The cdesc is "P6". It is for P5. It is a dead-end.
"You've encountered something and ran away."

P7 is a page. The cdesc is "P7". It is for p5.

P8 is a page. The cdesc is "P8". It is for p5. It is inactive.
"You aren't supposed to see this."]


Hybrid Choices ends here.


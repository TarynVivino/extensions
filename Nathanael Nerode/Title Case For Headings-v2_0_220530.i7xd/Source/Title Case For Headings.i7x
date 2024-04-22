Version 2.0.220530 of Title Case for Headings by Nathanael Nerode begins here.

"Applies title case to room names printed as a heading or in the status line.  Creates the printing a heading activity for further customization.  Tested with Inform 10.1.0.  Requires Undo Output Control by Nathanael Nerode to handle the case of room name printing after UNDO."

[Distinguish printing the *title* of a room in a heading, which should be titlecased, from printing the *name* of a room under other circumstances, which should not.  This allows more coherent use of room names like "a meadow".
There are two "heading" usages in the Standard Rules: the room description heading, and the status line.  There is also a subtle third usage when the room name is printed after "undo".]

Chapter 1 - Title Case for Headings

Section 0 - New activities

Printing a heading is an activity.
Reacting after undoing is an activity.

Section 1 - Replace room description heading rule

[We have to replace the room description heading rule.]
The room description heading with activity rule is listed instead of the room description heading rule in the carry out looking rules.

Carry out looking (this is the room description heading with activity rule):
	say bold type;
	if the visibility level count is 0:
		begin the printing the name of a dark room activity;
		if handling the printing the name of a dark room activity:
			say "[text of the room description heading rule response (A)]" (A);
[			say "Darkness" (A);]
		end the printing the name of a dark room activity;
	otherwise:
		begin the printing a heading activity;
		if handling the printing a heading activity:
			if the visibility ceiling is the location:
				say "[visibility ceiling]";
			otherwise:
				say "[The visibility ceiling]";
		end the printing a heading activity;
	say roman type;
	let intermediate level be the visibility-holder of the actor;
	repeat with intermediate level count running from 2 to the visibility level count:
		if the intermediate level is a supporter or the intermediate level is an animal:
			say "[text of the room description heading rule response (B)]" (B);
[			say " (on [the intermediate level])" (B);]
		otherwise:
			say "[text of the room description heading rule response (C)]" (C);
[			say " (in [the intermediate level])" (C);]
		let the intermediate level be the visibility-holder of the intermediate level;
	if the reacting after undoing activity is going on:
		stop the action; [We only print the room name after "undo", we don't print the rest]
	say line break;
	say run paragraph on with special look spacing.

Section 2 - Titled Rooms

[We have to convince the upcoming code that title is a property!]
A titled room is a kind of room.
A titled room has some text called title.

Section 3 - Default Rule

[This is the default rule: use title case, or title property if present.  It can be overridden, and the examples do so.]
[This *must absolutely* appear before the status line rules, or there is a stack overflow at runtime!]

Rule for printing the name of an object (called item) while printing a heading:
	if the item provides the property title:
		say title of item;
	otherwise:
		[Note that we can't use "[item]" because that will call *this* rule again.]
		let title be the printed name of the item in title case;
		say title. 

Section 4 - Status Line Fix

[The status line has to be handled separately, sadly.  This is the obvious technique:

Before constructing the status line:
	begin the printing a heading activity.
After constructing the status line:
	end the printing a heading activity.

But the obvious technique generates run-time problem P13.  So we do it differently.
Note that this code must be included AFTER the default rule, or there is a stack overflow at runtime!
]

Rule for printing the name of an object (called item) while constructing the status line:
	begin the printing a heading activity;
	carry out the printing the name activity with the item;
	end the printing a heading activity.

Section 5 - Undo Fix

[ Oh, good grief.  We have to dig into Inform 6 again.
UNDO calls SL_Location in order to print its location.  We have to get a hook into the code in the parser
in order to wrap it.  We use Undo Output Control to get the hooks. ]

[Want to print the room name before the "undo succeeded" response.]
The report room after undo rule is listed before the report undo successful rule in the report undoing an action rules.
A report undoing an action rule (this is the report room after undo rule):
	begin the reacting after undoing activity;
	try looking;
	end the reacting after undoing activity;

[Must be before the "default report undoing an action rule", which fails.]
The report undo successful rule is listed in the report undoing an action rules.
A report undoing an action rule (this is the report undo successful rule):
	say "[text of the immediately undo rule response (E)][line break]";
	rule succeeds.

Volume 2 - Disabling Undo Fix when substructure unavailable

Book - first implementation check (for use without Undo Output Control by Erik Temple)

Part - second implementation check (for use without Undo Output Control by Nathanael Nerode)

Section 5 - No Undo Fix (in place of Section 5 - Undo Fix in Title Case for Headings by Nathanael Nerode)

[required to avoid compilation error in 6M62 -- not needed in Inform v10 !  Yay!]
[ dummy_variable_97538642 is a truth state which varies. ]


Title Case for Headings ends here.

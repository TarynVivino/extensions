Version 6.0.2 of Automated Drawers by Emily Short begins here.

"Creates a drawer kind of container, which is designed to be part of an item of furniture. Automatically parses names such as 'top drawer' or 'fourth drawer' or 'left drawer'; adds some features for describing furniture with drawers."

Section 1 - Main body

To open is a verb.

Include Assorted Text Generation by Emily Short.

Definition: a thing is drawered if a drawer is part of it.

A drawer is a kind of container. A drawer is usually closed and openable. Understand "drawer" as a drawer.  

A drawer can be horizontal or vertical. A drawer is usually vertical.

A drawer has a number called drawer number. Understand the drawer number property as describing a drawer.

A drawer has a number called set number. [This indicates how large a group of drawers this particular drawer belongs to.]

Understand "first" as one. Understand "second" as two. Understand "third" as three. Understand "fourth" as four. Understand "fifth" as five. Understand "sixth" as six. Understand "seventh" as seven. Understand "eighth" as eight. Understand "ninth" as nine. Understand "tenth" as ten. Understand "eleventh" as eleven. Understand "twelfth" as twelve.

Drawer position is a kind of value. The drawer positions are solo, top, bottom, leftmost, rightmost, middle. A drawer has a drawer position. A drawer is usually solo. Understand the drawer position property as describing a drawer. Understand "right" as rightmost. Understand "left" as leftmost. Understand "upper" as top. Understand "lower" as bottom.

Understand "[something related by reversed incorporation] drawer" as a drawer. Understand "drawer of [something related by reversed incorporation]" as a drawer.

Understand the open property as describing a drawer. Understand "shut" as closed.

Definition: a direction is matched if it fits the parse list. 
Definition: a room is matched if it fits the parse list. 
Definition: a thing is matched if it fits the parse list. 

To decide whether (N - an object) fits the parse list: 
    (- (FindInParseList({N})) -)


Include (- 

#ifndef FindInParseList;
[ FindInParseList obj i k marker; 
    marker = 0;  
    for (i=1 : i<=number_of_classes : i++) { 
    while (((match_classes-->marker) ~= i) && ((match_classes-->marker) ~= -i)) marker++; 
    k = match_list-->marker;  
    if (k==obj) rtrue; 
    } 
    rfalse; 
]; 
#endif;
-)

Include Complex Listing by Emily Short;

Before printing the name of a drawer (called target) which is not solo while not asking which do you mean (this is the tagging drawers rule): 
	say "[described-position of target] " (A).
	
To say described-position of (target - a drawer):
	if the target is middle:
		if the set number of the target is 3:
			say "middle";
		otherwise:
			say "[ordinal of the drawer number of the target]";
	otherwise if the set number of the target is 2:
		if the target is leftmost:
			say "left"; 
		otherwise if the target is rightmost:
			say "right";
		otherwise if the target is top:
			say "upper";
		otherwise if the target is bottom:
			say "lower";
		otherwise:
			say "[drawer position of target]";
	otherwise:
		say "[drawer position of target]".
	
Rule for printing the name of a drawer (called target) while asking which do you mean (this is the abbreviating drawer names for special situations rule):
	let N be the number of things which incorporate matched drawers;
	if N is 1:
		say "[described-position of target]" (A);
	otherwise if the number of matched drawers is N:
		say "drawer of [the random thing which incorporates the target]" (B);
	otherwise if the number of matched drawers is greater than four:
		say "[described-position of target]" (C);
	otherwise:
		say "[described-position of target] drawer of [the random thing which incorporates the target]" (D).

Rule for clarifying the parser's choice of a drawer (called target) when everything matched is a drawer (this is the very specific parser choice of drawers rule):
	let N be the number of things which incorporate a matched drawer;
	if N is 1:
		make no decision;
	otherwise:
		say "([the target] of [the random thing which incorporates the target])[command clarification break]" (A).

Does the player mean opening a closed drawer (this is the prefer to open closed drawers rule):
	it is very likely.
	
Does the player mean opening an open drawer (this is the avoid opening open drawers rule):
	it is very unlikely.

Does the player mean closing an open drawer (this is the prefer to close open drawers rule):
	it is very likely.
	
Does the player mean closing a closed drawer (this is the avoid closing closed drawers rule):
	it is very unlikely. 

Instead of an actor opening something which incorporates exactly one closed drawer (called the target) (this is the pick one drawer for opening rule):
	try the actor opening the target.

Instead of an actor opening something which incorporates at least two closed drawers (this is the pick a random drawer for opening rule):
	let chosen drawer be a random closed drawer which is part of the noun;
	if the player is the actor:
		say "(choosing [the chosen drawer] at random)[command clarification break]" (A);
	try the actor opening chosen drawer;
	
Instead of an actor opening something which incorporates less than one closed drawer (this is the can't open what is completely open rule):
	if the noun incorporates an open drawer:
		let N be the number of open drawers incorporated by the noun;
		if the player is the actor:
			say "[regarding the open drawers incorporated by the noun][if N is 1]The drawer [are][otherwise if N is 2]Both drawers [are][otherwise]Every drawer [are][end if] open already." (A);
	otherwise:
		continue the action; 
	
	
Instead of an actor closing something which incorporates exactly one open drawer (called the target)  (this is the pick one drawer for closing rule):
	try the actor closing the target.

Instead of an actor closing something which incorporates at least two open drawers (this is the pick a random drawer for closing rule):
	let chosen drawer be a random open drawer which is part of the noun;
	if the player is the actor:
		say "(choosing [the chosen drawer] at random)[command clarification break]" (A);
	try the actor closing chosen drawer;
	
Instead of an actor closing something which incorporates less than one open drawer (this is the can't close what is completely closed rule):
	if the noun incorporates a closed drawer:
		let N be the number of closed drawers incorporated by the noun;
		if the player is the actor:
			say "[regarding the noun][if N is 1]The drawer [are][otherwise if N is 2]Both drawers [are][otherwise]Every drawer [are][end if] closed already." (A);
	otherwise:
		continue the action.
	

Report opening a drawer which is part of something (this is the more specific opening drawers rule):
	say "[We] [open] [the noun] of [the random thing which incorporates the noun][if something is in the noun], revealing [a list of things which are in the noun][end if]." (A) instead.

When play begins (this is the initialize drawers rule):
	repeat with item running through things which incorporate drawers:
		initialize drawers for item.
	
To initialize drawers for (item - a thing):
	let N be the number of drawers which are part of the item;
	let index be 1;
	repeat with chosen drawer running through drawers which are part of the item:
		now drawer number of the chosen drawer is index;
		now the set number of the chosen drawer is N;
		if N is 1:
			now the chosen drawer is solo;
		otherwise:
			if index is 1:
				if the chosen drawer is horizontal:
					now chosen drawer is leftmost;
				otherwise:
					now chosen drawer is top;
			otherwise if index is N:
				if the chosen drawer is horizontal:
					now chosen drawer is rightmost;
				otherwise:
					now chosen drawer is bottom;
			otherwise:
				now chosen drawer is middle; 
		increase index by 1.

Report examining a drawered thing (this is the describe drawered objects rule):
	carry out the describing the drawer layout activity with the noun.

Describing the drawer layout of something is an activity.

Rule for describing the drawer layout of something (called special-target) (this is the list total drawers rule):
	say "[The special-target] has [the number of drawers which are part of the special-target in words] drawer[s]. " (A);

After describing the drawer layout of something (called special-target) (this is the list open drawers rule):
	let O be the number of open drawers which are part of the special-target;
	let C be the number of closed drawers which are part of the special-target;
	let N be indexed text;
	now drawer-passthrough is the special-target;
	if O is greater than C and C is greater than zero:
		let N be "[selection of drawers which are part of the drawer-passthrough conforming to the description closed drawers which are part of the drawer-passthrough is-are] closed, and [if O is less than 4]the other [O in words][otherwise]the rest[end if] open."; 
		say "[N in sentence case][paragraph break]" (A);
	otherwise:
		let N be "[selection of drawers which are part of the drawer-passthrough conforming to the description open drawers which are part of the drawer-passthrough is-are] open."; 
		say "[N in sentence case][paragraph break]" (B).

drawer-passthrough is an object that varies.

Section 2Z - Disambiguation Trick (for Z-Machine only)
	 
Rule for asking which do you mean when everything matched is a drawer and the number of matched things is greater than three (this is the simplifying drawer choice rule):
	say "You have a choice of drawers from [the list of things which incorporate a matched drawer]. Can you be more specific?" (A); 

Section 2G - Disambiguation Trick (for Glulx only)
	 
Rule for asking which do you mean when everything matched is a drawer and the number of matched things is greater than three (this is the simplifying drawer choice rule):
	say "You have a choice of drawers from [the list of things which incorporate a matched drawer]. " (A);
	let started printing be false;
	repeat with item running through things which incorporate a matched drawer:
		say "[The item] has [the number of matched drawers which are part of the item in words][if started printing is false] you might mean[end if]" (B);
		now started printing is true;
		say " ([the list of matched drawers which are part of the item])" (C);
		say ". " (D); 
	say paragraph break.

[The matchlist testing breaks down when used on a lot of objects at once under the z-machine, which is why we save that feature for Glulx.]

After searching something which incorporates a drawer (this is the search opens all drawers rule):
	repeat with item running through drawers which are part of the noun:
		if the item is closed:
			try opening the item;
		otherwise:
			try searching the item; 
	continue the action.

Automated Drawers ends here.

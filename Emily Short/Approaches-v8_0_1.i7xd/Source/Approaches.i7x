Version 8.0.1 of Approaches by Emily Short begins here.

"Approaches provides a GO TO place action which allows the player to move through visited rooms to a new location. It also allows other characters to traverse the map to named locations. It is designed to work with Locksmith by Emily Short, but as of Version 8, that is an optional inclusion."

[ For Approaches' automated movement to work when locked doors are involved,
  include either Implicit Actions by Eric Eve or Locksmith by Emily Short ]

Chapter Common

To find is a verb. To lack is a verb. To head is a verb. To go is a verb.

A person can be staid or hurrying. A person is usually staid.
A room can be proper-named or improper-named.

A person has a list of objects called the path so far.
A person has a list of indexed text called described motion.
	
To say path-walked so far:
	carry out the describing path activity with the player.

Describing path of something is an activity.

Rule for describing path of someone (called the worker) (this is the default path description rule):
	if the number of entries in the path so far of the worker is greater than 0:
		if the location is not the noun:
			let N be the number of entries in the described motion of the worker;
			let last movement be entry N in the described motion of the worker;
			truncate the described motion of the worker to (N - 1) entries;
			if N is 1:
				say "[The worker] [head]" (A);
			otherwise:
				say "[The worker] [go] [described motion of the worker]" (B);
				if N is greater than 2, say ", before heading" (C); 
				otherwise say ", then [head]" (D); 
			say " [the last movement]. [run paragraph on]" (E);
		otherwise:
			say "[The worker] [go] [described motion of the worker]. [run paragraph on]" (F);
	clear path-walked for worker.
		
To clear all/the/-- path-walked for (worker - a person):
	truncate the described motion of the worker to 0 entries;
	truncate the path so far of the worker to 0 entries.

Understand "go to [any visited room]" or "go back to [any visited room]" or "return to [any visited room]" or "revisit [any visited room]"  as approaching.  

Approaching is an action applying to one visible thing.

The approaching action has a room called the initial room.

Check an actor approaching (this is the can't approach our current location rule):
	if the noun is the location of the actor:
		if the actor is the player, say "[We] [are] already in [the location]." (A);
		stop the action;
	otherwise:
		now the initial room is the location;

The approach-finding rules are a rulebook.

The approach-heading is an object that varies.
The approach-destination is a room that varies.
The final destination is a room that varies.

A first approach-finding rule (this is the recording destination rule):
	now the final destination is the noun.

An approach-finding rule (this is the approach-heading selection rule):
	now approach-heading is the best route from the location to the noun through visited rooms, using doors;
	if approach-heading is not a direction:
		now approach-heading is the best route from the location to the noun through visited rooms, using even locked doors;

An approach-finding rule (this is the refusing bad headings rule):
	if approach-heading is not a direction:
		say "[We] [can't] think how to get there from here." (A);
		rule fails; 

An approach-finding rule (this is the find outcome rule):
	now approach-destination is the room approach-heading from the location; 

An approach-finding rule (this is the actual approach movement rule):
	silently try going approach-heading. 

An approach-finding rule (this is the abort movement if held up rule):
	if the location is not the approach-destination:
		clear the path-walked for the player;
		now the player is staid; 
		if the location is not the initial room:
			say conditional paragraph break;
			try looking;
		rule fails; 

Carry out going while the player is hurrying (this is the creating a path history rule):
	add the approach-heading to the path so far of the player; 
	let approach-destination-name be "[the approach-destination]"; 
	let adverb be "";
	let X be the number of entries in the path so far of the player;
	if X is greater than 1:
		let previous direction be entry (X - 1) in the path so far of the player;
		if the previous direction is the approach-heading, now adverb is "again ";   
	let N be "[approach-heading] [adverb]to [approach-destination-name in lower case]"; 
	if approach-destination is proper-named:
		let N be "[approach-heading] [adverb]to [approach-destination-name]"; 
	add N to the described motion of the player; 

An approach-finding rule (this is the final approach success rule):
	rule succeeds.

Carry out approaching (this is the default approaching rule):
	clear path-walked for the player;
	now the player is hurrying;
	let initial location be the location; 
	while the location is not the noun:
		follow the approach-finding rules;
		if rule failed:
			now the player is staid;
			stop the action;
	now the player is staid;

Carry out someone approaching (this is the other character approach rule):
	clear path-walked for the actor;
	let initial location be the location of the actor; 
	while the location of the actor is not the noun:
		now approach-heading is the best route from the location of the actor to the noun, using doors;
		if approach-heading is not a direction:
			now approach-heading is the best route from the location of the actor to the noun, using even locked doors;
		if approach-heading is not a direction:
			stop the action; 
		now approach-destination is the room approach-heading from the location of the actor; 
		try the actor going the approach-heading;
		if the location of the actor is not the approach-destination:
			stop the action.

Report approaching when the location is the noun and the number of entries in the path so far of the player is greater than 1 (this is the describe overall path on arrival rule):
	carry out the describing path activity with the player;
	say paragraph break;
	try looking instead.
	
Report approaching when the location is the noun (this is the default looking on arrival after approaching rule):
	clear path-walked for the player;
	try looking instead.

Approaches ends here.

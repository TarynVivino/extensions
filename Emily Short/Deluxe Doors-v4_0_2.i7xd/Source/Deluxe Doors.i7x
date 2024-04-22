Version 4.0.2 of Deluxe Doors by Emily Short begins here.

"Allows for doors that are implemented as having independent 'faces' -- to put a knocker on that can only be seen from on side, for instance, or to allow the player to lock one side with a key but the other with a latch. Also introduces a 'latched door' kind."

[Updated for adpative responses.]

Include Locksmith by Emily Short. 

To seem is a verb. To lock is a verb. To latch is a verb.

Section 1 - Door Unity

[Doors have reciprocal relations with their other halves]

Door-unity relates one door to another (called the reverse side). The verb to be a half-door of implies the door-unity relation. 

Definition: a door is halved if it is a half-door of something.

Carry out an actor opening a halved door (this is the complete openings rule):
	now the reverse side of the noun is open.
	
Carry out an actor closing a halved door (this is the complete closings rule):
	now the reverse side of the noun is closed.
	
Carry out an actor locking a halved door with something (this is the complete lockings rule):
	now the reverse side of the noun is locked.
	
Carry out an actor unlocking a halved door with something (this is the complete unlockings rule):
	now the reverse side of the noun is unlocked.

 
Section 2 - Latched doors

After deciding the scope of the player:
	repeat with questionable-door running through open doors in the location:
		if the questionable-door is a half-door of a door (called the far side):
			place the far side in scope.
	
Does the player mean doing something with a door which is a half-door of a door which is in the location (this is the don't mess with partial doors rule):
	it is very unlikely.
	
Rule for clarifying the parser's choice of an open door which is a half-door of something (this is the don't ask about partial doors rule): do nothing instead.
	
Setting action variables (this is the assign alternative door targets rule):
	if the noun is a door which is a half-door of a door (called real target):
		if real target is in the location of the actor:
			now the noun is real target; 
	if the second noun is a door which is a half-door of a door (called real target):
		if real target is in the location of the actor:
			now the second noun is real target; 

Rule for reaching inside a room when the particular possession is part of an open door (called target) (this is the arrange scope for partial doors rule):
	if the target is a half-door of a touchable door, allow access.

Section 3 - Safely Phrases

[These can be used to keep the locking and unlocking of halved doors in sync.]

To safely close (N - a door):
	now N is closed;
	if N is halved, now the reverse side of N is closed.

To safely lock (N - a door):
	now N is locked;
	if N is halved and the reverse side of N is lockable:
		now the reverse side of N is locked.

To safely open (N - a door):
	now N is open;
	if N is halved, now the reverse side of N is open.

To safely unlock (N - a door):
	now N is unlocked;
	if N is halved and the reverse side of N is lockable:
		now the reverse side of N is unlocked.

Section 4 - Latched Doors

A latched door is a kind of door. The specification of a latched door is "A door that can be locked by latch rather than with a key. (Usually best used as the 'inside' half of a two-sided door.)"

A door-latch is a kind of thing. Understand "latch" or "latches" as a door-latch. The printed name of a door-latch is "latch". One door-latch is part of every latched door. After examining a latched door, say "It appears to incorporate a latch." 

The specification of a door-latch is "A part of a latched door, which can be turned to lock or unlock that door."

Understand "latch [an unlocked latched door]" as locking keylessly.

Understand "latch [a locked latched door]" or "unlatch [a locked latched door]" as unlocking keylessly.

Section 5 - Keyless Latching and Unlatching

Check an actor unlocking keylessly a latched door (this is the redirect to latching rule):  
	if the noun is unlocked:
		if the actor is the player:
			say "[The noun] [are] already unlocked." (A) instead;
		stop the action; 
	abide by the latching-redirect rule.



Check an actor locking keylessly a latched door (this is the redirect to unlatching rule):
	if the noun is locked: 
		if the actor is the player:
			say "[The noun] [are] already secure." (A) instead;
		stop the action; 
	abide by the latching-redirect rule.

This is the latching-redirect rule:
	let target-latch be a random door-latch which is part of the noun;
	if the target-latch is a thing:
		try the person asked turning the target-latch instead;
	otherwise:
		if the person asked is the player:
			say "[regarding the noun]The latch [seem] to be missing from [the noun]." (A);
		stop the action.

Check an actor locking a latched door with something (this is the can't lock latched doors with keys rule): 
	if the player is the actor:
		say "[The noun] [lock] [if the noun is a half-door of a door which is not a latched door]from this side [end if]with a latch, not with a key." (A) instead;
	otherwise:
		stop the action.

	

Check an actor unlocking a latched door with something (this is the can't unlock latched doors with keys rule):
	if the player is the actor:
		say "[The noun] [lock] [if the noun is a half-door of a door which is not a latched door]from this side [end if]with a latch, not with a key." (A) instead;
	otherwise:
		stop the action.


Carry out an actor turning a door-latch which is part of something (called the parent door) (this is the carry out turning door-latches rule): 
	if the parent door is locked:
		safely unlock parent door;
	otherwise:
		safely lock parent door. 
		
Report an actor turning a door-latch which is part of something (called the parent door) (this is the default report unlatching rule):
	say "[The actor] [if the parent door is locked][otherwise]un[end if][latch] [the parent door]." (A) instead.

Deluxe Doors ends here.

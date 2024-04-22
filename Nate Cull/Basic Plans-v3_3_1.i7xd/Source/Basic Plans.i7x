Version 3.3.1 of Basic Plans by Nate Cull begins here.

"A library of basic relations, actions and plans for Planner."

Include Planner by Nate Cull.

Volume - Relations

[Being-in is a complex relation. It can mean: the planning actor being in a room (triggering door opening, 
pathfinding and travelling), another NPC being in a room (currently no plans for that), or an object being
located in a room or container (triggering containment, dropping, putting in).]

Being-in is a planning-relation.

[Testing is simple, just use the I7 'is in' relation.]

Planning-testing when the desired relation is being-in (this is the basic testing being in rule):
	if the desired param1 is in the desired param2, rule succeeds;
	rule fails;

[Using I7's 'best route' for now. For more complex pathfinding through lockable doorways, we will need to do things 
more manually.]

Planning when the desired relation is being-in and the desired param1 is the planning actor and the desired param2 is a room (this is the basic travel with best route rule):
	plan 1;
	let here be the location of the planning actor;
	let the way be the best route from here to the desired param2;
	let the next room be the room the way from here;
	if the next room is a room, suggest doing-going with the way;
	rule succeeds;


[To get an ordinary portable object into a room, carry it, take it there, and drop it.]

Planning when the desired relation is being-in and the desired param1 is a portable thing and the desired param1 is not a person and the desired param2 is a room (this is the basic dropping objects in rooms rule):
	plan 1;
	suggest being-carried-by with the desired param1 and the planning actor;
	suggest being-in with the planning actor and the desired param2;
	suggest doing-dropping with the desired param1;
	rule succeeds;


[To get an object inside another object, carry it, open the container, get near the container, and put it in.]

Planning when the desired relation is being-in and the desired param1 is a portable thing and the desired param2 is a container (this is the basic putting things in containers rule):
	plan 1;
	suggest being-carried-by with the desired param1 and the planning actor;
	suggest being-open with the desired param2;
	suggest being-touchable-by with the desired param2 and the planning actor;
	suggest doing-putting-in with the desired param1 and the desired param2;	
	rule succeeds;
	

[Openness - fairly easy. Requires unlocking and touching.]

Being-open is a planning-relation.

Planning-testing when the desired relation is being-open (this is the basic testing being open rule):
	if the desired param1 is open, rule succeeds;
	rule fails;

Planning when the desired relation is being-open and the desired param1 is openable (this is the basic opening rule):
	plan 1;
	suggest being-unlocked with the desired param1;
	suggest being-touchable-by with the desired param1 and the planning actor;
	suggest doing-opening with the desired param1;
	rule succeeds;


[Closedness - the reverse of openness.]

Being-closed is a planning-relation.

Planning-testing when the desired relation is being-closed (this is the basic testing being closed rule):
	if the desired param1 is closed, rule succeeds;
	rule fails;

Planning when the desired relation is being-closed and the desired param1 is openable (this is the basic closing rule):
	plan 1;
	suggest being-unlocked with the desired param1;
	suggest being-touchable-by with the desired param1 and the planning actor;
	suggest doing-closing with the desired param1;
	rule succeeds;

[Lockedness - much the same deal. Assumes that if it's a lockable thing that it uses the I7 'matching key' mechanism.
This will need to be overridden for non-keyed locks.]

Being-locked is a planning-relation.

Planning-testing when the desired relation is being-locked (this is the basic testing being locked rule):
	if the desired param1 is not lockable, rule fails;
	if the desired param1 is locked, rule succeeds;
	rule fails;

Planning when the desired relation is being-locked and the desired param1 is lockable (this is the basic locking rule):
	plan 1;
	suggest being-carried-by with the matching key of the desired param1 and the planning actor;
	suggest being-touchable-by with the desired param1 and the planning actor;
	suggest doing-locking-with with the desired param1 and the matching key of the desired param1;
	rule succeeds;


[Unlockedness. Same deal as locking, in reverse.]

Being-unlocked is a planning-relation.

Planning-testing when the desired relation is being-unlocked (this is the basic being unlocked rule):
	if the desired param1 is not lockable, rule succeeds;
	if the desired param1 is unlocked, rule succeeds;
	rule fails;


Planning when the desired relation is being-unlocked and the desired param1 is lockable (this is the basic unlocking rule):
	plan 1;
	suggest being-carried-by with the matching key of the desired param1 and the planning actor;
	suggest being-touchable-by with the desired param1 and the planning actor;
	suggest doing-unlocking-with with the desired param1 and the matching key of the desired param1;
	rule succeeds;


[Visibility - just reverts to the touchability rules.]

Being-visible-by is a planning-relation.

Planning-testing when the desired relation is being-visible-by (this is the basic being visible rule):
	if the desired param2 can see the desired param1, rule succeeds;
	rule fails;

Planning when the desired relation is being-visible-by (this is the basic finding visibility rule):
	plan 1;
	suggest being-touchable-by with the desired param1 and the desired param2;
	rule succeeds;

[Touchability - this is a bit tricky, as it is the main requirement to manipulate most objects, so it triggers
all our mechanisms of finding and picking up things.]

Being-touchable-by is a planning-relation.

[Use I7 touchability, except we don't consider it 'touchable' if it's being carried by any actor other us.]

Planning-testing when the desired relation is being-touchable-by (this is the basic being touchable rule):
	if the desired param2 cannot touch the desired param1, rule fails;
	if the desired param2 encloses the desired param1, rule succeeds;
	if a person encloses the desired param1, rule fails;
	rule succeeds;

[If it's loose in a room, go to it.]

Planning when the desired relation is being-touchable-by and the holder of the desired param1 is a room (this is the basic touching loose objects rule) :
	plan 1;
	suggest being-in with the desired param2 and the holder of the desired param1;
	rule succeeds;

[For containers and supporters, find the outermost one. Make sure containers are open. In case the triggering 
mechanism of a container is elsewhere or requires finding a key, require it open before finding it - the standard 
openability plans will require touchability anyway.]

Planning when the desired relation is being-touchable-by and the holder of the desired param1 is a container (this is the basic touching contained objects rule):
	plan 1;
	suggest being-open with the holder of the desired param1;
	suggest being-touchable-by with the holder of the desired param1 and the desired param2;
	rule succeeds;

Planning when the desired relation is being-touchable-by and the desired param1 is a thing and the holder of the desired param1 is a supporter (this is the basic touching supported objects rule):
	plan 1;
	suggest being-touchable-by with the holder of the desired param1 and the desired param2;
	rule succeeds;

[There's always two sides to a door, so we have to run two parallel plans. Whichever side is reachable and closest 
will be the one we go to.]

Planning when the desired relation is being-touchable-by and the desired param1 is a door (this is the basic touching doors rule):
	plan 1;
	suggest being-in with the desired param2 and the front side of the desired param1;
	plan 2;
	suggest being-in with the desired param2 and the back side of the desired param1;
	rule succeeds;


[The simple form of 'carried' assumes that we want to be directly holding an object. Dealing with sack-type objects
may be a little more complicated. Otherwise, just be near it and pick it up.]

Being-carried-by is a planning-relation.

Planning-testing when the desired relation is being-carried-by (this is the basic being carried rule):
	if the desired param2 carries the desired param1, rule succeeds;
	rule fails;

Planning when the desired relation is being-carried-by and the desired param1 is portable and the desired param2 is the planning actor (this is the basic carrying rule):
	plan 1;
	suggest being-touchable-by with the desired param1 and the planning actor;
	suggest doing-taking with the desired param1;
	rule succeeds;

[Wearing is pretty simple - carry it, then wear it.]

Being-worn-by is a planning-relation.

Planning-testing when the desired relation is being-worn-by (this is the basic being worn rule):
	if the desired param2 wears the desired param1, rule succeeds;
	rule fails;

Planning when the desired relation is being-worn-by and the desired param2 is the planning actor (this is the basic wearability rule):
	plan 1;
	suggest being-carried-by with the desired param1 and the planning actor;
	suggest doing-wearing with the desired param1;
	rule succeeds;

[There's probably an interesting case where we might want to carry but not wear an object, but for now we'll assume
that we just want something not worn, leaving it carried or not carried depending on how we started.]

Being-not-worn-by is a planning-relation.

Planning-testing when the desired relation is being-not-worn-by:
	if the desired param1 is worn by the desired param2, rule fails;
	rule succeeds;

Planning when the desired relation is being-not-worn-by and the desired param2 is the planning actor:
	plan 1;
	suggest doing-taking-off with the desired param1;


Volume 2 - Actions

[The actions are all pretty much just wrappers around the I7 actions. Configuration of custom messages and results
for actors doing things should go as rules on the actions.]


Doing-going is a planning-action.

Planning-acting when the planned action is doing-going (this is the basic executing going rule):
	try the planning actor trying going the planned param1;


Doing-opening is a planning-action.

Planning-acting when the planned action is doing-opening (this is the basic executing opening rule):
	try the planning actor trying opening the planned param1;


Doing-closing is a planning-action.

Planning-acting when the planned action is doing-closing (this is the basic executing closing rule):
	try the planning actor trying closing the planned param1;


Doing-taking is a planning-action.

Planning-acting when the planned action is doing-taking (this is the basic executing taking rule):
	try the planning actor trying taking the planned param1;


Doing-dropping is a planning-action.

Planning-acting when the planned action is doing-dropping (this is the basic executing dropping rule):
	try the planning actor trying dropping the planned param1;

Doing-putting-in is a planning-action.

Planning-acting when the planned action is doing-putting-in (this is the basic executing inserting rule):
	try the planning actor trying inserting the planned param1 into the planned param2;

Doing-locking-with is a planning-action.

Planning-acting when the planned action is doing-locking-with (this is the basic executing locking rule):
	try the planning actor trying locking the planned param1 with the planned param2;


Doing-unlocking-with is a planning-action.

Planning-acting when the planned action is doing-unlocking-with (this is the basic executing unlocking rule):
	try the planning actor trying unlocking the planned param1 with the planned param2;


Doing-wearing is a planning-action.

Planning-acting when the planned action is doing-wearing (this is the basic executing wearing rule):
	try the planning actor trying wearing the planned param1;


Doing-taking-off is a planning-action.

Planning-acting when the planned action is doing-wearing (this is the basic executing taking off rule):
	try the planning actor trying taking off the planned param1;

Basic Plans ends here.

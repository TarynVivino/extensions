Version 6.0.1 of Modified Exit by Emily Short begins here.

"Changes the handling of the EXIT action, allowing commands such as EXIT PLATFORM and GET OUT OF CHAIR, making characters leave enterable objects before traveling, and altering the default interpretation of >OUT when the player is neither inside an object nor in a room with an outside exit. Updated for adaptive text."

Use authorial modesty.

Use sequential action translates as (- Constant SEQUENTIAL_ACTION; -).

Section 1 - Leaving a named object

Understand "exit [thing]" as getting off. Understand "get out of [thing]" as getting off.

This is the new can't get off things rule:	
	if the actor is on the noun, continue the action;
	if the actor is carried by the noun, continue the action;
	if the actor is in the noun, continue the action;
	say "[text of can't get off things rule response (A)][line break]";
	stop the action.

The new can't get off things rule is listed instead of the can't get off things rule in the check getting off rules.

Section 2 - Getting out before taking something

Check an actor taking (this is the clever can't take what you're inside rule): 
	if the holder of the person asked is the noun, 
		abide by the implicit exiting rule;
	if the holder of the person asked is in the noun, rule fails.

The can't take what you're inside rule is not listed in any rulebook.

Section 3 - Getting up before walking away

Instead of going nowhere when the holder of the player is an enterable thing (called the divan) (this is the no motion without purpose rule): 
	if the noun is outside, try exiting instead;
	say "[There's] no exit that way, and [we] [are] [if the divan is a supporter]on[otherwise]in[end if] [the divan] anyway."

Section 4a - Rising before departure (for use without Rideable Vehicles by Graham Nelson)

Check an actor going somewhere when the holder of the person asked is an enterable thing (called the chaise) (this is the rising before departure rule):
	if the chaise is a vehicle, make no decision; [we do not want to activate this rule if the player is for instance in a car or on a bicycle]
	while the holder of the person asked is an enterable thing (called the chaise):
		abide by the implicit exiting rule;
		if the holder of the person asked is the chaise, stop the action;

Section 4b - Rising before departure (for use with Rideable Vehicles by Graham Nelson)

Check an actor going somewhere when the holder of the person asked is an enterable thing (called the chaise) (this is the rising before departure rule):
	if the person asked is on a rideable vehicle or the person asked is on a rideable animal:
		make no decision;
	if the chaise is a vehicle, make no decision; [we do not want to activate this rule if the player is for instance in a car or on a bicycle]
	while the holder of the person asked is an enterable thing (called the chaise):
		abide by the implicit exiting rule;
		if the holder of the person asked is the chaise, stop the action;

Section 5 - Implicit exiting defined

This is the implicit exiting rule:
	let the chaise be the holder of the person asked;
	if the person asked is the player and the sequential action option is not active:
		say "(first getting [if the chaise is a supporter]off[otherwise]out of[end if] [the chaise])[command clarification break]" (A);
		silently try the person asked exiting;
	otherwise:
		try the person asked exiting.

Section 6 - Bare Exit Means OUT

The new convert exit into go out rule is listed instead of the convert exit into go out rule in the check exiting rules.

This is the new convert exit into go out rule: 
	let the local room be the location of the actor;
	if the container exited from is the local room, convert to the going action on the outside.

Section 7 - Stand Up does NOT mean OUT (for use without Postures by Emily Short)

Understand the command "stand" as something new.

Understand "stand on [something]" as entering.

Understand "stand" or "stand up" as standing.

Standing is an action applying to nothing. 

Check an actor standing (this is the check holder for standing rule):
	if the holder of the actor is a room:
		if the actor is the player, say "[We] [are] already up." (A);
		stop the action; 

Carry out an actor standing (this is the convert standing to getting off rule):
	try the person asked getting off the holder of the person asked;
	rule succeeds.

Section 7a - Stand UP does NOT mean OUT (for use with Postures by Emily Short)

[We don't need the definition of stand up, because Postures provides its own version.]

Section 8 - Sequential Action Suppresses Room Description On Exit

The new describe room emerged into rule is listed instead of the describe room emerged into rule in the report exiting rules.

The new describe room stood up into rule is listed instead of the describe room stood up into rule in the report getting off rules.

This is the new describe room emerged into rule:
	if the sequential action option is not active:
		abide by the describe room emerged into rule.

This is the new describe room stood up into rule:
	if the sequential action option is not active:
		abide by the describe room stood up into rule.

Modified Exit ends here.

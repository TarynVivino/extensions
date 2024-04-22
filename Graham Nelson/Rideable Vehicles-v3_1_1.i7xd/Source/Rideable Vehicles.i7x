Version 3.1.1 of Rideable Vehicles by Graham Nelson begins here.

"Vehicles which one sits on top of, rather than inside, such as elephants or
motorcycles."

To mount is a verb. To dismount is a verb.

A rideable animal is a kind of animal.
A rideable animal is usually not portable.
Include (-
	has enterable supporter,
	with before [; Go: return 1; ],
-) when defining a rideable animal.

A rideable vehicle is a kind of supporter.
A rideable vehicle is always enterable.
A rideable vehicle is usually not portable.
Include (-
	with before [; Go: return 1; ],
-) when defining a rideable vehicle.

The stand up before going rule is not listed in any rulebook.

Definition: Something is vehicular if it is a vehicle or it is a
rideable animal or it is a rideable vehicle.

Rule for setting action variables for going (this is the allow rideables to be
	going vehicles rule):
	if the actor is carried by a rideable animal (called the steed),
		now the vehicle gone by is the steed;
	if the actor is on a rideable vehicle (called the conveyance),
		now the vehicle gone by is the conveyance.

Mounting is an action applying to one thing.

Before an actor entering a rideable animal (called the steed), try the actor
mounting the steed instead.

Before an actor entering a rideable vehicle (called the conveyance), try the
actor mounting the conveyance instead.

Before an actor getting off a rideable animal (called the steed), try the
actor dismounting instead.

Before an actor getting off a rideable vehicle (called the conveyance), try
the actor dismounting instead.

Before an actor exiting:
	if the actor is carried by a rideable animal, try the actor dismounting instead;
	if the actor is carried by a rideable vehicle, try the actor dismounting instead.

Check an actor mounting (this is the can't mount when mounted on an animal rule): 
	if the actor is carried by a rideable animal (called the steed):
		if the actor is the player, say "[We] [are] already riding [the steed]." (A);
		stop the action.

Check an actor mounting (this is the can't mount when mounted on a vehicle rule):
	if the actor is on a rideable vehicle (called the conveyance):
		if the actor is the player, say "[We] [are] already riding [the conveyance]." (A);
		stop the action.

Check an actor mounting (this is the can't mount something unrideable rule):
	if the noun is not a rideable animal and the noun is not a rideable vehicle:
		if the actor is the player, say "[The noun] [cannot] be ridden." (A) instead;
		stop the action.

Check an actor mounting (this is the can't mount something carried rule):
	abide by the can't enter something carried rule.

Check an actor mounting (this is the can't mount something unreachable rule):
	abide by the implicitly pass through other barriers rule. 
	
Carry out an actor mounting (this is the standard mounting rule):
	surreptitiously move the actor to the noun.

Report an actor mounting (this is the standard report mounting rule):
	if the actor is the player:
		say "[We] [mount] [the noun]." (A);
		describe locale for the noun;
	otherwise:
		say "[The actor] [mount] [the noun]." (B) instead. 

Unsuccessful attempt by someone trying mounting (this is the mounting excuses rule):
	if the reason the action failed is the can't mount when mounted on an animal rule:
		let the steed be the random rideable animal which carries the person asked;
		say "[The person asked] [are] already riding [the steed]." (A);
	if the reason the action failed is the can't mount when mounted on a vehicle rule:
		let the conveyance be the random rideable vehicle which supports the person asked;
		say "[The person asked] [are] already riding [the conveyance]." (B);
	if the reason the action failed is the can't mount something unrideable rule,
		say "[The noun] [cannot] be ridden." (C).

Understand "ride [something]" as mounting.
Understand "mount [something]" as mounting.

Dismounting is an action applying to nothing.

Check an actor dismounting (this is the can't dismount when not mounted rule):
	if the actor is not carried by a rideable animal and the actor is not on a rideable vehicle:
		if the actor is a player, say "[We] [are] not riding anything." (A);
		stop the action.

Carry out an actor dismounting (this is the standard dismounting rule):
	if the actor is carried by a rideable animal (called the steed),
		now the noun is the steed;
	if the actor is on a rideable vehicle (called the conveyance),
		now the noun is the conveyance;
	let the former exterior be the holder of the noun;
	surreptitiously move the actor to the former exterior.

Report an actor dismounting (this is the standard report dismounting rule):
	if the actor is the player:
		say "[We] [dismount] [the noun].[line break][run paragraph on]" (A);
		produce a room description with going spacing conventions;
	otherwise:
		say "[The actor] [dismount] [the noun]." (B)
	
Unsuccessful attempt by someone trying dismounting (this is the dismounting excuses rule):
	if the reason the action failed is the can't dismount when not mounted rule,
		say "[The person asked] [are] not riding anything." (A);
	otherwise make no decision.

Understand "dismount" as dismounting.

Before asking a rideable animal (called the mount) to try going a
direction (called the way):
	if the player is carried by the mount, try going the way instead.

Rideable Vehicles ends here.

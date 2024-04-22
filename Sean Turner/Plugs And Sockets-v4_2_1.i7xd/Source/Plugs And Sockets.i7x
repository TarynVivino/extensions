Version 4.2.1 of Plugs and Sockets by Sean Turner begins here.

"System for handling plugs and sockets."

Section 1 - Definitions

To decide if the (first-item - a thing) is inserted into the (second-item - a thing):
	repeat with outer loop running through the PS-plugs which are part of the first-item:
		if the attachment of the outer loop is not nothing:
			repeat with inner loop running through the PS-sockets which are part of the second-item:
				if the attachment of the inner loop is the outer loop:
					if the attachment of the outer loop is the inner loop:
						decide yes;
					else:
						say "** Problem! Attachments don't match! **";
	decide no.

To decide what number is the count of occupied plugs of the (item - a thing):
	let count be 0;
	repeat with loop-item running through the PS-plugs which are part of the item:
		if the attachment of the loop-item is not nothing:
			increase count by 1;
	decide on the count.

To decide what number is the count of occupied sockets of the (item - a thing):
	let count be 0;
	repeat with loop-item running through the PS-sockets which are part of the item:
		if the attachment of the loop-item is not nothing:
			increase count by 1;
	decide on the count.
	 
Definition: a PS-socket (called chosen socket) is socket-occupied:
	if the attachment of the chosen socket is nothing:
		no;
	yes.

To decide what number is the count of occupied connectors of the (item - a thing):
	let total be the count of occupied plugs of the item plus the count of occupied sockets of the item;
	decide on the total.

Definition: A thing is a PS-receiver if it incorporates a PS-socket, and it is not a PS-socket.
Definition: A thing is a PS-inserter if it incorporates a PS-plug, and it is not a PS-plug.
Definition: A thing (called the test-item) is attached:
	if the count of occupied connectors of the test-item is 0, decide no;
	decide yes.

Connect listing is a truth state that varies.

After examining a thing (this is the list attached things when examining receiver or inserter rule):
	let receive flag be false;
	if the noun is a PS-receiver:
		say "[The noun] [have] [exam receiver status of the noun]" (A);
		let receive flag be true;
	if the noun is a PS-inserter:
		if receive flag is true, say "[line break]";
		say "[exam inserter status of the noun]." (B).

To say exam inserter status of the (item - a thing):
	say "[regarding the item][They] [are] ";
	if the count of occupied plugs of the item is 0:
		say "not plugged into anything" ;
	else:
		say "[inserter status of the item]"; 

To say inserter status of the (item - a thing):
	now connect listing is true;
	let total be the count of occupied plugs of the item;
	let count be 0;
	repeat with loop-item running through the PS-plugs which are part of the item:
		if the attachment of the loop-item is not nothing:
			increase the count by 1;
			if the count is 1:
				say "plugged into ";
			else if the count is total:
				say " and ";
			else:
				say ", ";
			say "[a holder of the attachment of the loop-item]";
	now connect listing is false;

To say exam receiver status of the (item - a thing):
	if the count of occupied sockets of the item is 0, say "nothing";
	else say "[receiver status of the item]";
	say " plugged into [regarding the item][them].";

To say receiver status of the (item - a thing):
	now connect listing is true;
	let count be 0;
	let total be the count of occupied sockets of the item;
	repeat with loop-item running through the PS-sockets which are part of the item:
		if the attachment of the loop-item is not nothing:
			increase the count by 1;
			if the count is greater than 1:
				if the count is the total:
					say " and ";
				else:
					say ", ";
			say "[a holder of the attachment of the loop-item]";
	now connect listing is false.
	
After printing the name of a something (called the item) while listing contents (this is the list attached things when listing receiver or inserter rule):
	let counter be the count of occupied sockets of the item;
	if the item is a PS-receiver, and connect listing is false, and the counter is greater than 0:
		say " (into which [regarding socket-occupied PS-sockets which are part of the item][are] plugged [receiver status of the item])" (A);
	if the item is a PS-inserter, and connect listing is false, and the count of occupied plugs of the item is greater than 0:
		say " ([inserter status of the item])" (B).


A PS-connector is a kind of thing. It has an object called the attachment. It has some text called the PS-type. The PS-type is usually "standard". A PS-connector can be PS-unknown, PS-male or PS-female (this is its gender property).

Instead of examining a PS-connector (called the item) (this is the PS-connector examination rule):
	if the item is PS-male:
		say "[regarding the item][They] [are] a male [PS-type of the item] connector of [the holder of the noun]. [They] [are] [if the attachment of the noun is nothing]unplugged[else]plugged into [the holder of the attachment of the noun][end if]." (A);
	else:
		say "[regarding the item][They] [are] a female [PS-type of the item] connector of [the holder of the noun]. [They] [have] [if the attachment of the noun is nothing]nothing[else][the holder of the attachment of the noun][end if] plugged into it." (B).

A PS-plug is a kind of PS-connector. It is always PS-male.

A PS-socket is a kind of PS-connector. It is always PS-female.

To disconnect is a verb.

Before an actor going to somewhere (this is the leaving room whilst attached to fixed things rule):
	repeat with item running through the attached carried things:
		repeat with loop-item running through the PS-connectors which are part of the item:
			let the connectee be the attachment of the loop-item;
			if the connectee is not nothing:
				if the holder of the connectee is not carried by the player:
					if PS-leaving is PS-denied:
						if the actor is the player:
							say "It [would] be unwise to leave since [we] [are] carrying [the item] which [are] attached to [the holder of the connectee]." (A);
						stop the action;
					now the attachment of the loop-item is nothing;
					now the attachment of the connectee is nothing;
					if the actor is the player:
						say "[The item] [disconnect] from [the holder of connectee]." (B).
						

Section 2 - Grammar

Understand "plug [something] into [something]" as plugging it into.

Plugging it into is an action applying to two things.

The plugging it into action has an object called the candidate plug.
The plugging it into action has an object called the candidate socket.
The plugging it into action has an object called the candidate inserter.
The plugging it into action has an object called the candidate receiver.
The plugging it into action has an object called the actual plug.
The plugging it into action has an object called the actual socket.

[Next two checks ensure a player other than the actor isn't holding the plug or socket to be used. (Borrowed from the standard can't take people's possessions rule)]
Check an actor plugging something into something (this is the can't-plug-people's-plugs rule):
	let the local ceiling be the common ancestor of the actor with the noun;
	let H be the not-counting-parts holder of the noun;
	while H is not nothing and H is not the local ceiling:
		if H is a person:
			say "[text of can't take other people rule response (A)][line break]" (A);
			stop the action;
		let H be the not-counting-parts holder of H;

The can't-plug-people's-plugs rule is listed last in the check plugging it into rulebook.

Check an actor plugging something into something (this is the can't-plug-into-people's-sockets rule):
	let the local ceiling be the common ancestor of the actor with the second noun;
	let H be the not-counting-parts holder of the second noun;
	while H is not nothing and H is not the local ceiling:
		if H is a person:
			say "[text of can't take other people rule response (A)][line break]" (A);
			stop the action;
		let H be the not-counting-parts holder of H;

The can't-plug-into-people's-sockets rule is listed last in the check plugging it into rulebook.

Check an actor plugging a PS-plug into something (this is the plugging-a-plug rule):
	if the attachment of the noun is not nothing:
		if the actor is the player:
			say "[The noun] [are] already plugged into [the holder of the attachment of the noun]." (A);
		stop the action;
	else:
		now the candidate plug is the noun;
		now the candidate inserter is the holder of the noun.

The plugging-a-plug rule is listed last in the check plugging it into rulebook.
		
Check an actor plugging something that is not a PS-plug into something (this is the plugging-something-other-than-a-plug rule):
	if the noun is not a PS-inserter:
		if the actor is the player:
			say "[The noun] [have] no plug." (A);
		stop the action;
	else:
		now the candidate plug is nothing;
		now the candidate inserter is the noun.
	
The plugging-something-other-than-a-plug rule is listed last in the check plugging it into rulebook.

Check an actor plugging something into a PS-socket (this is the plugging-into-a-socket rule):
	if the attachment of the second noun is not nothing:
		if the actor is the player:
			say "[The second noun] already [have] [the holder of the attachment of the second noun] plugged into it." (A);
		stop the action;
	else:
		now the candidate socket is the second noun;
		now the candidate receiver is the holder of the second noun.
		
The plugging-into-a-socket rule is listed last in the check plugging it into rulebook.

Check an actor plugging something into something that is not a PS-socket (this is the plugging-into-something-other-than-a-socket rule):
	if the second noun is not a PS-receiver:
		if the actor is the player:
			say "[The second noun] [have] no socket." (A);
		stop the action;
	else:
		now the candidate socket is nothing;
		now the candidate receiver is the second noun.
	
The plugging-into-something-other-than-a-socket rule is listed last in the check plugging it into rulebook.

Check an actor plugging something into something (this is the already-plugged-together rule):
	if the candidate inserter is inserted into the candidate receiver:
		if the actor is the player:
			say "[The candidate inserter] [are] already plugged into [the candidate receiver]." (A);
		stop the action.

The already-plugged-together rule is listed last in the check plugging it into rulebook.

Check an actor plugging something into something (this is the plug-unknown-socket-known rule):
	if the candidate plug is nothing, and the candidate socket is not nothing:
		repeat with test-plug running through the PS-plugs which are part of the candidate inserter:
			if the attachment of the test-plug is nothing, and the PS-type of the test-plug is the PS-type of the candidate socket:
				now the actual plug is the test-plug;
				break;
		if the actual plug is nothing:
			if the actor is the player:
				say "[The candidate inserter] [have] no free plugs that match [the candidate socket]." (A);
			stop the action;
		now the actual socket is the candidate socket.

The plug-unknown-socket-known rule is listed last in the check plugging it into rulebook.

Check an actor plugging something into something (this is the plug-known-socket-unknown rule):
	if the candidate plug is not nothing, and the candidate socket is nothing:
		repeat with test-socket running through the PS-sockets which are part of the candidate receiver:
			if the attachment of the test-socket is nothing, and the PS-type of the test-socket is the PS-type of the candidate plug:
				now the actual socket is the test-socket;
				break;
		if the actual socket is nothing:
			if the actor is the player:
				say "[The candidate receiver] [have] no free sockets that match [the candidate plug]." (A);
			stop the action;
		now the actual plug is the candidate plug.

The plug-known-socket-unknown rule is listed last in the check plugging it into rulebook.

Check an actor plugging something into something (this is the plug-unknown-socket-unknown rule):
	if the candidate plug is nothing, and the candidate socket is nothing:
		let matching connection type be "";
		repeat with test-plug running through the PS-plugs which are part of the candidate inserter:
			if the actual plug is not nothing and the actual socket is not nothing, break;
			if the attachment of the test-plug is nothing:
				now the actual plug is the test-plug;
				repeat with test-socket running through the PS-sockets which are part of the candidate receiver:
					if the attachment of the test-socket is nothing, and the PS-type of the test-plug is the PS-type of the test-socket:
						if matching connection type is not "":
							if matching connection type is not the PS-type of the test-plug:
								if the actor is the player:
									say "[regarding PS-plugs]There [are] multiple types of matching plugs and sockets available for [the candidate inserter] and [the candidate receiver]. Try specifying which plug or socket you wish to use." (A);
								stop the action;
						else:
							now the matching connection type is the PS-type of the test-plug;
							now the actual socket is the test-socket;
		if the actual plug is nothing:
			if the actor is the player:
				say "[The candidate inserter] [have] no free plugs available." (B);
			stop the action;
		if the actual socket is nothing:
			if the actor is the player:
				say "[The candidate receiver] [have] no free sockets that [would] allow [the candidate inserter] to be plugged in." (C);
			stop the action.
	
The plug-unknown-socket-unknown rule is listed last in the check plugging it into rulebook.

Check an actor plugging something into something (this is the plug-known-socket-known rule):
	if the candidate plug is not nothing, and the candidate socket is not nothing:
		if the PS-type of the candidate plug is not the PS-type of the candidate socket:
			if the actor is the player:
				say "[The candidate plug] and [the candidate socket][regarding things] [are not] of the same type." (A);
			stop the action;
		now the actual plug is the candidate plug;
		now the actual socket is the candidate socket.

The plug-known-socket-known rule is listed last in the check plugging it into rulebook.

Carry out an actor plugging something into something (this is the plug-something-into-something rule):
	now the attachment of the actual plug is the actual socket;
	now the attachment of the actual socket is the actual plug.

To plug is a verb.

Report an actor plugging something into something (this is the report-plugging it into rule):
	say "[The actor] [plug] [the noun] into [the second noun]." (A).

Understand "unplug [other things] from [something]" as unplugging it from.

Unplugging it from is an action applying to two things.

[Next two checks ensure a player other than the actor isn't holding the plug or socket to be used. (Borrowed from the standard can't take people's possessions rule)]
Check an actor unplugging something from something (this is the can't-unplug-people's-plugs-from rule):
	let the local ceiling be the common ancestor of the actor with the noun;
	let H be the not-counting-parts holder of the noun;
	while H is not nothing and H is not the local ceiling:
		if H is a person:
			say "[text of can't take other people rule response (A)][line break]" (A);
			stop the action;
		let H be the not-counting-parts holder of H;

The can't-unplug-people's-plugs-from rule is listed last in the check unplugging it from rulebook.

Check an actor unplugging something from something (this is the can't-unplug-from-people's-sockets rule):
	let the local ceiling be the common ancestor of the actor with the second noun;
	let H be the not-counting-parts holder of the second noun;
	while H is not nothing and H is not the local ceiling:
		if H is a person:
			say "[text of can't take other people rule response (A)][line break]" (A);
			stop the action;
		let H be the not-counting-parts holder of H;

The can't-unplug-from-people's-sockets rule is listed last in the check unplugging it from rulebook.

Check an actor unplugging PS-inserter from a PS-receiver(this is the item-must-be-plugged-into-second-item rule):
	unless the noun is inserted into the second noun:
		if the actor is the player:
			say "[The noun] [are not] plugged into [the second noun]." (A);
		stop the action.

The item-must-be-plugged-into-second-item rule is listed last in the check unplugging it from rulebook.

Check an actor unplugging a PS-plug from something (this is the cannot-unplug-plugs-from rule):
	if the actor is the player:
		say "You cannot specify a particular plug when unplugging something." (A);
	stop the action.

The cannot-unplug-plugs-from rule is listed last in the check unplugging it from rulebook.

Check an actor unplugging something from a PS-socket (this is the cannot-unplug-from-sockets rule):
	if the actor is the player:
		say "You cannot specify a particular socket when unplugging something." (A);
	stop the action.

The cannot-unplug-from-sockets rule is listed last in the check unplugging it from rulebook.

Check an actor unplugging something from something (this is the catch-invalid-unplugging-it-from rule):
	if the noun is not a PS-inserter, or the second noun is not a PS-receiver:
		try the actor removing the noun from the second noun instead.
[		if the actor is the player:
			say "[The noun] [is-are] not plugged into [the second noun].";
		stop the action.]

The catch-invalid-unplugging-it-from rule is listed last in the check unplugging it from rulebook.

Carry out an actor unplugging something from something (this is the unplug-two-items rule):
	repeat with test-plug running through the PS-plugs which are part of the noun:
		let the test-socket be the attachment of the test-plug;
		if the test-socket is not nothing:
			if the test-socket is a part of the second noun:
				now the attachment of the test-plug is nothing;
				now the attachment of the test-socket is nothing;

To unplug is a verb.

Report an actor unplugging something from something (this is the report-actor-unplugging-it-from rule):
	say "[The actor] [unplug] [the noun] from [the second noun]." (A).

Understand "unplug [something]" as unplugging.

Unplugging is an action applying to one thing.

Check an actor unplugging something (this is the can't-unplug-people's-plugs rule):
	let the local ceiling be the common ancestor of the actor with the noun;
	let H be the not-counting-parts holder of the noun;
	while H is not nothing and H is not the local ceiling:
		if H is a person:
			say "[text of can't take other people rule response (A)][line break]" (A);
			stop the action;
		let H be the not-counting-parts holder of H;

The can't-unplug-people's-plugs rule is listed last in the check unplugging rulebook.

Check an actor unplugging PS-inserter (this is the ensure-item-only-plugged-into-1-thing rule):
	let plugged count be the count of occupied plugs of the noun;
	if the plugged count is 0:
		if the actor is the player:
			say "[The noun] [are not] plugged into anything." (A);
		stop the action;
	if the plugged count is greater than 1:
		if the actor is the player:
			let item be "[noun]" in upper case;
			say "[The noun] [are] plugged into more than one thing. [bracket]try UNPLUG [item] FROM something[close bracket][line break]" (B);
		stop the action.

The ensure-item-only-plugged-into-1-thing rule is listed last in the check unplugging rulebook.

Check an actor unplugging a PS-plug (this is the cannot-unplug-plugs rule):
	say "You cannot specify a particular plug when unplugging something." (A) instead.

The cannot-unplug-plugs rule is listed last in the check unplugging rulebook.

Check an actor unplugging something that is not a PS-inserter (this is the catch-invalid-unplugging-it rule):
	if the actor is the player:
		say "[The noun] [are not] plugged into anything." (A);
	stop the action.

The catch-invalid-unplugging-it rule is listed last in the check unplugging rulebook.

Carry out an actor unplugging (this is the unplug-item-from-inferred-item rule):
	repeat with test-plug running through the PS-plugs which are part of the noun:
		let the test-socket be the attachment of the test-plug;
		if the test-socket is not nothing:
			now the second noun is the holder of the test-socket;
			if the actor is the player:
				say "(from [the second noun])[command clarification break]" (A); 
			try the actor unplugging the noun from the second noun instead;
			stop the action;
	say "*** Problem : Couldn't find match for [the noun] when unplugging ***" (B).

[This allows "INSERT" to work as "PLUG" when the noun is an inserter or plug AND the second noun is a receiver or socket. Otherwise the action will continue.]
Before an actor inserting something into something (this is the allow-inserting-for-plugging rule):
	if the noun is a PS-inserter, or the noun is a PS-plug:
		if the second noun is a PS-receiver, or the second noun is a PS-socket:
			try actor plugging the noun into the second noun instead;
	continue the action.

[This allows "ATTACH" to work as "PLUG" when the noun is an inserter or plug AND the second noun is a receiver or socket. Otherwise tying it to is attempted.]
Understand the command "attach" as something new.
PS-attaching it to is an action applying to two things.
Understand "attach [something] to [something]" as PS-attaching it to.
Instead of an actor PS-attaching something to something (this is the allow-plug-or-tie-depending-on-type rule):
	if the noun is a PS-inserter, or the noun is a PS-plug:
		if the second noun is a PS-receiver, or the second noun is a PS-socket:
			try actor plugging the noun into the second noun instead;
	try actor tying the noun to the second noun instead.

[Allows "DETACH" as a synonym for "UNPLUG"]
Understand the command "detach" as "unplug".

[Make "REMOVE something from something" act as a synonym for "UNPLUGGING something from something" - unless the first thing is inside the second, then removing it from is attempted.]
Understand "remove [something] from [something]" as unplugging it from.

[Allows "REMOVE plug" or "REMOVE inserter" - also allows "TAKE OFF plug"]
Before of an actor taking off something (this is the allow-removing-for-unplugging rule):
	if the noun is a PS-inserter, or the noun is a PS-plug:
		try actor unplugging the noun instead;
	continue the action.

Section 3 - Variables

A permission is a kind of value. The permissions are PS-allowed and PS-denied. 

PS-leaving is a permission that varies. PS-leaving is PS-denied.

Plugs and Sockets ends here.

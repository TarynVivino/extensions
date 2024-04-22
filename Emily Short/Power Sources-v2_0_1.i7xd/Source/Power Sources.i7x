Version 2.0.1 of Power Sources by Emily Short begins here.

"Power Sources provides an implementation of plugs and batteries, and is designed to be used alongside Computers or as a base for other device implementations. It requires Plugs and Sockets by Sean Turner."

Part 1 - Wall Power

[Mostly we're relying on Sean's extension; the additions here are just to make for more convenient default behavior. ]

Include Plugs and Sockets by Sean Turner. 

A wall socket is a kind of thing. It is scenery. Every wall socket incorporates a PS-socket.

Understand "plug in [something]" or "plug [something] in" as plugging it into.

Rule for supplying a missing second noun while plugging something into (this is the assume a wall socket rule):
	if a wall socket (called target) is visible:
		now the second noun is the target;
	otherwise:
		say "You'll have to say what you want to plug [the noun] into." (A)

Part 2 - Battery Power

Section 1 - Batteries

A battery is a kind of thing. A battery has a number called charge. The charge of a battery is usually 60. 

A rechargeable battery is a kind of battery. A rechargeable battery has a number called maximum charge. The maximum charge of a rechargeable battery is usually 60.

Definition: a battery is discharged if its charge < 1.
Definition: a rechargeable battery is fully charged if its charge is its maximum charge.

[We make this rule occur at the beginning of the every turn rules so that if the devices are themselves doing something every turn while switched on, we don't get a sequence where the player removes a battery, the robot dog barks one last time anyway, and only then do we get the robot dog shutdown message.]
A first every turn rule (this is the check power sources rule):
	follow the energy management rules.

The energy management rules are a rulebook.

An energy management rule (this is the deplete or recharge batteries rule):
	repeat with hollow running through battery compartments:
		if the hollow is part of a device (called the machine):
			if a battery (called cell) is in the hollow:
				if the machine is wall-powered:
					if the cell is a rechargeable battery and charge of the cell is less than the maximum charge of the cell:
						increase the charge of the cell by the battery recharge of the machine;
						if the charge of the cell is greater than the maximum charge of the cell:
							now the charge of the cell is the maximum charge of the cell;
						if the cell is fully charged and the player can see the machine:
							carry out the notifying of full charge activity with the machine;
				otherwise if the machine is switched on:
					decrease the charge of the cell by the battery drain of the machine;
					if the player can see the machine:
						carry out the warning about the failure activity with the machine.


Section 2 - Battery Compartments

A battery compartment is a kind of container. A battery compartment is usually closed and openable and privately-named. Understand "battery compartment" or "compartment" or "compartment of [something related by reversed incorporation]" as a battery compartment.

Setting action variables for an actor opening a device  (this is the divert opening actions to the battery compartment rule):
	now the noun is a random battery compartment which is part of the noun. 

Setting action variables for an actor closing a device  (this is the divert closing actions to the battery compartment rule):
	now the noun is a random battery compartment which is part of the noun.

Setting action variables for an actor inserting a battery into a device  (this is the divert inserting actions to the battery compartment rule):
	now the second noun is a random battery compartment which is part of the second noun.

Setting action variables for an actor switching on a battery compartment which is part of a device (called the power user) (this is the divert switching on actions to the device rule): 
	now the noun is the power user.

Setting action variables for an actor searching a device which incorporates a battery compartment (called the target) (this is the divert searching actions to the compartment rule):
	now the noun is the target.

Check an actor inserting something which is not a battery into a battery compartment (this is the can't put non-batteries in a battery compartment rule):
	if the actor is the player:
		say "Only batteries should go in a battery compartment.";
	stop the action.

Definition: a device is empty:
	if a random battery compartment which is part of it contains a battery (called the power source):
		if the power source is discharged, yes;
		no;
	yes.

Section 3 - Battery-related Understand tricks

[And to get rid of annoying messages like "Which would you like to close, the flashlight or the flashlight's battery compartment?" when only the compartment is closable, we might add some understanding instructions:]

Understand "turn on [device]" as switching on.

Understand "turn off [device]" as switching off.

Understand "open [openable closed thing]" as opening.

Understand "close [openable open thing]" as closing.

Understand "put [an unencumbered thing] in [container]" as inserting it into.

Definition: a thing is unencumbered if it is not part of something and it is not fixed in place and it is not scenery.

[These options are isolated into their own section so that if we ever want to get rid of them or we're working with another extension that already includes this information, we can replace the section and be rid of them.]

Section 4 - Does the Player Mean rules about batteries and compartments
 

Does the player mean doing something other than searching to a battery compartment (this is the prefer only to search compartments rule): 
	it is unlikely. [We discourage Inform from choosing a compartment when the player uses just the name of a device or the word 'battery'.]

Does the player mean inserting into a battery compartment (this is the prefer not to insert non-batteries into a battery compartment rule): 
	if the noun is nothing: 
		it is very likely; 
	otherwise: 
		make no decision.

Does the player mean inserting a battery compartment into (this is the prefer not to insert compartments rule):
	 it is very unlikely.
Does the player mean taking a battery which is in a battery compartment (this is the prefer to take batteries rule):
	it is very likely.
Does the player mean taking a battery compartment (this is the prefer not to take compartments rule):
	it is very unlikely.
Does the player mean inserting something into a device (this is the prefer not to insert into devices rule): 
	it is unlikely.
Does the player mean searching a battery compartment (this is the prefer searching compartments rule): 
	it is very likely.

Section 5 - Device effects on batteries

[These numbers control how rapidly a device drains batteries, starting from a default of 1 charge point per turn, and how fast they recharge. Out of kindness to the player, we default to recharging four times as fast as we discharge, but that can be changed.]

A device has a number called the battery drain. The battery drain of a device is usually 1.
A device has a number called the battery recharge. The battery recharge of a device is usually 4.

Part 3 - Power and Powerlessness

Chapter 1 - Powered, Wall-Powered and Unpowered

Definition: a device (called the test device) is powered:
	follow the power-determination rules for the test device;
	if rule succeeded:
		yes;
	no.

The power-determination rules are an object based rulebook.

A power-determination rule for something (called test device) (this is the no interference with completely powerless devices rule):
	if the test device does not incorporate a PS-plug and the test device does not incorporate a battery compartment:
		rule succeeds. [we assume the device is magically self-powered somehow; this means we don't lose the functionality of every device in the game just by including this extension.]

A power-determination rule for something (called test device) (this is the wall-powered devices work rule):
	if the test device is wall-powered:
		rule succeeds.

A power-determination rule for something (called test device) (this is the devices containing undepleted batteries work rule):
	if the test device incorporates a battery compartment:
		if the test device is not empty:
			rule succeeds.

Last power-determination rule for something (called test device) (this is the no power if we can't find a power source rule):
	rule fails.

Definition: a device (called the test device) is battery-powered:
	if the test device incorporates a battery compartment and the test device is not wall-powered:
		yes;
	no.

Definition: a device (called the test device) is wall-powered:
	repeat with item running through PS-plugs which are part of the test device:
		repeat with second item running through PS-sockets which are part of a wall socket:
			if the item is the attachment of the second item:	
				yes;
	no.
	
Definition: a device is unpowered if it is not powered.

Chapter 2 - Refusing to turn on

Check an actor switching on an unpowered device (this is the can't switch on powerless devices rule):
	if the player is the actor:
		say "[The noun] [are] without power." (A) instead;
	stop the action.

Chapter 3 - Warning about failure

Warning about the failure of something is an activity.

Rule for warning about the failure of a device (called the machine) (this is the default warn about extinguishing rule):
	if a random battery compartment which is part of the machine  contains a battery (called the power source):
		let turns remaining be the charge of the power source divided by the battery drain of the machine;
		if the turns remaining is 1:
			say "[The machine] [are] nearing the end of [their] battery life." (A)

Chapter 4 - Putting out devices

Putting out something is an activity.

Rule for putting out a device (called the item) (this is the extinguishing cut-off machines rule):
	let the old noun be the noun;
	now the noun is the item;
	follow the carry out switching off rules; 
	now the noun is the old noun.

After putting out a visible device (called the machine) (this is the default describe putting out a device rule):
	say "[The machine] [are] now off.[line break]" (A)

A last energy management rule:
	repeat with item running through unpowered switched on devices:
		carry out the putting out activity with the item. 

Chapter 5 - Notifying of full charge

Notifying of full charge of something is an activity.

Rule for notifying of full charge of a device (called the machine) (this is the default notify about recharging rule):
	if a random battery compartment which is part of the machine contains a fully charged rechargeable battery (called the power source):
		say "[The power source] in [the machine] [regarding power source][are] [if story tense is present tense]now [end if]fully charged." (A)

Power Sources ends here.

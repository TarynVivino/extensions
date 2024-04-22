Power Sources provides an implementation of plugs and batteries, and is designed to be used alongside Computers or as a base for other device implementations. It requires Plugs and Sockets by Sean Turner.

Chapter: Power

Section: Power from the wall

Power Sources creates a kind called wall socket, which is the source of home electricity. Beyond this, it largely depends on Plugs and Sockets by Sean Turner. To create a lamp that can be plugged in, we would write

	A lamp is a device in foo. The lamp incorporates a PS-plug.

and to indicate that a given room is capable of offering it power:

	The Salon contains a wall socket.

By default a wall socket has one PS-socket, which is to say that it can have one thing plugged into it. If we wish to extend that, we need only iterate the socket-assigning assertion until our sockets are as buff as we desire:

	Every wall socket incorporates a PS-socket.

(These function cumulatively.)

One inherited behavior from Plugs and Sockets is that by default it is not possible for the player to walk away from a socket while carrying a plugged-in object. I quote from the documentation there:

	"One final point: a value called PS-leaving can be either PS-denied or PS-allowed. It is PS-denied by default. When it is PS-denied and the player attempts to leave a location whilst carrying something attached to something not carried, a message will be displayed and the action prevented. If this variable is set to PS-allowed, the action will be okay but all the relevant connections for those things carried will be broken."

Section: Power from batteries

Power sources also defines kinds for batteries (and a subset, rechargeable batteries) and battery compartments. A battery compartment is part of the device it powers, and can contain only batteries.

The default behavior is that a battery has a charge (or battery life) of 60. If we leave all settings at their default, this number represents 60 turns of play, or an hour at minute-to-minute equivalence.

It is possible to change these effects. We can change the charge of a battery to a different number (and the maximum charge of a rechargeable battery, to make sure it can't be repowered for a longer time than we want).

Furthermore, each device has numbers called battery drain (how many points of charge it takes to operate per minute) and battery recharge (how many points of charge it restores if it is being used to restore a drained rechargeable battery). By default, these numbers are 1 and 4, respectively, so a 60-charge battery takes 60 turns to drain and 15 to recharge.

However, if we want different game devices to drain batteries at different speeds, we may alter these numbers. For instance, if we wanted to model a digital camera and a trusty little emergency flashlight, we might do something like this:

	The AA-cell is a battery. The charge of the AA-cell is 180.
	The battery drain of the digital camera is 18.

The battery drain of the flashlight is still 1, so it depletes the charge of the AA-cell at 1 point per turn, lasting three hours, but the digital camera takes only 10 minutes to consume the same battery.

This system does not account for having different battery types associated with different sorts of device. If we do want to implement this, the most expedient way is probably to create sub-kinds, as in

	A D-cell battery is a kind of battery.
	A laptop battery compartment is a kind of battery compartment.

...and add our own rules forbidding any kind of battery except the correct one from being put in a specific type of compartment.

Finally, it's true that many common devices operate on pairs of batteries simultaneously, but modeling this in great detail, including the effect of running differently-charged batteries together, is probably not worth the effort. If this is found to be disappointingly unrealistic, we might try creating a single battery object that just pretends to be a pair of batteries, as in

	A pair of AA batteries is a battery.

Section: Is this device powered?

A device is considered to be powered if:

1) it incorporates neither a PS-plug nor a battery compartment. This is meant as a fail-safe: if the author includes this extension but has some devices defined that he doesn't designate as having either a battery compartment or a power plug, those devices will go on functioning the same way they did before the extension was included.

2) it incorporates a PS-plug that is plugged into a wall socket.

3) it incorporates a battery compartment that contains an undepleted battery.

These criteria can be changed or augmented using the power-determination rulebook, of which the rules look like this, for instance:

	A power-determination rule (this is the no interference with completely powerless devices rule):
		if the test device does not incorporate a PS-plug and the test device does not incorporate a battery compartment:
			rule succeeds;

Revising these rules might be appropriate if, for instance, we wanted to take advantage of more of the sophistication of the Plugs and Sockets extension, and model not just wall sockets but also extension cords and multiple power plug types.

Chapter: Behavior of powered devices

Section: Devices cannot be turned on when they have no power

Thanks to the can't switch on powerless devices rule, we cannot switch on an unpowered device.

Section: Battery-powered devices issue a warning when they are nearly out of power

The warning about the failure activity currently handles this, and has a single rule:
	
	Rule for warning about the failure of a device (called the machine) (this is the default warn about extinguishing rule):
		let turns remaining be the charge of the power source divided by the battery drain of the machine;
		if the turns remaining is 1:
			if the charge of the power source is 2:
				say "[The machine] [is-are] obviously going to go out quite soon."

If we want to issue other warnings, or warnings at other times, we can do so by adding other rules to the activity. We can also remove this one, as in

	{*}The default warn about extinguishing rule is not listed in any rulebook.

Section: Devices shut off when they have no power

The putting out a device activity handles the case where a device loses power (either thanks to battery failure or through being unplugged). The For... rules of the activity actually turn the device off, while the After... rules provide a description of the shutdown.

By default we start with the extremely bland after rule

	After putting out a visible device (called the machine) (this is the default describe putting out a device rule):
		say "[The machine] [is-are] now off.[line break]"

It's possible to turn off a device by unplugging it even if the check rules would normally forbid this. That is because we might, for instance, encounter the evil master computer whose off-switch is cunning protected by laser turrets, but pulling out its power cord will still do the trick.

If we don't want that to be the case, we will need to replace the "extinguishing cut-off machines rule" rule.

Section: Device gives notice when its internal rechargeable battery reaches full power

The notifying of full charge activity lets us give a message when something becomes fully charged, as in this default rule:

	Rule for notifying of full charge of a device (called the machine) (this is the default notify about recharging rule):
		if a random battery compartment which is part of the machine contains a fully charged rechargeable battery (called the power source):
			say "[The power source] in [the machine] [is-are of power source] now fully charged."

The intent is that the player need not constantly recheck the battery during charging to determine whether it has finished yet.


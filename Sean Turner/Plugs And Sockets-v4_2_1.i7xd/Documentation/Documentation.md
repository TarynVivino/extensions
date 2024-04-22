
This extension provides a mechanism to add plugs and sockets of various kinds to things to allow objects to attach to one another. For example, one could create a TV with a (male) plug attached. Additionally a wall point with a (female) socket could be created thereby allowing the TV to be plugged into it. This could be coded like so:

	Test Lab is a room.

	A wall point is here. It is fixed in place. Incorporated by it is a PS-socket.

	A TV is here. It is fixed in place. Incorporated by it is a PS-plug.

This allows the TV to be plugged into the wall point. Naturally, the TV can be unplugged from the wall point. The additional grammar "PLUG something into something" and "UNPLUG something FROM something" have been provided for this.

Things can have both plugs and sockets. For example:

	A power board is here. Incorporated by it is a PS-plug and four PS-sockets.

This allows up to four things that have plugs to be plugged into the power board, whilst it itself can be plugged into something with a socket, such as the wall point. Note that when plugging, a specific plug and/or socket can be nominated. This is not permitted when unplugging, but more on this later.

One point about multiple plugging: a thing cannot be plugged into something more than once. So, for example, if we have a cable defined thusly:

	A cable is here. Incorporated by it are two PS-plugs.

we cannot "PLUG CABLE INTO THE POWER BOARD" twice. The first time is okay but the second will be rejected, even though we could, in the real world, plug a both ends of male-male power cable into a power board.

Plugs and sockets have a text property called "PS-type". By default, the PS-type of sockets and plugs provided - PS-socket and PS-plug - is "standard". If you use these kinds only, then everything will work nicely as expected. However we may want to create plugs and sockets of different kinds. For example:

	An S-Video plug is a kind of PS-plug. The PS-type of an S-Video Plug is "S-Video".
	An S-Video socket is a kind of PS-socket. The PS-type of an S-Video Socket is "S-Video".

	An S-Video cable is here. Incorporated by it are two S-Video plugs.

	An amplifier is here. Incorporated by it is an S-Video socket.
	A DVD player is here. Incorporated by it is an S-Video socket.

creates an S-Video cable that can connect between an amplifier and a DVD player. Plugs and sockets of differing types cannot be plugged into each other.

It becomes more complex when considering some things may contain several different types of sockets. For example:

	An HDMI socket is a kind of PS-socket. The PS-type of an HDMI socket is "HDMI".
	An HDMI plug is a kind of PS-plug. The PS-type of an HDMI plug is "HDMI".
	An HMDI cable is here. Incorporated by it are two HDMI plugs.
	The amplifier incorporates an HDMI socket.

The amplifier now has two different types of socket. This isn't so bad because if we try "PLUG HDMI CABLE INTO AMPLIFIER" the game will know, without ambiguity, which socket to use.

Similarly, we could define an adapter cable that has a 3.5mm audio plug at one end and a pair of RC audio connectors at the other. If we attempted to plug this into something with only one type of socket (say an iPhone), it would automatically plug in the correct matching plug.

Things can have any number of plugs and sockets of any type attached.

It can become too complicated to figure out which cable end to plug into which socket. For example, if we had an adapter cable with an HDMI plug at one end and an S-Video plug at the other, we would have trouble with "PLUG CABLE INTO THE AMPLIFIER" (assuming the sockets of the amplifier were all free). This is because the code doesn't know which end to plug in - either would be valid. In this case, the solution is to name the plugs and/or the sockets. Then the player can specify which end is to be plugged into the amplifier.

	A complex cable is here. The description is "An HDMI to S-Video adapter cable (which is probably not possible!)".
	The HDMI end of the cable is an HDMI plug. It is part of the complex cable.
	The S-Video end of the cable is an S-Video plug. It is part of the complex cable.

Now the player can type "PLUG THE HDMI END OF THE CABLE INTO THE AMPLIFIER" which will work as expected. Or even "PLUG THE HDMI END OF THE CABLE INTO THE HDMI-IN SOCKET" (if the sockets were appropriately named) would work if you wanted to be more specific still.

Similarly, "UNPLUG CABLE FROM THE AMPLIFIER" performs as expected. If the cable is only plugged into the amplifier, just "UNPLUG CABLE" would be sufficient.

The synonyms "INSERT" and "ATTACH" work for "PLUG", likewise "DETACH" and "REMOVE" work for "UNPLUG". Note these synonyms work when the attempt is made for plugs or sockets or things containing plugs or sockets. Otherwise the existing behaviour for the synonym (if it exists) will take place. For example, if "ATTACH" is attempted for a non-plug or something not containing a plug, the command will revert to being understood as "TIE". All of this behaviour can be changed with appropriate manipulation of the listed rules.

The extension does support plural items with appropriate messages. So "PLUG TV INTO SOME BANANAS" will give the message "The bananas have no socket" rather than "The bananas has no socket".

The extension also supports actors other than the player. For example, "GEORGE, PLUG THE CORD INTO THE POWER POINT" will work correctly (as long as George is willing).

There are currently three major limitations to the extension:
1) You cannot plug an item into another item multiple times. There is a rule which explicitly forbids it (although it could be delisted). It creates problems with listing attachments and ambiguity and wasn't really necessary.
2) You cannot name a plug or socket when unplugging. Once again, it would have added complexity and I didn't believe it is needed.
3) Plugs and sockets has not been tested for multi-layered situations. That is, a plug or socket must be a part of a parent object, not a part of a part. For example, lets say we have an "entertainment system" which has a "DVD player" as a part. The "DVD player" could then have a plug as a part of it. However this may cause problems when trying to "PLUG" it into things.

One final point: a value called PS-leaving can be either PS-denied or PS-allowed. It is PS-denied by default. When it is PS-denied and the player attempts to leave a location whilst carrying something attached to something not carried, a message will be displayed and the action prevented. If this variable is set to PS-allowed, the action will be okay but all the relevant connections for those things carried will be broken.


Deluxe Doors allows for doors to have two sides, so that they can be unlocked differently from different directions and also so that they can have things visible on one face but not on the other. It also allows for doors to be latched rather than locked and unlocked with keys.

Deluxe Doors requires Plurality and Locksmith by Emily Short.

Chapter: Two One-sided Doors

Section: Setting Up

To set up a pair of doors, we use the "door-unity" relation, expressed with the phrase "is a half-door of". Thus

	Porch is a room. The house door is south of Porch. It is a lockable door. Through the house door is the Living Room.

	The porch door is north of Living Room. Through the porch door is the Porch. The porch door is a door. The porch door is a half-door of the house door.

creates a pair of one-way doors that are now understood to be linked. We can also use the adjective "a halved door" to refer to doors that are only half of a larger entity, and "the reverse side of (a given door)" to refer to that door's other half.

This now means that objects can be added to one side of a door, as in

	A brass knocker is part of the house door.

with some special implications: it will be visible and touchable when the player is on the "house door" side -- that is, standing on the Porch looking in. That's the easy part. The trickier part is that it will also be visible and touchable when the player is in the Living Room, if the porch door/house door combo is open.

Section: A Warning

This does require a little authorial self-discipline. If you have a place in your code where you say

	now the gilded door is open;

that doesn't ensure that its other half is open. Instead, Deluxe Doors provides a couple of phrases to use instead:

	safely lock the gilded door
	safely open the gilded door
	safely close the gilded door
	safely unlock the gilded door

Using these will guarantee that both halves of a door will be maintained in their proper configuration.

Chapter: Latched Doors

Section: Setting Up

The latched door features here can be used without the Deluxe Doors at all, if we like. A latched door is defined to be one that has a latch and thus can be opened without a key (and will in fact give an error message if the player tries to use a key instead). We can just write

	The porch door is a latched door.

to invoke this; every latched door will automatically have one door-latch object assigned to it.

Chapter: Change Log

4.0.1 updated "Denise" example for 10.1+ compatibility


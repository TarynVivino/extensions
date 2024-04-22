Inform 7 allows the connections between rooms to be modified during play, but doors never change. This extension makes doors as versatile as rooms.

Section: Basic moving

A door connects at most two rooms. A room may have an associated direction; if it does not, the door is one-sided and does not appear in that room. The following phrase takes connects two rooms with a door, and makes the door accessible from two directions.

	move the portal to north of the Antechamber and east of the Narrow Ledge;

We can set a direction to nothing to make a one-sided door:

	move the portal to north of the Antechamber and nothing from the Lava Pit;

The "preserving routes" option moves the door but does not remove the old connection. At the end of this example, the Sloping Canyon is still accessible from the Echoing Cavern, though not by the door:

	move the tunnel-drilling door to north of the Echoing Cavern and south of the Sloping Canyon;
	move the tunnel-drilling door to west of the Echoing Cavern and east of the Pit Room, preserving routes;

Section: Finer controls

If we want to keep some of the rooms or directions the same and change others, the "move" phrase is overkill. Instead, we can use the "replace" phrase. These examples assume the following set-up:

	The chute is a door. It is east of the Cargo Bay.

To change the direction to exit the Cargo Bay:

	replace east in the chute with north;

If a room and a direction are both nothing (as they are in the chute, a one-sided door), the phrase will still do the right thing:

	replace nothing in the chute with the Back of Truck;
	replace nothing in the chute with south;

We can use the "on the opposite side" option to replace the room/direction on the opposite of the door from the one specified. This example has exactly the same effect as the previous one:

	replace the Cargo Bay in the chute with the Back of Truck, on the opposite side;
	replace east in the chute with south, on the opposite side;

The "preserving routes" option works with this phrase too.

Section: Searching a door

We can get the rooms and directions of a door, provided we already know one:

	let O be the room matching east in the blast door;
	let O be the room matching Munitions Depot in the blast door, on the opposite side;
	let O be the direction matching the Docks in the gangplank;
	let O be the room matching nothing in the slippery slide;

If we don't care what the value is, provided it is not nothing, we can use:

	if Cargo Bay is matched in the chute, say "This text will appear.";
	if northwest is matched in the chute, say "This text will not appear.";

Section: Removing a door

There are two ways to remove a door from play:

	now the trapdoor is nowhere;
	remove the trapdoor from play;

The second way can take the "preserving routes" option:

	Instead of attacking the rotten door:
		remove the rotten door from play, preserving routes;
		say "[The rotten door] falls to pieces."


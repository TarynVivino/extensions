With this extension, you can easily create and destroy new rooms during play. While this is also possible with Tara McGrew's "Dynamic Objects," the method here is a little easier for authors, customized for rooms, and available for both z-code and Glulx.

The extension works by creating a reserve of empty rooms when the game first begins and swapping them in and out as needed. The author must declare the maximum number of dynamic rooms that will be needed:

	There are 50 dynamic rooms.

This statement should appear *after* you define your initial starting room (unless you explicitly move the player when play begins). Also note that you can only define 100 duplicates at once; so if you needed 200 dynamic rooms, you'd need something like this (note, however, that performance may suffer with large numbers of dynamic rooms):

	There are 100 dynamic rooms. There are 100 dynamic rooms.

Before creating a new room, you need to check whether there are any unused rooms left. You can use the phrase:

	if out of dynamic rooms:

Or perform more elaborate calculations by checking the number of:

	available dynamic rooms
	used dynamic rooms

To create a new room, you must give it a printed name and assign it to an object variable:

	let excavation be a newly created room with name "Cave";
	
To destroy a dynamic room:

	dissolve excavation;

This will remove any map connections to or from the room, un-name it, and return it to the pool of available dynamic rooms.

By default, a newborn dynamic room will have no entrances or exits. For convenience, you can instead create a room with a reciprocal exit connecting to any existing location via the shortcut phrase:

	let excavation be a newly created room east of location with name "Cave";

Note that Inform's concept of rooms does not position them in a spatial grid; it's perfectly possible to make a hallway that loops back on itself or other spatial impossibilities. If you want to limit newly created rooms to a standard grid system and avoid allowing new rooms to be placed at the same spatial location as existing rooms, you can use the variation:

	let excavation be a newly created positioned room east of location with name "Cave";
	
You'll also need to establish grid coordinates for any rooms your dynamic rooms can connect to:

	When play begins: locate End of the Tunnel at xyz {0, 0, 0}.
	
Now the extension can automatically track the X/Y/Z coordinates of new dynamic rooms (where the x-axis is east/west, y is north/south, and z is up/down) and prevent them from overlapping each other. Note that you should probably disallow rooms created in "inside" or "outside" directions for this to work, and if your game features non-standard directions you'll have to extend the Table of Direction Map Positioning (open up the extension code to see how to do this).

As a shortcut to defining coordinates for multiple existing rooms, you can simply give a single seed location a coordinate and then relatively position all connected rooms:

	When play begins: locate End of the Tunnel at xyz {0, 0, 0}; assign xyz coordinates based on End of the Tunnel.
	
...which would locate a room south of End of the Tunnel at {0, -1, 0}, and so on. This works best with relatively small areas; with larger maps this might cause the z-machine to run out of memory. Switching to Glulx should solve the problem.

A few other points about positioned rooms: you can set numerical edges for how far they can extend along certain directions by setting the values of the minimum-map-x and maximum-map-x variables (and their y and z counterparts). You can add more complicated restrictions on when new connections can be made by adding rules to the "validating a map connection" rulebook, which should fail if the connection is disallowed or decide on an existing room if it should connect to it.

Finally, if any of the newly created room phrases are unable to assign a new room for whatever reason, they will return the room you requested the connection to be made from instead-- in some cases it might be useful to check that these values are not the same before proceeding.


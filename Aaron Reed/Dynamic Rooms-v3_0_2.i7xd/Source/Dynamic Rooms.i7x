Version 3.0.2 of Dynamic Rooms by Aaron Reed begins here.

"Lets new rooms be created on the fly."

[History:
 -- Version 3: Added positioned rooms which keep track of their coordinates in 3D space.
 -- Version 2: Updated to use no deprecated features.
]


Chapter - Adding/Removing Rooms

Section - Initialization

A dynamic room is a kind of room.

The unformed room list is a list of objects that varies.

First when play begins (this is the Dynamic Rooms initialization rule):
	now the unformed room list is the list of dynamic rooms.

Section - Utility

To decide what number is available dynamic rooms:
	decide on the number of entries in the unformed room list.

To decide what number is used dynamic rooms: decide on the number of dynamic rooms - the number of entries in the unformed room list.

To decide whether out of dynamic rooms:
	if available dynamic rooms is 0, decide yes;
	decide no.


Section - Creating a room

To decide which object is a newly created room with name (new name - some text):
	if out of dynamic rooms, decide on location;
	let selected be entry 1 in the unformed room list;
	now the printed name of selected is new name;
	remove selected from unformed room list;
	decide on selected.

To decide which object is a newly created room (dir - a direction) of/from (place - a room) with name (new name - some text):
	let excavation be a newly created room with name new name;
	change dir exit of place to excavation;
	change ( opposite of dir ) exit of excavation to place;
	decide on excavation.


Section - Deleting a room

To dissolve (rm - a room):
	now printed name of rm is "room";
	now description of rm is "";
	repeat with dir running through directions:
		if the room dir from rm is a room:
			change ( opposite of dir ) exit of ( the room dir from rm ) to nothing;
			change dir exit of rm to nothing;
	add rm to the unformed room list, if absent.
	
Chapter - Tracking Room Locations

Section - Coordinates

A room is either present in the coordinate system or absent from the coordinate system. A room is usually absent from the coordinate system.

Every room has a number called the x-coordinate. The x-coordinate of a room is usually 0.
Every room has a number called the y-coordinate. The y-coordinate of a room is usually 0.
Every room has a number called the z-coordinate. The z-coordinate of a room is usually 0.

The maximum-map-x is a number that varies. The maximum-map-x is usually 10000.
The maximum-map-y is a number that varies. The maximum-map-y is usually 10000.
The maximum-map-z is a number that varies. The maximum-map-z is usually 10000.
The minimum-map-x is a number that varies. The minimum-map-x is usually -10000.
The minimum-map-y is a number that varies. The minimum-map-y is usually -10000.
The minimum-map-z is a number that varies. The minimum-map-z is usually -10000.

Section - Mapping Directions to Coordinates

Table of Direction Map Positioning
basedir	map-x	map-y	map-z
north	0	1	0
northeast	1	1	0
east	1	0	0
southeast	1	-1	0
south	0	-1	0
southwest	-1	-1	0
west	-1	0	0
northwest	-1	1	0
up	0	0	1
down	0	0	-1

Definition: a direction is coordinate compatible if it is north or it is northeast or it is east or it is southeast or it is south or it is southwest or it is west or it is northwest or it is up or it is down.	

Section - Utility Functions

To locate (place - a room) at xyz (xyz - a list of numbers):
	now x-coordinate of place is entry 1 of xyz;
	now y-coordinate of place is entry 2 of xyz;
	now z-coordinate of place is entry 3 of xyz;
	now place is present in the coordinate system.
	
To assign xyz coordinates based on (place - a room):
	repeat with dir running through coordinate compatible directions:
		let next room be the room dir of place;
		if next room is a room and next room is absent from the coordinate system:
			let next coordinates be the coordinate set dir of place;
			locate next room at xyz next coordinates;
			assign xyz coordinates based on next room.

To decide what list of numbers is the coordinate set (dir - a direction) of (place - a room):
	let x-target be x-coordinate of place;
	let y-target be y-coordinate of place;
	let z-target be z-coordinate of place;
	if there is a basedir of dir in Table of Direction Map Positioning:
		choose row with a basedir of dir in Table of Direction Map Positioning;
		increase x-target by map-x entry;
		increase y-target by map-y entry;
		increase z-target by map-z entry;
	let target be a list of numbers;
	add x-target to target;
	add y-target to target;
	add z-target to target;
	decide on target.	

To decide which room is the room positioned at coordinates (xyz - a list of numbers):
	repeat with candidate running through rooms which are present in the coordinate system:
		if x-coordinate of candidate is entry 1 of xyz and y-coordinate of candidate is entry 2 of xyz and z-coordinate of candidate is entry 3 of xyz:
			decide on candidate;
	decide on map vector origin.

Section - The Validating a map connection rulebook

Validating a map connection is a rulebook producing a room. 
The map vector origin is a room that varies. The map vector direction is a direction that varies.
Destination coordinates is a list of numbers that varies. The destination coordinates is {0, 0, 0}.
To decide what number is x of destination coordinates: decide on entry 1 of destination coordinates.
To decide what number is y of destination coordinates: decide on entry 2 of destination coordinates.
To decide what number is z of destination coordinates: decide on entry 3 of destination coordinates.

Section - Built-in validating a map connection rules

First validating a map connection rule (this is the set destination coordinates rule):
	if map vector origin is absent from the coordinate system, rule fails;
	now destination coordinates is the coordinate set map vector direction of map vector origin.

A validating a map connection rule (this is the check for an existing room at those coordinates rule):
	let candidate be the room positioned at coordinates destination coordinates;
	if candidate is not map vector origin, rule succeeds with result candidate.
	
A validating a map connection rule (this is the check for sufficient dynamic rooms rule):
	if out of dynamic rooms, rule fails.

A validating a map connection rule (this is the check coordinate bounds rule):
	if x of destination coordinates > maximum-map-x or x of destination coordinates < minimum-map-x or
	y of destination coordinates > maximum-map-y or y of destination coordinates < minimum-map-y or
	z of destination coordinates > maximum-map-z or z of destination coordinates < minimum-map-z,
		rule fails.

Last validating a map connection rule (this is the create a new dynamic room rule):
	let excavation be entry 1 in the unformed room list;
	remove excavation from unformed room list;
	locate excavation at xyz destination coordinates;
	rule succeeds with result excavation.

Section - Creating a new positioned room

To decide which object is a newly created positioned room (dir - a direction) of/from (place - a room) with name (new name - some text):
	now the map vector origin is place;
	now the map vector direction is dir;
	let room counter be available dynamic rooms;
	let excavation be the room produced by the validating a map connection rules;
	if excavation is not nothing:
		if available dynamic rooms < room counter:
			now the printed name of excavation is new name;
		change map vector direction exit of map vector origin to excavation;
		change ( opposite of map vector direction ) exit of excavation to map vector origin;	
		decide on excavation;
	decide on place.

Section - Testing

Coordinate testing is an action applying to nothing. Understand "coord" as coordinate testing.

coord-test-on is a truth state variable.
Carry out coordinate testing:
	now coord-test-on is true.
	
Every turn when coord-test-on is true: say "-->Coordinates of this location: [bracket][if location is present in the coordinate system][x-coordinate of location], [y-coordinate of location], [z-coordinate of location][otherwise]absent from the coordinate system[end if][close bracket]."


Dynamic Rooms ends here.

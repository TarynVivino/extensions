Version 6.0.1 of Transit System by Emily Short begins here.

"Transit System provides a train-car kind which follows a schedule around the map, allowing the player or other characters to get on or off."

Section 1 - Train Cars

Transitional Location is a room.

A train-car is a kind of container. A train-car is usually lit.

A train-car is always openable and enterable. A train-car has a table-name called the t-schedule. A train-car has a time called the waiting duration. 

A train-car has a time called the next-departure. A train-car has a time called the next-arrival. A train-car has a room called the next stop. A train-car has a number called stop number. [These are for bookkeeping and should not be set by the author.]

A train-car can be relatively-scheduled or absolutely-scheduled.
A train-car can be functional or off-line. A train-car is usually functional.

A train-car-door is a kind of thing.

The printed name of a train-car-door is "door". Understand "door" or "doors" as a train-car-door. One train-car-door is part of every train-car. 

Instead of opening or closing a train-car (this is the refusal to open while in motion rule): 
	say "[We] [can't] operate the door [ourselves]. [It's] a safety precaution." (A)

Instead of opening or closing a train-car-door (called target) (this is the redirect opening of car doors rule): 
	let surroundings be a random train-car;
	try opening the surroundings.

Every turn (this is the assess train-car movement rule):
	repeat with item running through functional train-cars:
		if the next-departure of the item is the time of day,
			carry out the setting in motion activity with the item;
		if the next-arrival of the item is the time of day,
			carry out the stopping at station activity with the item.

Setting in motion something is an activity.
Stopping at station something is an activity.

Rule for printing room description details of a train-car (this is the avoid mentioning car emptiness rule):
	do nothing instead.

After printing the name of a train-car (this is the avoid mentioning enclosed passengers rule):
	omit contents in listing.

After deciding the scope of the player when the player is enclosed by a closed train-car (called the relevant car) (this is the recognize doors rule):
	let the relevant door be a random train-car-door which is part of the relevant car;
	place the relevant door in scope.

Section 2 - Starting Relatively-scheduled cars

Rule for setting in motion a functional relatively-scheduled train-car (called relevant car) (this is the starting relatively-scheduled cars rule):
	increase the stop number of the relevant car by 1; 
	if the stop number of the relevant car is greater than the number of rows in the t-schedule of the relevant car, now the stop number of the relevant car is 1;
	let N be the stop number of the relevant car;
	choose row N in the t-schedule of the relevant car;
	now the next-arrival of the relevant car is the time of day plus the transit time entry;
	now the next stop of the relevant car is the destination entry;
	now the relevant car is in the Transitional Location;

Section 3 - Starting Absolutely-scheduled cars

Rule for setting in motion a functional absolutely-scheduled train-car (called relevant car) (this is the starting absolutely-scheduled cars rule):
	increase the stop number of the relevant car by 1; 
	if the stop number of the relevant car is greater than the number of rows in the t-schedule of the relevant car:
		now the relevant car is off-line;
		rule fails; [absolutely-scheduled cars should not start over again]
	otherwise:
		let N be the stop number of the relevant car;
		choose row N in the t-schedule of the relevant car;
		now the next-arrival of the relevant car is the transit time entry minus one minute;
		now the next stop of the relevant car is the destination entry;
		now the relevant car is in the Transitional Location.

Section 4 - Stopping

Rule for stopping at station a functional train-car (called relevant car) (this is the stopping cars rule):
	move the relevant car to the next stop of the relevant car;
	now the next-departure of the relevant car is the time of day plus the waiting duration of the relevant car;
	increase the next-departure of the relevant car by 1 minute.

Section 5 - Description Features

Before setting in motion a functional train-car (called relevant car) (this is the doors close before departure rule):
	if the player can see the relevant car, carry out the describing closure activity with the relevant car;
	now the relevant car is closed.
	
Before setting in motion a functional train-car (called relevant car) (this is the describe car departure rule):
	if the player can see the relevant car, carry out the describing departure activity with the relevant car.
	
After stopping at station a functional train-car (called relevant car) (this is the report train arrivals rule):
	if the player can see the relevant car, carry out the describing arrival activity with the relevant car.

After stopping at station a functional train-car (called relevant car) (this is the doors open after arrival rule):
	if the player can see the relevant car, carry out the describing opening activity with the relevant car;
	now the relevant car is open. 

After stopping at station an absolutely-scheduled train-car (called relevant car) (this is the note and announce last stops rule):
	if the stop number of the relevant car is not less than the number of rows in the t-schedule of the relevant car:
		carry out the mentioning final stop activity with the relevant car;
		now the relevant car is off-line.

Describing departure of something is an activity.
Describing arrival of something is an activity.
Describing opening of something is an activity.
Describing closure of something is an activity.
Mentioning final stop of something is an activity.

To start is a verb. To set is a verb. To stop is a verb. To pull is a verb.

Rule for describing departure of a train-car (called the relevant car) (this is the standard departure-report rule): 
	if the player is enclosed by the relevant car, say "[The relevant car] [start] moving again." (A);
	otherwise say "[The relevant car] [set] off." (B);

Rule for describing arrival of a train-car (called the relevant car) (this is the standard arrival-report rule):
	if the player is enclosed by the relevant car, say "[The relevant car] [stop] at [the holder of the relevant car]. [run paragraph on]" (A);
	otherwise say "[The relevant car] [pull] up. [run paragraph on]" (B);

Rule for describing opening of a train-car (called the relevant car) (this is the standard door-opening-report rule): 
	say "[regarding nothing]The door [open].[paragraph break]" (A);

Rule for describing closure of a train-car (called the relevant car) (this is the standard door-closing-report rule):
	say "[regarding nothing]The door [if the player is not in the relevant car]of [the relevant car] [end if][close].[paragraph break]" (A);

Rule for mentioning final stop of a train-car (called the relevant car) (this is the standard final-stop-report rule):
	if the player is in the relevant car, say "[regarding nothing]This [are] the final station stop for [the relevant car]." (A);

Section 6 - Sample Table

[This is included so that the extension will compile when included, even if there are no transit tables defined elsewhere.]

Table of Sample Schedule
transit time	destination
a time	a room

Transit System ends here.

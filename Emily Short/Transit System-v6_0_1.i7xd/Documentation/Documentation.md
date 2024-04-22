Transit System provides a system for trains, buses, ferries, and other vehicles that might make regular stops at different places on the map for the player to mount and dismount. These items must be of the train-car kind, and must provide a table containing their t-schedule, as in

	The COTA bus is a train-car in Starr Avenue. The t-schedule of the COTA bus is the Table of Bus t-schedule.

Schedules have the form of a two-column table such as

	Table of Bus Schedule
	transit time	destination

The content of the t-schedule depends on whether the train-car is relatively-scheduled (in which case it repeatedly follows a t-schedule with fixed durations between stops) or absolutely-scheduled (in which case it arrives at specified times and stops its run when the t-schedule is complete).

A t-schedule for a relatively-scheduled train-car might look like

	Table of Bus Schedule
	transit time	destination
	1 minute	Starr Avenue
	1 minute	Fourth Street
	1 minute	Fifth Street
	1 minute	Ninth Street
	3 minutes	Seventeenth Street
	3 minutes	Ninth Street
	1 minute	Fifth Street
	1 minute	Fourth Street

where "transit time" is the amount of time it takes to move *to* the destination listed in that row.

A t-schedule for an absolutely-scheduled train-car might look like

	Table of Train Schedule
	transit time	destination
	9:01 AM	Boston
	9:07 AM	New York
	9:10 AM	Philadelphia
	9:25 AM	Pittsburgh
	9:45 AM	Chicago

We may also optionally give a train-car a "waiting duration", which is the amount of time it will spend at each stop waiting for people to get on and off. By default, waiting duration is zero, which means that a train-car will arrive at a location and then leave again on the following turn. This may be appropriate for buses but not so much for other kinds of transportation:
	
	The waiting duration of the Virgin Train is 5.
	The waiting duration of the Amtrak Train is 15.
	The waiting duration of the Washington State Ferry is 45.

Note that schedules are assumed to be cyclical, so if we want a bus that goes back and forth along a straight line, we should make the t-schedule double back on itself: see the first example.

Between stops, a train-car is closed and the player is not allowed to leave. This is handled by the refusal to open while in motion rule.

Text about starting and stopping, and the opening and closing of doors, is controlled by five activities:

	Describing departure of something is an activity.
	Describing arrival of something is an activity.
	Describing opening of something is an activity.
	Describing closure of something is an activity.
	Mentioning final stop of something is an activity.

So if we want to change the way something arrives -- or just how it arrives at a specific place -- we can write a rule for this. For instance:

	Rule for describing arrival of the COTA bus when the COTA bus is in Fourth Street:
		if the player is in the COTA bus, say "[The COTA bus] comes to an abrupt halt at Fourth Street, splashing muddy water all over the curb. [run paragraph on]";
		otherwise say "[The COTA bus] pulls up suddenly and hard in a puddle. You are now dripping wet. [run paragraph on]".

The other four activities do not need "run paragraph on": it is included in this one because by default we construct a paragraph that consists of the arrival message followed immediately by the message that the doors are opening; this one would produce

	The COTA bus comes to an abrupt halt at Fourth Street, splashing muddy water all over the curb. The doors open

as output. For all other cases, the activity output should be text ending with a full stop, as usual.


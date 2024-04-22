Version 10.1.2 of Scheduled Activities by John Clemens begins here.

"An extension to allow scheduling of activities."

Section 1 - Scheduling Rule

Table of Scheduled Events
SA_Moment	SA_Turn	SA_Event	SA_Object_Event		SA_Target		SA_Similar
a time	a number	an activity on nothing	an activity on objects		an object		a number
with 49 blank rows

This is the scheduled events rule:
	check skipped events;
	now stored_preceding is 0;
	repeat through the Table of Scheduled Events:
		if (there is a SA_Moment entry and the SA_Moment entry is time of day) or (there is a SA_Turn entry and the SA_Turn entry is turn count):
			if there is a SA_Similar entry and SA_Similar entry is 1:
				 now stored_preceding is 2;
			otherwise:
				if there is a SA_Event entry, mark SA_Event entry activities;
				otherwise mark SA_Object_Event entry activities;
			if there is a SA_Target entry, carry out the SA_Object_Event entry activity with the SA_Target entry;
			otherwise carry out the SA_Event entry activity; 
			if a paragraph break is pending, say conditional paragraph break;
			now stored_preceding is 1;
			blank out the whole row;
	unmark similar entries.

The scheduled events rule is listed before the timed events rule in the turn sequence rules.


Section 2 - Utility functions - unindexed

The stored_preceding is a number that varies. The stored_preceding is 0.
 
[ 0: first activity this turn, 1 : some activity precedes, 2: same activity precedes]

To mark (E - activity) activities:
	repeat through the Table of Scheduled Events:
		if the SA_Event entry is E, now the SA_Similar entry is 1.

To mark (E - activity on objects) activities:
	repeat through the Table of Scheduled Events:
		if the SA_Object_Event entry is E, now the SA_Similar entry is 1.


To unmark similar entries:
	repeat through the Table of Scheduled Events:
		now the SA_Similar entry is 0.

[ The next check is done to account for time advancements of more than one minute. ]

To check skipped events:
	unless skipped events, rule succeeds;
	while skipped events:
		repeat through the Table of Scheduled Events in SA_Moment order:
			if there is a SA_Target entry, carry out the SA_Object_Event entry activity with the SA_Target entry;
			otherwise carry out the SA_Event entry activity;
			if a paragraph break is pending, say conditional paragraph break;
			blank out the whole row.
	
To decide if skipped events:
	repeat through the Table of Scheduled Events:
		if there is a SA_Moment entry and the SA_Moment entry is before the time of day and 30 minutes after the SA_Moment entry is after the time of day, decide yes;
	decide no.


Section 3 - Scheduling activities

To schedule (E - activity on objects) for/on/with (T - object) at (M - time):
	if the number of blank rows in the Table of Scheduled Events is 0, rule fails;
	choose a blank row in the Table of Scheduled Events;
	now the SA_Moment entry is M;
	now the SA_Object_Event entry is E;
	now the SA_Target entry is T.

To schedule (E - activity) at (M - time):
	if the number of blank rows in the Table of Scheduled Events is 0, rule fails;
	choose a blank row in the Table of Scheduled Events;
	now the SA_Moment entry is M;
	now the SA_Event entry is E.

To schedule (E - activity on objects) for/on/with (T - object) in/on/after (n - number) minutes: 
	schedule E for T at n minutes after the time of day.

To schedule (E - activity) in/after (n - number) minute/minutes: 
	schedule E at n minutes after the time of day.

To schedule (E - activity on objects) for/on/with (T - object) now: 
	schedule E for T at the time of day.

To schedule (E - activity) now: 
	schedule E at the time of day.

To schedule (E - activity on objects) for/on/with (T - object) in/on/after (d - number) turn/turns:
	if the number of blank rows in the Table of Scheduled Events is 0, rule fails;
	choose a blank row in the Table of Scheduled Events;
	now the SA_Turn entry is turn count + d;
	now the SA_Object_Event entry is E;
	now the SA_Target entry is T.

To schedule (E - activity) in/on/after (d - number) turn/turns:
	if the number of blank rows in the Table of Scheduled Events is 0, rule fails;
	choose a blank row in the Table of Scheduled Events;
	now the SA_Turn entry is turn count + d;
	now the SA_Event entry is E;

To schedule (E - activity on objects) for/of/with (T - object) in/at/for (d - number) turn/turns from now:
	schedule E for T in d turns.

To schedule (E - activity) in (d - number) turn/turns from now:
	schedule E in d minutes.

Section 4 - Scheduling activities on descriptions of objects

To schedule (E - activity on objects) in (n - number) minute/minutes for (C - description of objects): 
	repeat with T running through C begin; schedule E for T in n minutes; end repeat.

To schedule (E - activity on objects) in (d - number) turn/turns for (C - description of objects):
	repeat with T running through C begin; schedule E for T in d turns; end repeat.

To schedule (E - activity on objects) in (d - number) turn/turns from now for (C - description of objects):
	repeat with T running through C begin; schedule E for T in d turns; end repeat.

Section 5 - Canceling activities

To cancel all scheduled events for/on/with (T - object):
	repeat through the Table of Scheduled Events:
		if there is a SA_Target entry and the SA_Target entry is T, blank out the whole row.

To cancel all scheduled events:
	repeat through the Table of Scheduled Events:
		blank out the whole row.

To cancel next timed event for/on/with (T - object):
	repeat through the Table of Scheduled Events in SA_Moment order:
		if there is a SA_Target entry and SA_Target entry is T:
			blank out the whole row;
			rule succeeds.
		
To cancel next timed event:
	repeat through the Table of Scheduled Events in SA_Moment order:
		blank out the whole row;
		rule succeeds.

To cancel all scheduled (E - activity):
	repeat through the Table of Scheduled Events:
		if there is an SA_Event entry and the SA_Event entry is E, blank out the whole row.

To cancel all scheduled (E - activity on objects):
	repeat through the Table of Scheduled Events:
		if there is an SA_Object_Event entry and the SA_Object_Event entry is E, blank out the whole row.

To cancel all scheduled (E - activity on objects) for/on/with (T - object):
	repeat through the Table of Scheduled Events:
		if there is a SA_Target entry and the SA_Target entry is T and there is an SA_Object_Event entry and the SA_Object_Event entry is E, blank out the whole row.

To cancel all scheduled events at (M - time):
	repeat through the Table of Scheduled Events:
		if there is a SA_Moment entry and the SA_Moment entry is M, blank out the whole row.

To cancel all scheduled events for/on/with (T - object) at (M - time):
	repeat through the Table of Scheduled Events:
		if there is a SA_Target entry and the SA_Target entry is T and there is a SA_Moment entry and the SA_Moment entry is M, blank out the whole row.


Section 6 - Checking activities

To decide if there is an event scheduled:
	if the number of filled rows in the Table of Scheduled Events is 0, decide no;
	decide yes.

To decide if there is an event scheduled for/on/with (T - object):
	if there is a SA_Target of T in the Table of Scheduled Events, decide yes;
	decide no.

To decide if there is (E - activity on objects) scheduled for/on/with (T - object):
	repeat through the Table of Scheduled Events:
		if there is a SA_Target entry and the SA_Target entry is T and there is an SA_Object_Event entry and the SA_Object_Event entry is E, decide yes;
	decide no.

To decide if there is (E - activity) scheduled:
	if there is an SA_Event of E in the Table of Scheduled Events, decide yes;
	decide no.

To decide if there is (E - activity on objects) scheduled:
	if there is an SA_Object_Event of E in the Table of Scheduled Events, decide yes;
	decide no.

To decide if there is an event scheduled at (M - time):
	if there is a SA_Moment of M in the Table of Scheduled Events, decide yes;
	decide no.

To decide if there is an event scheduled for/on/with (T - object) at (M - time):
	repeat through the Table of Scheduled Events:
		if there is a SA_Target entry and the SA_Target entry is T and there is a SA_Moment entry and the SA_Moment entry is M, decide yes;
	decide no.

To decide if there is (E - activity) scheduled at (M - time):
	repeat through the Table of Scheduled Events:
		if there is a SA_Moment entry and the SA_Moment entry is M and there is an SA_Event entry and the SA_Event entry is E, decide yes;
	decide no.

To decide if there is (E - activity on objects) scheduled at (M - time):
	repeat through the Table of Scheduled Events:
		if there is a SA_Moment entry and the SA_Moment entry is M and there is an SA_Object_Event entry and the SA_Object_Event entry is E, decide yes;
	decide no.


To decide if there is (E - activity on objects) scheduled for/on/with (T - object) at (M - time):
	repeat through the Table of Scheduled Events:
		if there is a SA_Target entry and the SA_Target entry is T and there is an SA_Object_Event entry and the SA_Object_Event entry is E and there is a SA_Moment entry and the SA_Moment entry is M, decide yes;
	decide no.

To decide if there is an event scheduled now:
	repeat through the Table of Scheduled Events:
		if (there is a SA_Moment entry and the SA_Moment entry is time of day) or (there is a SA_Turn entry and the SA_Turn entry is turn count), decide yes;
	decide no.
	
To decide if there is (E - activity) scheduled now:
	repeat through the Table of Scheduled Events:
		if there is an SA_Event entry and the SA_Event entry is E:
			if (there is a SA_Moment entry and the SA_Moment entry is time of day) or (there is a SA_Turn entry and the SA_Turn entry is turn count), decide yes;
	decide no.

To decide if there is (E - activity on objects) scheduled now:
	repeat through the Table of Scheduled Events:
		if there is an SA_Object_Event entry and the SA_Object_Event entry is E:
			if (there is a SA_Moment entry and the SA_Moment entry is time of day) or (there is a SA_Turn entry and the SA_Turn entry is turn count), decide yes;
	decide no.

To decide if there is an event scheduled for/on/with (T - object) now:
	repeat through the Table of Scheduled Events:
		if there is a SA_Target entry and the SA_Target entry is T:
			if (there is a SA_Moment entry and the SA_Moment entry is time of day) or (there is a SA_Turn entry and the SA_Turn entry is turn count), decide yes;
	decide no.
	
To decide if there is (E - activity on objects) scheduled for/on/with (T - object) now:
	repeat through the Table of Scheduled Events:
		if there is an SA_Object_Event entry and the SA_Object_Event entry is E and there is a SA_Target entry and the SA_Target entry is T:
			if (there is a SA_Moment entry and the SA_Moment entry is time of day) or (there is a SA_Turn entry and the SA_Turn entry is turn count), decide yes;
	decide no. 

Section 7 - Reporting activities

To decide if first current activity:
	if stored_preceding is 0, decide yes;
	decide no.

To decide if first similar activity:
	if stored_preceding is 2, decide no;
	decide yes.

Pending relates an object (called T) to an activity on objects (called E) when there is E scheduled for T now.
The verb to be pending implies the pending relation.

Section 8 - Phrases for descriptions

To schedule (E - activity on objects) at (M - time) for/on/with (C - description of objects):
	repeat with T running through C begin; schedule E for T at M; end repeat;

To schedule (E - activity on objects) in (n - number) minutes for/on/with (C - description of objects): 
	repeat with T running through C begin; schedule E for T in n minutes; end repeat.

To schedule (E - activity on objects) now for/on/with (C - description of objects): 
	repeat with T running through C begin; schedule E for T at the time of day; end repeat.

To schedule (E - activity on objects) in (d - number) turns for/on/with (C - description of objects):
	repeat with T running through C begin; schedule E for T in d turns; end repeat.

To cancel all scheduled events for/on/with (C - description of objects):
	repeat with T running through C begin; cancel all scheduled events for T; end repeat.

To cancel all scheduled (E - activity on objects) for/on/with (C - description of objects):
	repeat with T running through C begin; cancel all scheduled E for T; end repeat.
	
To decide if there is an event scheduled for/on/with (C - description of objects):
	repeat through the Table of Scheduled Events:
		if there is a SA_Target entry and the SA_Target entry matches C, decide yes;
	decide no.
	
To decide if there is (E - activity on objects) scheduled for/on/with (C - description of objects):
	repeat through the Table of Scheduled Events:
		if there is a SA_Target entry and the SA_Target entry matches C and there is an SA_Event entry and the SA_Event entry is E, decide yes;
	decide no.
	
To decide if there is an event scheduled now for/on/with (C - description of objects):
	repeat through the Table of Scheduled Events:
		if there is a SA_Target entry and the SA_Target entry matches C:
			if (there is a SA_Moment entry and the SA_Moment entry is time of day) or (there is a SA_Turn entry and the SA_Turn entry is turn count), decide yes;
	decide no.
	
To decide if there is (E - activity on objects) scheduled now for/on/with (C - description of objects):
	repeat through the Table of Scheduled Events:
		if there is an SA_Event entry and the SA_Event entry is E and there is a SA_Target entry and the SA_Target entry matches C:
			if (there is a SA_Moment entry and the SA_Moment entry is time of day) or (there is a SA_Turn entry and the SA_Turn entry is turn count), decide yes;
	decide no.


Scheduled Activities ends here.

This extension allows activities to be scheduled at absolute and relative times. These activities may later be checked or cancelled. The advantage of this over the standard events is that activities may take a variable, and the same activity may be scheduled multiple times. Rudimentary support is also provided for grouping output of multiple activities scheduled for the same turn. The extension only allows for activities which are applied to objects or to nothing (i.e., it does not allow activities applied to other kinds of value).

Scheduled activities are stored in a table called the Table of Scheduled Events. This table initially holds 50 future activities; if more storage is needed, you can add a table continuation as follows:
	Table of Scheduled Events (continued)
	SA_Moment	SA_Turn	SA_Event	SA_Object_Event	SA_Target	SA_Similar
	a time	a number	an activity on nothing	an activity on objects	an object	a number
	with 100 blank rows

A new rule (the scheduled events rule) is inserted before the timed events rule (the rule which handles the usual timed events). So scheduled activities will occur immediately before events invoked with phrases like "the egg-timer clucks in four turns from now".

SCHEDULING: The extension provides the following phrases to schedule activities:
	schedule (an activity) for (an object) at (a time)
	schedule (an activity) at (a time)
	schedule (an activity) for (an object) in (a number) minutes
	schedule (an activity) in (a number) minutes
	schedule (an activity) for (an object) now
	schedule (an activity) now
	schedule (an activity) for (an object) in (a number) turns
	schedule (an activity) in (a number) turns

Here, "now" means at the end of the current turn.

CANCELING: Activities can also be canceled:
	cancel all scheduled events for (an object)
	cancel all scheduled events
	cancel next timed event for (an object)
	cancel next timed event
	cancel all scheduled (an activity)
	cancel all scheduled (an activity) for (an object)
	cancel all scheduled events at (a time)
	cancel all scheduled events for (an object) at (a time)

Note that "next timed event" considers only events scheduled in times, not those scheduled in turns. Also note that only activities scheduled with the phrases above can be canceled or checked in this way.

CHECKING: The following conditions are supplied:
	if there is an event scheduled
	if there is an event scheduled for (an object)
	if there is (an activity) scheduled for (an object)
	if there is (an activity) scheduled
	if there is an event scheduled at (a time)
	if there is an event scheduled for (an object) at (a time)
	if there is (an activity) scheduled at (a time)
	if there is (an activity) scheduled for (an object) at (a time)
	if there is an event scheduled now
	if there is (an activity) scheduled now
	if there is an event scheduled for (an object) now
	if there is (an activity) scheduled for (an object) now

REPORTING: Several conditions allow better reporting of multiple activities happening in the same turn.
	if first current activity

This condition is true when carrying out the first scheduled activity during a given turn.
	if first similar activity

This condition is true when carrying out a particular activity for the first time during a given turn (even if other activities have been carried out). This can be used to combine reports for carrying out the same activity with multiple objects in the same turn; see the example "Bunnies".

Note that these two conditions do not apply to skipped events caused by changing the time directly.

A new relation, the pending relation, is defined between objects and activities when the given activity is scheduled for the object during the current turn. So, for instance, the condition
	if a rabbit is pending waking

will be true if the waking activity is scheduled for some rabbit during the current turn.

DESCRIPTIONS: Several phrases are included allowing object descriptions, so it is possible to say, for instance, "schedule dispersing in 5 turns for everything enclosed by the location." The included phrases are:
	schedule (an activity) at (a time) for (a description)
	schedule (an activity) in (a number) minutes for (a description)
	schedule (an activity) now for (a description)
	schedule (an activity) in (a number) turns for (a description)
	cancel all scheduled events for (a description)
	cancel all scheduled (an activity) for (a description)
	if there is an event scheduled for (a description)
	if there is (an activity) scheduled for (a description)
	if there is an event scheduled now for (a description)
	if there is (an activity) scheduled now for (a description)



Section Changelog

version 10.1.2 2023-07-24 fixing bunnies example -- ZL
version 10.1.1 2023-04-01 removed "for 6M62" from rubric for v10 version

version 10 January 10, 2022
	updated for 6M62 by Zed Lopez

version 9 September 10, 2010
	updated activity types for compatibility with 6E59/6E72 type checking
	minor code cleanup

version 8 (May 11, 2009)
	code cleanup
	more explicit table column names to preclude conflicts
	pending relation now behaves properly again

version 7 (May 8, 2008)
	updated for compatibility with 5T18
	updated documentation
	minor code improvement

version 6 (date forgotten)
	minor compatibility update

version 5 (August 11, 2007)
	Updated for compatibility with 4W37
	changed the Target column to SA_Target to avoid name-space conflict

version 4 (March 26, 2007)
	Updated for compatibility with 4S08
	Pending relation replaced with several phrase for compatibility with 4S08
	Removed use of procedural rule
	Changed skipped events checking to agree with Inform behavior for timed events (processes events less than 30 minutes before time of day)
	Fixed bug to do with checking preceding similar activities

version 3 (October 1, 2006)
	Note: This version requires at least compiler version 3Z95; if you are using an earlier compiler version you should use version 2.
	"Thing" has been changed to "object", so activities can now be scheduled for rooms
	Added phrases utilizing descriptions
	Added example "Perfume"
	Added syntax for "turn", "minute", and "turns from now"
	Updated documentation
	Updated example "Bunnies" for 3Z95
	Minor tidying of code

version 2 (July 19, 2006):
	Improved paragraph breaks between activities
	Added the new syntax: schedule now
	Added reporting conditions: if first current activity and if first similar activity
	Added the pending relation
	Added example "Bunnies"

version 1 (July 15, 2006): Initial version

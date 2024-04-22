
The standard behaviour for Inform 7 is to advance the time of day by one minute for each turn taken. There may be times when we'd like to vary this, perhaps because the player is up against a timed puzzle but we don't want certain actions to count too heavily against that time, or because we don't want our story to reach dawn or dusk too fast. This extension allows us to change the time taken per turn both on a global basis and for individual actions.

The passage of time per turn can be changed by changing the global variable seconds_per_turn (which is 60 by default). E.g. if we wanted two turns per minute, we could define:

	now seconds_per_turn is 30


To make individual actions take something other than this standard time we can use the phrases:

	take n secs/sec/seconds/second
	take n secs/sec/seconds/second  in/-- all/total/only

For example:

	take 3 secs
	take 1 sec
	take 20 secs in all

These phrases can be used in any of the rules relating to the action (or anything used by any of those rules, such as "to" or "to say" phrase).  The difference between the two forms "take n secs" and "take n secs in all" is that the first is additive and the second is not. That means that if an action triggers several rules, and more than one of these rules contains a "take n secs" phrase, the time from each of them will be added to the action, whereas if the phrase "take n secs only" (or one of its variants) is encountered in a rule, then the action will take this number of seconds, the time from previous rules for that action being ignored.

Equivalent to say phrases are also available, e.g.:

	"[3 secs]"
	"[20 secs total]"

This makes it easy to write rules like:

	Instead of taking the delicate vase in the presence of Aunt Veronica:
		say "[2 secs]Aunt Veronica's ferocius glare warns you to leave the vase well alone."

	After dropping the knife:
		say "[1 sec total]The knife falls from your grasp and clatters on the floor."

With all the above phrases, the turn count will still be increased by one. To have no time taken at all and the turn count not advanced, we can use the phrases:

	take no time
	"[no-time]"

This can be especially useful when the response to an action is effectively a refusal to act, and we don't want the refusal to count either against the elapsed time or the turn count. For example:

	Instead of taking Nelson's Column:
		say "[no-time]You lack the strength to lift it."

Or, more generally:

	Check taking something fixed in place: take no time.


Finally the phrase "[sec-time]" can be used to display the time of day in the format hh:mm:ss am/pm, for example:

	{*}When play begins: now the right hand status line is "    [sec-time]";

Note that internally, the variable time of day is still only held to the nearest minute. This extension keeps track of a second variable, called seconds, which is used to decide when the time of day should be advanced.

One further note: where the various phrases defined above have potentially contradictory effects (e.g. take no time and take 5 seconds used on the same turn), it's the last phrase executed that takes effect.


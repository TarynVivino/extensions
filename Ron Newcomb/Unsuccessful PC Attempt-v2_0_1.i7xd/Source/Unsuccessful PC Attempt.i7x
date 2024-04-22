Version 2.0.1 of Unsuccessful PC Attempt by Ron Newcomb begins here.

"Will run the Unsuccessful Attempt By rules for all characters, including the player.  Also silences the library messages printed by the built-in Check rules."

Silent checks is a truth state that varies.  Silent checks is usually true.

This is the modified check stage rule: 
	anonymously follow the specific check rulebook;
	if [that] rule succeeded, [this] rule succeeds; [if a check rule succeeds, it ends action processing but does not call the Unsuccessful Attempt By rules. We mimic that here because it's useful: we can write a Check rule to both say a one-liner and end the action in a single line, and, we can still tell Unsuccessful Attempt to narrate a failed action without needing to ensure a one-line was said by checking The Reason The Action Failed against a list of rules that have one-liners. ]
	if the rule failed begin;
		if the actor is the player, follow the unsuccessful attempt by rules; [ ..will be called for NPCs from the usual place]
		rule fails;
	end if.

To anonymously follow (R - a rule): (- anon_follow({R}); -).

Include (-
[ anon_follow R;
	@push untouchable_silence; 
	untouchable_silence = (+ silent checks +);       ! checked by L__M() and related library functions
	if (reason_the_action_failed = FollowRulebook(R))    ! this sets, then tests, that variable
	{
		if (RulebookSucceeded()) ActRulebookSucceeds(reason_the_action_failed); 
		else ActRulebookFails(reason_the_action_failed); 
	}
	@pull untouchable_silence;  
];
-). 

The modified check stage rule is listed instead of the check stage rule in the specific action-processing rules.

Unsuccessful PC Attempt ends here.


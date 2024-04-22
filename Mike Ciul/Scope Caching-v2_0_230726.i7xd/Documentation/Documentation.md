Optimizes Epistemology by Eric Eve and Remembering by Aaron Reed. I6 code by Andrew Plotkin. Andrew also explained how to pass a phrase as an argument to another phrase for looping.

Section: The Marked Visible Property

Scope Caching creates a property for things called "marked visible." This is equivalent to the "visible" adjective, except it is calculated only at specific times and then stored, trading storage space for speed.

These conditions:

	the player can see the ball

	the ball is visible

Will normally mean the same as:

	the ball is marked visible

Section: The Caching Scope Activity

If circumstances change during a turn and we need to check scope again, or if we want to check scope for something other than the player, we need to refresh the cache. We can do this with the "caching scope" activity:

	Before Bob trying doing something:
		carry out the caching scope activity with Bob

This will, of course, leave the "marked visible" property set for Bob, so if we need to check the player's scope again, we need to run the phrase an additional time.

Section: The Cache Scope After Reading a Command Rule

This is the rule which normally sets the "marked visible" property each turn:

	After reading a command (this is the cache scope after reading a command rule):
		carry out the caching scope activity with the player.

It's listed first in the "after reading a command" rulebook, so other "after reading a command" rules should be able to make use of the "marked visible" property.

Section: When the Visibility of One Thing Depends On Another

Perhaps this sort of test will always be tricky, but the way scope is implemented in Inform seems to make it particularly so. We must take pains to perform the visibility test at the right time:

	After deciding the scope of the player when not caching scope:
		If no nose is marked visible:
			place your nose in scope;
			now your nose is marked visible.

Scope caching normally happens before any parsing begins, so any noses present will be marked before this rule sees them. The "deciding the scope" activity does run during parsing (often several times), we will get what we want, when we want it. But we must manually make your nose "marked visible" because caching scope is obviously not taking place! We might choose not to do that if we had multiple grammar lines depending on the same rule.

Section: Trusting The Scope Cache

If we know for a fact that nothing will change until next turn, we can speed things up a bit by saying:

	Trust the scope cache until next turn.

This will suppress scope caching after reading a command on the next turn.

If we change our minds later in the turn, we can say:

	Mistrust the scope cache.

And things will be back to normal.

Section: Interactions with Other Extensions

Scope Caching optimizes the setting of the "seen" property in Eric Eve's Epistemology and the "remembered location" property in Aaron Reed's "Remembering" extension.

It also interacts with Mike Ciul's Conditional Backdrops extension. After the "moving floating objects" activity takes place, we "trust the scope cache until next turn," on the assumption that going (and other actions that change the landscape of backdrops and doors) will be the only thing that affects scope until next turn. If we discover that this is not the case, we must "mistrust the scope cache" manually:

	After moving floating objects when the Energizer Bunny is on the move (this is the expecting the bunny to move rule):
		mistrust the scope cache;

	The expecting the bunny to move rule is listed after the cache scope after moving floating objects rule in the after moving floating objects rulebook.

Or we could just take care of the scope caching ourselves when the change actually happens:

	Every turn when the bunny is switched on (this is the move the bunny rule):
		Now the bunny is in the next destination of the bunny;
		Cache scope for the player;
		Trust the scope cache until next turn.

Section: Testing Commands

We can use the "scopestat" command to find out what items are currently marked visible. The command by itself will list the items marked visible for the player, while "scopestat [any thing]" will list the items visible for another person.

Section: Changes

Version 2/121127: Expanded "marked visible" to include rooms, directions, and regions. Not explicitly visited in loops, but still necessary if any of those things are added to scope.

Version 2/120725:


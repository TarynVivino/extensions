This is a set of basic plans to go along with Planner.

Text of a demo game follows.


	Section - Custom Actions

	[Asking a person for an object is an alternative plan for getting hold of an object. It's the sort of strategy that would only be appropriate in some genres, so it's not in Basic Plans.]

	Doing-asking-for is a planning-action.

	Planning-acting when the planned action is doing-asking-for:
		try the planning actor trying asking the planned param1 for the planned param2;

	Planning rule when the desired relation is being-touchable-by and the desired param2 is the planning actor and a person (called the owner) encloses the desired param1:
		plan 1;
		suggest being-touchable-by with the owner and the planning actor;
		suggest doing-asking-for with the owner and the desired param1;


	The block giving rule does nothing when the second noun is Bob.


	Section - Custom Messages

	[The 'action success flag' trick we use is a bit of a nasty hack. There is probably a better way to find out if an action succeeds, but I don't know it yet. For the moment we use this, but it only gets set if an 'after' rule runs, which means if we use 'instead' to block the action, we need to set it manually. We should probably have a phrase for this, but it's so ugly there's likely to be a more permanent solution anyway.]

	Instead of Bob trying asking the player for something:
		say "'I say, old chap,' mutters Bob. 'Do be a sport and give me [the second noun].'";
		now the action success flag is 1;

	Planning-failure:
		say "Bob scratches his beard and looks perplexed.";

	Planning-success:
		end the story finally saying "You have witnessed the Making of Soup";

	Planning-acting-failure:
		say "'Arr, that didn't work,' says Bob. 'Reality be getting a mite thin.'";

	Report Bob trying opening the cupboard for the first time:
		say "'Aslan sesameslan!' says Bob, flinging the cupboard doors wide open to reveal [list of things in the cupboard].";
		stop the action;

	[Another nasty hack just to get a nice message when Bob takes something from a container rather than from the room. Must be a better way to do this.]

	The previous take holder is an object that varies.

	Before Bob trying taking something:
		now the previous take holder is the holder of the noun;

	Report Bob trying taking something:
		if the previous take holder is not a room begin;
			say "Bob takes [the noun] from [the previous take holder].";
			stop the action;
		end if;

Section Changelog

Version 3/211124: Bug fixes per [Planner/Basic Plans, NPC actions are invisible IntFiction thread](https://intfiction.org/t/planner-basic-plans-npc-actions-are-invisible/10034/)

Fixed a typo in Alchemy example

Version 3/210620: Include Planner

This extension differs from the author's original version: it has been modified for compatibility with version 6L02 of Inform. The latest version of this extension can be found at <https://github.com/i7/extensions>.

This extension is released under the Creative Commons Attribution licence. Bug reports, feature requests or questions should be made at <https://github.com/i7/extensions/issues>.


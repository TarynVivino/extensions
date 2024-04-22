Derived from (and largely copied and pasted from) Emily Short's extension "Locksmith," Autotaking provides a convenient way for any action to ensure that the noun or the second noun is held before being carried out. It also provides for the "sequential action" output style to be used instead of the default "(first taking the noun)" message.

Whenever we create an action that involves a noun or second noun that must be held, we can invoke the "must hold the noun" rule or the "must hold the second noun" rule:

	Attacking it with is an action applying to two things.

	The must hold the second noun rule is listed first in the check attacking it with rulebook.

This will generate an automatic take if the actor doesn't have the second noun, and the action will be stopped if the autotake fails.

We can also invoke the "noun autotaking" and "second noun autotaking" rules explicitly:

	Check an actor attacking something with something (this is the weapons must be held rule):
		if the actor does not hold the second noun, follow the second noun autotaking rule;
		if the actor does not hold the second noun, stop the action.

By default, automatic taking actions are described as other automatic actions usually are in Inform: the player sees something like "(first taking...)" before he takes an object used in an action. The "Use sequential action" mode is provided for the case where we would prefer to see "Taken." instead.


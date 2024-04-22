A simple extension providing for things out of reach. A check is performed between the Before and Instead phases of the action (more specifically, between "visibility" and "touchability" are performed). The extension provides an adjective, "distant", for inaccessible objects (with antonym "near"). A distant object will be too far away to touch, as will anything it encloses (contents or parts). The appropriate error is printed by the distant stuff rulebook, which can also allow distant stuff to be interacted with, if it wants to, by including new rules.

A circus game might need the following, for example:

	A distant stuff rule when the player is wearing stilts: rule succeeds.

	A distant stuff rule for the safety net when the player is wearing stilts: say "You bought the best stilts you could afford but you're lower than the safety net."; rule fails.

	A distant stuff rule for the trapeze wire when the player is wearing stilts: say "You bought the best stilts you could afford but you're lower than the safety net, let alone the high wire."; rule fails.

The rulebook is called "for" objects (it's an object-based-rulebook) which have been deemed to be too far away, either by being distant themselves or by being enclosed by something distant. "Rule succeeds" indicates the object should not be considered out of reach. "Rule fails" will stop the action in its tracks.
	
Other characters are bound by the same basic rules as the player: if attempting to take an unreachable object the game will respond with the default message "[The person asked] is unable to do that". This can be intercepted either by Before rules:

	Before asking Will to jump over the moon, say "'I'm that happy I could jump over the sun!' Will exclaims rather stupidly."

or by distant stuff rules:

	A distant stuff rule for something enclosed by the top shelf when the person asked is Will:
		say "(Will is six-foot-nine and high-up things are no problem for him.)[line break]";
		rule succeeds.

Note, however, that the Instead entrypoint is too late and the distant check will have already happened.

A rule can decide if it should be saying something when failing by testing "if reporting errors" - this is safer than just printing, as the accessibility rules are also called during visibility checks.

Finally, the game provides the condition "far off" for objects which are considered out of reach - remember, these may be distant, or they may be parts/contents of distant stuff.

Section: Change log

5.2.1 updated for 10.2


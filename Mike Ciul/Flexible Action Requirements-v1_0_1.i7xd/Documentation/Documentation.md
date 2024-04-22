Section: Altering Action Requirements

Some actions in the Standard Rules are described as acting on "one carried thing." If we want to waive those requirements, our only option is to create a new action that doesn't have them. This extension removes that problem by making the carrying requirements more flexible.

In addition, we can now specify touchability requirements in the same level of detail as with carrying requirements. We can also use it to make fine-tuned tests in our own accessibility rules.

Section: Carrying Requirements

To waive the carrying requirements for an action, we can designate it as either of the "flexible about carrying the noun" or "flexible about carrying the second noun" kinds of action.

	Eating is flexible about carrying the noun.
	Unlocking something with the Force is flexible about carrying the second noun.

If that's not fine enough detail, we can add rules to the "custom carrying requirements" rulebook, which is an object-based rulebook. The rulebook has two outcomes, "it must be carried," and "it may be merely visible." If the rulebook makes no decision, we assume there are no carrying requirements.

	Custom carrying requirements for the speck of dust:
		if taking, make no decision;
		If the current action involves the speck of dust, it must be carried.

	Custom carrying requirements for the Force:
		it may be merely visible.

To test the carrying requirements, we can use the "only available when carried" adjective.

	Before doing something when the noun is only available when carried:
		if the noun is not carried:
			say "Sorry, you can't do that when you're not carrying [the noun].";
			stop the action;
		otherwise:
			say "(Good thing you're carrying [the noun] now)[command clarification break]"

All of the built-in custom carrying requirements rules test if the item is "involved," i.e. it is the noun or the second noun. If you create custom carrying requirements rules that decide "it must be carried" for any other objects, you might get unexpected results when using the "only available when carried" adjective. If you must be absolutely sure that the item is both involved AND required for its role in the current action, you can use this to-decide-whether phrase:

	if the golden plough must be carried:

A note on the use of "involved:" If you make use of the phrase "an involved thing," you will be executing a loop over all objects in the game to see which things are involved. To avoid this, you can use the phrase "a (description of objects) must be used" instead, which will be true for all matching items that are involved. You can also obtain "the (description of objects) that must be used," which will return the noun if it matches, or the second noun if it matches but the noun doesn't.

Section: Touchability Requirements

Two similar kinds of action are defined so we can waive touchability requirements for objects: "flexible about touching the noun" and "flexible about touching the second noun."

The adjective "only available when touchable" will tell us if an object is subject to touchability requirements of the current action. And we can make sure it is also involved in the current action using the to-decide-whether phrase "must be touched."

Some phrases to help us are:

	(the item) must be touched

This phrase workes on individual objects as well as descriptions of objects:

e.g.
	if the top of the flagpole must be touched:

or:

	if a container must be touched:

We can also use a description of objects to identify a particular thing that must be touched:

	the (item) that must be touched

Finally, there is an adjective, "required to be touched" that means the same thing. Be careful about using this, though - although it's more flexible than using one of the above phrases, it will loop over all objects in the game every time it is used. If you do that in the preamble of an accessibility rule, that will happen at least once every turn!

A warning about this, though: If you regularly use this adjective or phrase in rule conditions, you're going to spend a lot of time looping over every object in the game just to see if it's involved in the action. Consider looping explicitly over the noun and the second noun instead.

To meddle with touchability requirements further, we may create "custom touchability requirements" rules. The outcomes are called "it must be touchable," and again, "it may be merely visible."

Unlike the carrying requirements modifications, though, there are no built-in changes to accessibility rules. Declaring that
	
	listening is flexible about touching the noun

will not allow us to listen to things that are out of reach. We'd have to define our own rules, perhaps like this:

	Reaching outside (this is the can always reach available when merely visible objects rule):
		unless something must be touched, allow access;

	The can always reach available when merely visible objects rule is listed before the can't reach outside closed containers rule in the reaching outside rules.

Even then, we would still need additional grammar lines or "try" statements to enable the player to perform actions on things that are not in scope.

The main value of the touchability requirements, then, is so we can designate some objects in scope as "too far away" or "too high up:"

	Accessibility rule when the fans must be touched:
		say "The fans are too far away.";
		stop the action;

Section: Notes

Thanks to Troy Jones III and Matt Weiner for inspiring this extension. You may contact Mike Ciul at captainmikee@yahoo.com with bug reports and feedback.


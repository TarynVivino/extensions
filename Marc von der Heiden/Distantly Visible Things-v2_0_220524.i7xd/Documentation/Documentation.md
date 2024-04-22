Distantly Visible Things allows us to implement things that can not only be seen (and referenced by the player) in their actual location, but also in other rooms. The extension provides an easy way to have those things respond differently to the players' command when she references them "from far". This could - for example - be useful if we wanted to design a rather open environment in which the different rooms are not seperated by walls. Unlike backdrops, which are automatically moved around by the game and are mostly used for objects that don't need to be manipulated by the player, distantly visible things retain one distinct location in which they are "physically" in.

Chapter: Standard behavior of the extension

In order to make a thing visible from another room, we use the newly created "Distant visibility" relation which is implied by the verb "to be distantly visible by"

	The huge estate is a room. The street ist south of the estate. The mansion is a thing in the estate. The mansion is distantly visible from the street.

The player can now reference the mansion while she is on the street, so she doesn't get a "You can't see any such thing." response - which would be silly if, for example, we had mentioned it in the description of the street - or if it was otherwise obvious that it should be visible from there.

A thing can be distantly visible from more than one room and a room can have more than one thing in it that is distantly visible. Things that are contained, supported or incorporated in a distantly visible thing will NOT automatically be so too; we have to set the distant visibility relationship for them manually (so making the big marble fountain visible from another room doesn't necessarily mean that the coins inside its basin are also visible from afar).

A thing that's distantly visible is never touchable from another room. If we tried to take it (or perform some other action that required touchability) we will get a standard refusal message that tells the player to go closer to the object and hint her which way to go (if there's a map connection). Even most other actions (such as looking under) will by default be blocked from being done over distance.

The only special case is the Examining action: The extension defines a new property for things, a text called the "distant description". Whenever the player examines a distantly visible thing that has a distant description, this will be printed instead of the refusal message. So with this code:

	The distant description of the mansion is "A beautiful mansion that dates back to the Victorian era.". The description of the mansion is "From up close, the number of cracks in the masonry make the deterioration of the building more than obvious.".

the player will be able to get a good glimpse at the house from the street, but the truth will only be discovered on a closer look.

Chapter: Customizing the mechanics

Although the standard behavior might just meet most of the needs, we can customize some of the features.

Section: Changing the refusal message

The refusal message is printed by an object-based activity called "printing a refusal to distantly handling". The standard behavior is to say...

	You need to get closer to the mansion, which is to the north.

or - if there was no (direct or indirect) map connection - just...

	You need to get closer to the mansion.

As with all activities we can provide additional before, for or after rules. We could try, for example:

	After printing a refusal for distantly handling the house: say "(you'd really like to, but you were raised to respect private property)".

and the house will be subject to our mannerly upbringing.
If we wanted to override the behavior in its entirety, we could replace the "for" rule that comes with the extension (called the standard printing a refusal for distantly handling rule). With the new features of build 6L02 we could also just replace response (A) of this rule. (Now the standard printing a refusal for distantly handling rule response (A) is...)

Section: A new stage in action-processing: the distance visibility rules

Just before the Instead stage, a new rulebook called the distance visibility rules is followed if either the noun or the second noun is distantly visible from the player's location. At this point all actions that would have required a distantly visible thing to be touched will already have been blocked. Initially the new rulebook consists of two rules:

	Distance visibility for Examining (this is the examining distantly visible things rule)

...prints out the "distant description" of the noun if it provides one, otherwise does nothing.

	Last distance visibility rule (this is the block actions with distantly visible things rule)

...prints out the standard refusal message via the aforementioned activity (see last section).

We can add rules to this rulebook freely. If a rule in this rulebook ends with outcome "deny action", the action will be stopped immediately (assuming that a suitable response for the player has been printed); if it ends with outcome "allow action", the action will resume with the Instead stage and we might probably not want to say anything and leave that to action-processing. Out of the box this is never the case.

Examples:

	Distance visibility rule for Looking under the doormat when the key is not handled:
		say "The doormat has a suspicious bulge but you can't exactly see from here what might be under it.";
		deny action.

This rule prints out the response and then stops action processing. (Since "deny action" is the default outcome of this rulebook, the last line is optional.). The standard refusal ("You need to get closer to the doormat...") will not be printed, since the new rule is more specific than the block actions with distantly visible things rule.

	Distance visibility rule for Examining the mansion: allow action.

would make the mansion print its standard description when examined from another room (thus making the distant description for the mansion useless).

Section: Changing the rules for basic accessibility

By default all distantly visible things are never touchable and it is recommended to leave it this way. (They can, of course, be touched in the room they're actually in. They don't count as distantly visible there). This is handled in the

	can't touch distantly visible things rule

which is part of the accessibility rulebook. To alter this behavior we would need to unlist or rewrite this rule and probably meddle with the built-in can't reach inside rooms rule. Handle with care!


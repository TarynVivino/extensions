Chapter: Hiding Under

Section: The Basics

Hiding Under defines a many-to-one relation called "underconcealement" which can be expressed with phrases like:

	The pen is hidden under the desk.
	Now the book is hidden under the bed.
	
The effect of using such phrases is that such objects will the discovered when the player types LOOK UNDER DESK or LOOK UNDER BED. However, to ensure that the pen and book aren't found before then, it is a good idea if they start out as off-stage, since declaring something to be hidden under something else does not define its location in the game world.

If we want to hide something under something else during the course of play, we need to move it off-stage as well, e.g.:

	Now the book is hidden under the bed;
	Remove the book from play.

To do this in a single statement we can use the phrase:

	Hide the book under the bed.


Finally, if items are hidden under something portable, then the items are automatically revealed (and moved to the previous holder of the concealing item) when the concealing item is taken. This might generate a transcipt like:

	>TAKE CHAIR
	Taking the chair reveals a small book and an odd sock hidden underneath.

We can change the final part of this sentence ("hidden underneath") by providing our own definition of the phrase "to say previously-hidden-under (obj - a thing)". E.g.

	To say previously-hidden-under (obj - the chair): say "previously concealed under it".

Which would result in:


	>TAKE CHAIR
	Taking the chair reveals a small book and an odd sock previously concealed under it.

Or we can change the entire response by providing our own definition of "to say reveal-hidden-under (obj - a thing)". E.g.

	To say reveal-hidden-under (obj - the chair):
		say "As you pick up the chair you notice [the list of things hidden under the chair] lying underneath."

Giving us:

	>TAKE CHAIR
	As you pick up the chair you notice the small book and the odd sock lying underneath.


Section: Using Hiding Under Standalone

If Hiding Under is used standalone (i.e. without Underside) it provides only fairly basic functionality. It permits use of the statements discussed above. In addition if we have hidden anything under anything then the command LOOK UNDER WHATEVER will list the items hidden there and move them into the holder of the item looked under (which will normally be the location of the player) so that they become available to the player. These items do not remain hidden under the other object, since the player now knows about them, and, by itself, Hiding Under does not model the space under other objects.

We can change the message that's displayed in response to finding things under other things by providing our own definition of "To say find-hidden-under (obj - a thing)". If we like, we can also arrange for this to result in the player taking what s/he finds (instead of leaving it on the ground); for example:

	To say find-hidden-under (the bed - a thing):
	now everything hidden under the bed is carried by the player;
	say "Under the bed you discover [a list of things hidden under the bed], which you duly take."

Hiding Under also defines the command PUT X UNDER Y or HIDE X UNDER Y (these two mean the same thing, and refer to the placing it under action), which by default just responds with "You can't but anything under the whatever." To allow things to be hidden under other things we can write an instead rule:

	Instead of placing the pen under the bed:
		hide the pen under the bed;
		say "You hide the pen under the bed.";

Or, more generally,

	{*}A thing can be can be underspaced or not underspaced. A thing is usually not underspaced.

	Instead of placing something under something underspaced:
		hide the noun under the second noun;
		say "You hide [the noun] under [the second noun]."

The limitation of this is that the player won't then be able to interact with the object thus hidden until s/he explicitly looks under the object it's hidden under, even though s/he presumably lnows perfectly well that it's there. A second limitation is that there's no automatic check that the first object will fit under the second, and it might start stretching credibility if, say, the player were allowed to place twenty large objects under the same small desk (though we could check for this manually). To get round these problems, we can use the Underside extension.



Section: Using Hiding Under with Underside

Underside does model the space under objects, and Hiding Under will take advantage of this if the two extensions are used together.

In particular, the command LOOK UNDER WHATEVER will move anything hidden under Whatever to Whatever's underside, if Whatever has one (otherwise it will move anything hidden under Whatever to the holder of Whatever) before listing what's in Whatever's underside. This means that if Whatever has an underside, the previously hidden items will remain under the Whatever, although they'll no longer be hidden (the player can interact with them, and commands like TAKE ALL will now apply to them).

Additionally, when the player takes something, both the items in its underside and the items hidden under it will be revealed and moved to the previous holder of the item just taken. For exampled, suppose we define:

	The chair is a portable enterable supporter in the Study.

	An underside called under#chair is part of the chair. under#chair is open.

	A small red book is in under#chair.
	A black pen is hidden under the chair.

	The player carries a blue ball.

If the player issues the commands PUT BALL UNDER CHAIR followed by TAKE PEN (without first looking under the chair), then the parser will complain that he can't see the pen, although s/he could TAKE BALL or TAKE BOOK at this point. If however the player issues the commands PUT BALL UNDER CHAIR followed by TAKE CHAIR, then the ball, book and pen will all be revealed as having been under the chair.

The real advantage here is that this provides a convenient mechanism for allowing the player to interact with items s/he knows are under the chair (e.g. because s/he put them there) while continuing to conceal items that we hid under the chair until the player takes active steps to find them (by looking under or taking the chair).

Note that we can still provide our own definition of "To say find-hidden-under (obj - a thing)", but this will only be effective for things that *don't* have an underside.

We can also test whether something is under something else with the "under" relation, e.g.

	if the pen is under the bed...
	now everything under the bed is carried by the player.
	say "Under the bed is [a list of things under the bed]."

If Underside is used with the Hiding Under extension, the 'under' relation will include items hidden under the target object as well as items in the target object's underside. Note that "to be under" is a relation that tests a condition, so we can't declare "the pen is under the bed", neither can we say "now the pen is under the bed". As seen above we can declare "the pen is hidden under the bed" (as an initial state), and we can also rule that "now the bed is hidden under the bed", although it's likely to be useful to use the phrase "hide the pen under the bed".

We can use "contained under" to test for something being in another object's underside, e.g.

	if the pen is contained under the bed...

will be true if the pen is in the bed's underside (but not if the pen is hidden under the bed in the sense that the Hiding Under extension gives to "hidden under"). Note that "contained under" is a to decide phrase, not a relation, so it can only be used in tests, not in descriptions.


Finally, note a couple of important distinctions here.

The statement "The black pen is hidden under the chair" makes the black pen hidden until the player looks under the chair or takes the chair. From the player perspective the black pen was under the chair all along, but from the author's perspective the black pen was in fact off-stage until the player discovered it.

The statement "A small red book is in under#chair" places the small red book in the underside (a type of container) called "under#chair". If under#chair is closed, then this has much the same effect as saying "The small red book is hidden under the chair", insofar as the player won't be able to interact with the small red book until s/he either looks under or takes the chair. If, however, under#chair is defined to be an open underside, then the player will be able to interact with the small red book from the start (so long as s/he's in the appropriate location). Making an underside closed has the effect of concealing everything that's in it. Using "hide x under y" conceals only that particular x. Mixing the two mechanisms thus allows us to have some items hidden under something, and under items simply under the same thing without being hidden.


Section: Which Extensions to Use for What

At first sight it may seem that Underside and Hiding Under provide overlapping functionality, and it may be unclear which to use for what.

In brief, Hiding Under provides rather basic functionality for finding things that were hidden under other things, but does not really model the space under objects. A further potential disadvantage is that it uses a many-to-one relation between things, which may be quite expensive in terms of resources. This should not matter for games compiled to Glulx but may be an issue for Z-Code games.

Underside provides slightly fuller functionality insofar as it does model the space under objects, which may be particularly relevant if you want to allow players to put things other under things as well as just finding them there. Used by itself it doesn't employ any additional relations, and so may be the more economical solution for Z-Code games.

Using Underside with Hiding Under doesn't do a lot that you can't do with Underside alone, but it does make it more convenient, since:

(a)	You can set up your game with statements like:

	The ball is hidden under the bed.

(b)	There's less work to do to distinguish between items initially hidden under other items (that the player won't know about until s/he actively looks for them) and items placed under other items by the player (which s/he) will know about. Note, however, that to take full advantage of this you'll want to define your undersides as open, or else include something like the following somewhere in your code:

	{*}Carry out placing something under something (this is the open when placing underneath rule):
		if an underside (called the underpart) is part of the noun, now the underpart is open.

Or indeed simply:

	{*}an underside is usually open.



Thus, for a Glulx game it's probably worth including both extensions. For a Z-Code game you may need to be more choosy.

Note that for really simple cases, such as a game when only one object (or only an handful of objects) is hidden under anything, you may not need either extension; in such cases a simple instead rule may be all that's required, for example:

	Instead of looking under the mat when the cheque is off-stage:
		move the cheque to the player;
		say "Under the mat you find a cheque for ten thousand euros, which you quickly snatch up!"

Chapter: Change Log

4.0.1 Fixed example spacing


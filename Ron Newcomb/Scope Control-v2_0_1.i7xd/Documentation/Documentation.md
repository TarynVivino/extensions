Deciding what a character can interact with at any given moment is determined by her senses and the physical reality of her universe.  The complicated reasoning to enforce all this is collectively called "scope".  Chapter 12 of Writing with Inform talks of this at length under the rubrics of reachability and visibility.

However, both technology and magic can overcome such obstacles.  Clairvoyance and cell phones exist in many universes, so player commands such as BOB, REACH OUT AND TOUCH SOMEONE should be possible without undue difficulty.

While the Deciding the Scope of Something activity can naïvely modify scope this way:

	{*}After deciding the scope of the player while the player calls someone:
		place the other party of the player in scope.

...it causes certain problems, such as the player being able to see, hear, and touch what he should only be able to hear:

	> JESSE, LOOK
	"I'm still across town.  I'll call you back when I get close."

	> EXAMINE JESSE
	She looks exhausted from the confusing drive.

This extension allows four conditions that can be attached to rules in the Deciding the Scope of Something activity.  They are:
	while parsing the nouns
	while parsing for persuasion
	while looping over scope
	while testing scope

Hence, we can modify scope correctly:

	{*}After deciding the scope of the player while parsing for persuasion and while the player calls someone:
		place the other party of the player in scope.



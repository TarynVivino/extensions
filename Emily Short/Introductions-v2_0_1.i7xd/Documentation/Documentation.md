Introductions allows the author to write introductions that will appear the first time the player sees certain items and rooms, and also to create segues drawing two passages of introductory text together.

Chapter: Things

Section: Introductory text for things

Introductions allows us to write special introductory text that will appear the first time the player sees an object in a room description, like this:

	The introduction of the table is "In the corner is the table your aunt bought from the thrift store. The top surface of it is decoupaged with newspaper advertisements for organic produce. You can't eat a bowl of macaroni without being chided by images of alfalfa and bran."

This text will appear in place of the initial appearance property or any other similar text that might otherwise introduce the table.

Section: Segues between object introductions

We can also write segues to be shown between two specific items being introduced.

If Introductions introduces one item, and a second, segue-related item is scheduled to be introduced later in the room description, it will change the order in which it produces output in order to use the segue.

To create new segues, we must add to the Table of Segues, thus:

	Table of Segues (continued)
	first	second	segue
	orange	apple	"And speaking of fruit... "
	apple	orange	"You've never really cared for fruits, though. "

Section: Segues that completely replace existing introductions

There may be times when we want our segue to completely override the introduction of the second item, rather than merely adding text to the beginning of it. In that case, we can override the introduction entirely, like this:

	Table of Segues (continued)
	first	second	segue
	apple	mare	"[override intro for the mare]The apple was probably brought here as a bribe for the mare in the corner, but it doesn't look as though she was interested."

Section: Spacing introductions and segues

The segue text will be printed after the introduction of the first item and before the introduction of the second; by default, there is no paragraph break anywhere here, which gives us maximum freedom to add our own. If, for instance, we wanted to produce the text

	Fred is prowling near the fireplace, looking morose. He's an old friend of yours, but lately you've found him more and more difficult to take: all his little tics -- impatience, rudeness, tendency to interrupt -- have grown more pronounced since Lisa left. Some of your social circle now act as though he weren't there at all, as though his stammered, tactless commentary were no more than background noise from a radio.

	Fred is no favorite with Doctor Pearson, either, which is why you're surprised to see the old man sitting serenely in the leather recliner, sipping a vodka gimlet.

we could create this effect by putting the paragraph break inside the segue, thus:

	Table of Segues (continued)
	first	second	segue
	Fred	Doctor Pearson	"[paragraph break][override intro for Pearson]Fred is no favorite with Doctor Pearson, either, which is why you're surprised to see the old man sitting serenely in the leather recliner, sipping a vodka gimlet. "

Chapter: Rooms

Section: Introductions

Finally, we can provide introductions for a whole room, and that text will appear as a final item in the room description, after the objects there, as in

	Pipe Crossing
	This is a meeting of several pipes: one leads abruptly down and to the north, while gently upward-sloping pipes lead southeast and southwest. A cold and murky white liquid flows from both southern pipes into the northern one.

	A licorice gum drop has been caught by one of the seams of metal, doubtless the only reason it has not been swept away by the current.

	It smells like almonds in here. <-- this is the room introduction.

Section: Adding one-time text elsewhere in a room description

This is hardly the only place where we might want to add special text to a room description, but most other places are easier to add to using existing entry points. For instance, if we wanted

	You catch a whiff of almonds as you splash downstream... <-- this is the new text

	Pipe Crossing
	This is a meeting of several pipes: one leads abruptly down and to the north, while gently upward-sloping pipes lead southeast and southwest. A cold and murky white liquid flows from both southern pipes into the northern one.

	A licorice gum drop has been caught by one of the seams of metal, doubtless the only reason it has not been swept away by the current.

we would instead write

	After going to Pipe Crossing:
		if Pipe Crossing is not visited, say "You catch a whiff of almonds as you splash downstream.";
		continue the action.

Or if we wanted that one-time text to appear just before or after the main room description paragraph, like this

	Pipe Crossing
	The smell of almonds is overpowering when you enter. <-- this is the one-time text

	This is a meeting of several pipes: one leads abruptly down and to the north, while gently upward-sloping pipes lead southeast and southwest. A cold and murky white liquid flows from both southern pipes into the northern one.

we might write

	The description of Pipe Crossing is "[if unvisited]The smell of almonds is overpowering when you enter. [paragraph break][end if]This is a meeting of several pipes: one leads abruptly down and to the north, while gently upward-sloping pipes lead southeast and southwest. A cold and murky white liquid flows from both southern pipes into the northern one."

or similarly

	Pipe Crossing
	This is a meeting of several pipes: one leads abruptly down and to the north, while gently upward-sloping pipes lead southeast and southwest. A cold and murky white liquid flows from both southern pipes into the northern one.

	The smell of almonds is overpowering when you enter. <-- this is the one-time text

we might write

	The description of Pipe Crossing is "This is a meeting of several pipes: one leads abruptly down and to the north, while gently upward-sloping pipes lead southeast and southwest. A cold and murky white liquid flows from both southern pipes into the northern one.[if unvisited][paragraph break]The smell of almonds is overpowering when you enter. [end if]"

Chapter: Troubleshooting and Compatibility

Section: Introductions don't appear for objects in the room

Introductory text will appear for an object that is in a room for description, unless we have explicitly written a writing a paragraph about rule that is more specific and takes precedence over the default rule.

For instance, the following would prevent the appearance of the table's introduction:

	Rule for writing a paragraph about the table:
		say "A TABLE IS HERE."

Section: Introductions don't appear for objects on supporters

Introductions relies on the writing a paragraph about activity, which, by default, is activated for objects appearing in the room, but not for those which are visibly set on supporters. We can explicitly override this if we want to.

One way to do this is demonstrated in the "Kill Doctor Pearson" example, below. It works best, though, if the supporters in question are not scenery.

Note that this is a complication that arises with the default behavior of Inform; the replacement room description extensions Tailored Room Description and Ordinary Room Description are more customizable.

Section: Using with alternative room description extensions

Introductions can be used on its own, or in combination with the extensions Tailored Room Description or Ordinary Room Description.

Ordinary Room Description emulates the default output of Inform, and is useful primarily because it allows us to use the base extension Room Description Control: we get the same type of output as usual, but with increasing control over the order in which items are printed within the description, and more ability to omit our chosen objects from the description entirely.

Tailored Room Description provides an alternate type of output, which gets rid of parenthetical remarks such as "(on which are a bone and a piece of dried grass)" in favor of full sentences describing contents and supported objects.

To use Introductions with one of these extensions, we should install Room Description Control and either Ordinary Room Description or Tailored Room Description; include the extension of our choice; and then add

	When play begins:
		change fake-paragraph-break to "[line break][line break][run paragraph on]".

This latter portion is necessary because there are slight differences in the way the extensions handle paragraph breaking, and without it the spacing will look wrong in some circumstances.

Introductions is *not* compatible with the Single Paragraph Description extension.


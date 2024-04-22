Chapter: Overview

List Controller provides much the same functionality as the older List Control extension (with some enhancements), but does away with the need to define a Table of Table Types. Instead, you need to define a number of list controller objects, but some authors may find this slightly less messy.

First, the story in brief: List Controller provides three ways of traversing a list contained in a table: stopping, cyclic, or shuffled. To define which type applies to a given table, we define a corresponding list controller and associate a Table with it:

	my list is a stopping list controller.
	the associated list is the Table of My Stuff.

	Table of My Stuff
	response
	"Boo!"
	"Whee"
	"Foo!"
	"Bar!"
	
To display the next response entry from such a table, we use the phrase:

	show the next response from my list.

We can also use 'in' or 'of' instead of 'from' (to allow for whichever phrasing seems most natural without having to remember which is the only correct one).
	

If we want to use a table other than one with a single column called 'response' containing text, we can instead obtain the next row number in our chosen sequence with the value:

Chapter: Detail

Section: Random Responses
		
Now for the longer explanation:

We may often want to use a table to provide a list of responses for use, say, as a series of atmospheric messages, or as a series of responses by the NPC on the same topic. Sometimes we may want to work through these responses in sequence (e.g. a succession of answers by the NPC to the same question from the player), and sometimes we may want the responses to appear more random (e.g. a succession of atmospheric messages, or default responses from an NPC when the player asks about a topic not specifically covered). One can, of course, readily obtain a random response from a table with code like:

	Instead of Jumping:
	choose a random row in the Table of Jumps;
			say "[jump entry]."


	Table of Jumps
	jump
	"Wow!"
	"You bang your head on the ceiling."
	"Whee!"
	"Ouch"

But this can easily produce a sequence like "Wow", "Wow", "Whee", "Ouch", "Wow", "Whee", "You bang your head on the ceiling", that is a sequence where one or more of the messages appear several times before every message has been seen. Often the effect would be better if we saw every message once, and then every message again in a different order, like dealing from a pack of cards and then shuffling the pack again after every card has been dealt once to obtain a new sequence.

On other occasions, for example when asking an NPC repeatedly about the same subject, we may want to show a series of responses in sequences, and then keep repeating the final one (which might be along the lines of "You've already asked me that, and the answer was...").

List Controller provides a means of doing this. To set up a shuffled list, we would define:

	The Test Place is a room.

	jump list is a shufled list controller.
	The associated list is the Table of Jumps.
	
	Table of Jumps
	response
	"Wow!"
	"You bang your head on the ceiling."
	"Whee!"
	"Ouch"
	

	Instead of jumping:
		show the next response from the jump list, with newlines.

Section: Phrase options: with newlines, with run on, with paragraph break

The 'with newlines' option adds a newline to the text that's displayed, which is often useful if it's meant to be a complete response in itself. If, however, you're using a list controller to provide part of a response to something, you might not want the newline, in which case you can omit the option, or use the "with run on" option to ensure than any ensuing text is part of the same paragraph. There is also a "with paragraph break" option to force a parargraph break (as opposed to the line break you get with "with newlines").


Section: Stopping, cyclic and shuffled list controllers

A list controller can be in one of three conditions: stopping, cyclic or shuffled.

A shuffled list controller runs through each row of its associated table in turn, then sorts the table in random order before starting again at the beginning.
A stopping list controller runs through each row in turn, then keeps repeating the final row of the table.
A cyclic list controller runs through each row in turn until it reaches the final row of the table, and then returns to the first row and repeats the rows in the same sequence as before.

Hence we might also define:

	Instead of Smelling the Test Place:
		show the next response from the smell list.

	smell list is a cyclic list controller.
	The associated list is the Table of Smells.

	Table of Smells
	response
	"Poo!"
	"What a pong!"
	"Smells like rotten eggs"
	"Powerful whiff!"

	

	Instead of Listening to the Test Place:
		show the next response from the sound list.

	sound list is a stopping list controller.
	The associated list is the Table of Sounds.

	Table of Sounds
	response
	"There's a lound ringing sound."
	"The ringing is fading."
	"Just a faint echo."
	"Silence."

Section: Event lists

In addition to an response column, a Table associated with a list controller may also (or instead) have an event column which can contain rules (which will then be executed iin place of or as well as displaying the string in the response column). If there is an event entry and an response entry in the same row, the event rule will be executed before the response string is displayed (for an example, see Example A below).

Section: Alternative table structures

Finally, if you want to use list controller in conjuction with a Table with a different structure (e.g. a table containing a list of objects from which you want to select one), you can use the phrase "the next row to use from my list controller" to get at the next row number to use. For example:

	to notice a piece of fruit:
		let r be the next row to use in the fruit list;
						choose row r in the Table of Fruit;
						let response be the fruit entry;
		move the response to the bowl;
		"For some reason, you suddenly notice [the response] in the bowl."

	The fruit list is a shuffled list controller.
	The associated list is the Table of Fruit.

	Table of Fruit
	fruit
	apple
	orange
	banana
	pear
	plumb




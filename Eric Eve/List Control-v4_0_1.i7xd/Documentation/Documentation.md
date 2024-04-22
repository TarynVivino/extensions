First, the story in brief: List Control provides three ways of traversing a list contained in a table: stop-list, cyclic-list and shuffled-list. To define which type applies to a given table, we define the corresponding row in the Table of Table Types:

	Table of Table Types (continued)
	tabname		index	tabtype
	Table of My Stuff		0	shuffled-list

	Table of My Stuff
	response
	"Boo!"
	"Whee"
	"Foo!"
	"Bar!"
	
To display the next response entry from such a table, we use the phrase:

	show the next response from the Table of My Stuff.

If we want to use a table other than one with a single column called 'response' containing text, we can instead obtain the next row number in our chosen sequence with the value:

	the relevant row in the Table of My Rules

For example

	let r be the relevant row of the Table of My Rules;
	choose row r in the Table of My Rules;
	follow the singing rule entry.
	
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

List Control provides a means of doing this. To set up a shuffled list, we would define:

	The Test Place is a room.

	Table of Jumps
	jump
	"Wow!"
	"You bang your head on the ceiling."
	"Whee!"
	"Ouch"

	Table of Table Types (continued)
	tabname		index	tabtype
	Table of Smells		0	cyclic-list

	Instead of jumping:
		let r be the relevant row of the Table of Jumps;
		choose row r in the Table of Jumps;
				say "[jump entry]."

If we create a table with a single column called response which contains only text values, we can simplify this code even further:

	Table of Jumps
	response
	"Wow!"
	"You bang your head on the ceiling."
	"Whee!"
	"Ouch"

	Table of Table Types (continued)
	tabname		index	tabtype
	Table of Jumps		0	shuffled-list

	Instead of jumping:
		show the next response from the Table of Jumps.

Note that for this to work, we also have to define a continuation to the Table of Table Types. The first column must contain the name of the table we are defining, the second a number (normally zero), and the third the type of table we want it to be, which must be one of shuffled-list, stop-list or cyclic-list.

The shuffled-list type runs through each row of the table in turn, then sorts the table in random order before starting again at the beginning.
The stop-list type runs through each row in turn, then keeps repeating the final row of the table.
The cyclic-list type runs through each row in turn until it reaches the final row of the table, and then returns to the first row and repeats the rows in the same sequence as before.

Hence we might also define:

	Instead of Smelling the Test Place:
		show the next response from the Table of Smells.

	Table of Smells
	response
	"Poo!"
	"What a pong!"
	"Smells like rotten eggs"
	"Powerful whiff!"

	Table of Table Types (continued)
	tabname		index	tabtype
	Table of Smells		0	cyclic-list


	Instead of Listening to the Test Place:
		show the next response from the Table of Sounds.

	Table of Sounds
	response
	"There's a lound ringing sound."
	"The ringing is fading."
	"Just a faint echo."
	"Silence."

	Table of Table Types (continued)
	tabname		index	tabtype
	Table of Sounds		0	stop-list

In the above examples we have defined each fragment of the continued Table of Table Types immediately after the table to which it refers. It may often be more convenient to do it that way, but we can of course collect this continued table all in one place if we prefer:

	Table of Table Types (continued)
	tabname		index	tabtype
	Table of Jumps		0	shuffled-list
	Table of Smells		0	cyclic-list
	Table of Sounds		0	stop-list

Note that the index value is normally 0, but it may sometimes be useful to define it as some other value. In particular, defining an index value of some number greater than the number of rows in a shuffled-list table will cause the table to be sorted in random order before choosing the first value from it (otherwise on the first pass through the rows will be displayed in the order in which they are listed in the table as defined, which may or may not be what we want).


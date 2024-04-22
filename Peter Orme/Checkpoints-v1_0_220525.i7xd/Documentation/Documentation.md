
Chapter: The idea

One idea is that we want to write a "test me" script for our story, but also have that test script actually perform 'unit testing'-type assertions along the way.

Another idea is to have known "checkpoints" in our story that you can get to, and you want to test that the state of the world is as you think it is at these points.

Chapter: Using the Table of Checkpoints

To write assertions, you create a table called Table of Checkpoints (continued) which has exactly three columns: "topic", "assertion" and "message".

The first column, "topic", is a topic column. The easiest thing here is just to type in a single keyword in quotes. Consult section 16.13 in the documentation to read up on more fun you can do with topic columns. You can have the same value in multiple rows of your column, and use these as a way to group test.

The second columnt, "assertion", is a little special. It contains a double-quoted string that should be empty for the assertion to succeed. Just typing in an empty string (just two quotes) will work, but it's not really testing anything, is it. So what we typically do is use bracketed expressions like "[if the ball is red]fail[end if]"

It does not need to say "fail" on failure, it can say anything.

The third column, "message", is just any text that will be shown on failure.

Chapter: running assertions

To trigger running all the assertions that match the topic column while playing a game, type in "checkpoint assert xxx" where xxx matches the topic. See example A.


If we must, we can also make in-world games that trigger assertions using something like this:

	The button is a thing in the football field.
	
	instead of pushing the button:
		try checkpoint-asserting "baller".



	Chapter - Example airlock
	
	Section - World
	
	Planetside is a room. "Nothing but bare rock under a darkening sky.[first time] You'd better get inside before dark falls. It gets cold on this planet. Colder than your what suit can protect you from.[only]".
	
	The player is wearing a space suit. The description of the space suit is "It's just like any other space suit you've worn.". Understand "spacesuit" as the space suit.
	
	check taking off the space suit:
		unless the air is breathable:
			say "Not until you're safely inside.";
			stop the action.
	
	To decide whether the air is breathable:
		if the player is in Planetside, no;
		if the player is in the Airlock and the outer door is open, no;
		yes;
	
	Airlock is a room.
	
	The outer door is a door. It is inside from Planetside and outside from Airlock. The description is "The outer door is solid and sturdy, made to isolate from cold and wind. You pull the door down to close it. There's a large spring that makes sure it opens and closes automatically as it should. The door is currently [if the outer door is open]open[otherwise]closed[end if].";
	
	The spring is a fixed in place thing in the airlock. It is scenery. The spring can be fixed. The description of the spring is "It's a large and slightly rusty spring, clearly not part of the original design of the door, but something somebody added as a quick fix.[if the spring is fixed] It looks straighter now that you gave it a whack.[otherwise] It looks a bit crooked. Nothing a good blow won't fix.[end if]";
	
	instead of pulling the outer door: try closing the noun.
	instead of pushing the outer door: try opening the noun.
	
	instead of attacking the fixed spring:
		say "You've already done that.";
	
	instead of attacking the spring:
		say "You give the spring a good blow.";
		now the spring is fixed.
	
	after going inside from Planetside:
		unless the spring is fixed:
			say "The outer door closes automatically behind you with a hiss. And then it opens again. That's not supposed to happen!";
		otherwise:
			say "The door closes behind you, as it should.";
			now the outer door is closed.
	
	The inner door is a door. It is inside from Airlock and outside from Decontamination Zone.
	
	check opening the inner door:
		if the outer door is open:
			say "You can't open the inner door while the outer door is open. That's how an airlock works, you know.";
			stop the action;
	
	after closing the outer door when the spring is not fixed:
		say "You pull the door down, but it just hisses and opens again. How annyoing!";
		now the outer door is open.
	
	Section - Checkpoints - Not for release
	
	Table of checkpoints (continued)
	topic	assertion	message
	"airlock"	"[unless the outer door is closed]fail[end if]"	"The outer door should be closed"
	"airlock"	"[unless the player is in decontamination zone]fail[end if]"	"You should be in the decontamination zone"
	"airlock"	"[if the player is wearing the space suit]fail[end if]"	"You should have taken off the space suit"
	"airlock"	"[unless the spring is fixed]fail[end if]"	"You need to fix the spring"
	
	test airlock with "open outer / in / close outer / in / take off space suit / checkpoint assert airlock".
	
	test solution with "hit spring / close outer / open inner / in / close inner / remove suit".

	test me with "test airlock".
	
	Table of Checkpoint scripts (continued)
	topic	name	rule
	"airlock"	"airlock"	checkpoint airlock rule
	
	this is the checkpoint airlock rule:
		now the outer door is closed;
		now the inner door is closed;
		now the spring is fixed;
		now the player is in the Decontamination zone;
		now the player is carrying the space suit;
		say "You figured out that you need to hit the spring to fix the outer door. After that you just needed to close the outer door, open the inner door, walk inside and take off the space suit.";
		try checkpoint-asserting "airlock";




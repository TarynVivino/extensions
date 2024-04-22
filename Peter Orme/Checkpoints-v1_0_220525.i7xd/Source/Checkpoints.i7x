Version 1.0.220525 of Checkpoints by Peter Orme begins here. 

"A method of using assertions stored in a table to verify your game works as expected."

[Version 1.0.220524: Updated for Inform v10.1 by Nathanael Nerode]

Include Unit Testing by Peter Orme.

Chapter 1 - Checkpoint Assertions 

Section 1 - Table of Checkpoints

Table of Checkpoints
topic	assertion (a text)	message (a text)
--	--	--

Section 2 - Checkpoint-asserting 

checkpoint-asserting is an action out of world applying to one topic. 

Understand "checkpoint assert [text]" or "cpa [text]" as checkpoint-asserting.

carry out checkpoint-asserting:
	reset the asserter;
	repeat through the Table of Checkpoints:
		if the topic understood includes topic entry: 
			assert "[assertion entry]" is empty saying only "[message entry]";
	report asserts using high verbosity set to halt never;


Chapter 2 - Checkpoint Scripts

Section - checkpoint-going

[
	This is for the other use case, where we want to define a checkpoint that we can fast-forward to. The player types "checkpoint go shipwreck" (where 'shipwreck' is the name of a checkpoint) and is magically transported there. 
]

checkpoint-going to is an action applying to one topic.
understand "checkpoint go [text]" as checkpoint-going to.
understand "cpg [text]" as checkpoint-going to.

carry out checkpoint-going to the topic understood (this is the checkpoint going rule):
	let found-checkpoint be false;
	repeat through the Table of checkpoint scripts:
		if topic understood matches the topic entry:
			follow the rule entry;
			now found-checkpoint is true;
	if found-checkpoint is true:
		say "Followed the checkpoint script for [topic understood].";
	otherwise:
		say "There is no checkpoint script for [topic understood].";
	
Table of Checkpoint Scripts
topic	name (a text)	rule (a rule)
--	--	--

[
We need to define this table and fill it up with named rules for the script we want to be able 
to fast-forward to.

Table of Checkpoint scripts (continued)
topic	name	rule
"airlock"	"airlock"	checkpoint airlock rule

The rules can be existing ones or those we just create on the fly, using the "this is the checkpoint airlock rule:" syntax.
]

Checkpoints ends here.

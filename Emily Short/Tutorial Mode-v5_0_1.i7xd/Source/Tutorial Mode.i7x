Version 5.0.1 of Tutorial Mode by Emily Short begins here.

"Adds a tutorial mode, which is on by default, to any game, to introduce key actions for the novice player. Can be revised or expanded by the author."

Section 1 - Creating tutorial mode and controls

Tutorial mode is a truth state that varies. Tutorial mode is true.

Understand "tutorial mode off" or "tutorial off" as turning off tutorial mode.
Understand "tutorial mode" or "tutorial on" or "tutorial mode on" as turning on tutorial mode.

Turning off tutorial mode is an action out of world.

Check turning off tutorial mode (this is the can't turn off tutorial mode when it is off rule):
	if tutorial mode is false, say "Tutorial mode is already off." (A) instead.

Carry out turning off tutorial mode (this is the default turning off tutorial mode rule):
	now tutorial mode is false.
	
Report turning off tutorial mode (this is the default report turning off tutorial mode rule):
	say "Tutorial mode is now off." (A)

Turning on tutorial mode is an action out of world.

Check turning on tutorial mode (this is the can't turn on tutorial mode when it is on rule):
	if tutorial mode is true, say "Tutorial mode is already on." (A) instead.

Carry out turning on tutorial mode (this is the default turning on tutorial mode rule):
	now tutorial mode is true.
	
Report turning on tutorial mode (this is the default report turning on tutorial mode rule):
	say "Tutorial mode is now on." (A)

Section 2 - The Instructional Rules

The expected action is a stored action that varies.
The held rule is a rule that varies. 
The completed instruction list is a list of rules that varies.

Understand "restore" or "quit" or "save" or "restart" or "version" as "[meta]". 

A first before rule (this is the react to expected actions rule):
	if the current action is the expected action:
		if the held rule is a selector listed in the Table of Instruction Followups:
			choose row with a selector of the held rule in the Table of Instruction Followups;
			say "[followup entry][paragraph break]" (A);
		add the held rule to the completed instruction list, if absent;
		now the held rule is the little-used do nothing rule;

Before reading a command when tutorial mode is true (this is the offer new prompt rule):
	follow the instructional rules.

Definition: a thing is non-player if it is not the player. 

A thing can be previously-mentioned. A thing is usually not previously-mentioned.

Before printing the name of something (called the target):
	now the target is previously-mentioned.
	
The instructional rules are a rulebook.

An instructional rule (this is the teach looking rule): 
	if the teach looking rule is listed in the completed instruction list, make no decision;
	say "To get a look around, type LOOK and press return. If you do not want help getting started, type TUTORIAL OFF." (A);
	now the expected action is the action of looking;
	now the held rule is the teach looking rule;
	rule succeeds.

Carry out looking (this is the register looking rule):
	add the teach looking rule to the completed instruction list, if absent.

An instructional rule (this is the teach examining rule): 
	if the teach examining rule is listed in the completed instruction list, make no decision;
	if the player can see a previously-mentioned non-player thing (called target): 
		let N be "[the target]"; 
		let M be "[target]";
		say "You can find out more if you LOOK AT [N in upper case] (or shorten it to L [M in upper case])." (A);
		now the expected action is the action of examining the target;
		now the held rule is the teach examining rule;
		rule succeeds;
	otherwise:
		make no decision.

Carry out examining something (this is the register examining rule): 
	add the teach examining rule to the completed instruction list, if absent;

An instructional rule (this is the teach more examining rule):
	if the teach examining rule is not listed in the completed instruction list, make no decision;
	if the teach more examining rule is listed in the completed instruction list, make no decision;
	say "There are other things around here that you can look at too, if you like. You can check out other things in your surroundings, or LOOK AT ME to see yourself." (A);
	now the expected action is the action of examining yourself;
	now the held rule is the teach examining rule;
	rule succeeds.

Before examining yourself (this is the prepare to teach more examining rule):
	add the teach more examining rule to the completed instruction list, if absent;

An instructional rule (this is the teach compass directions rule):
	if the teach compass directions rule is listed in the completed instruction list:
		make no decision;
	if the held rule is the teach compass directions rule:
		let delay be the time of day minus movement reminder;
		if delay is less than five minutes:
			rule succeeds;
	let way be nothing;
	if a room (called goal) is adjacent:
		let way be the best route from the location to the goal;
	otherwise if the player can see an open door (called portal):
		let far side be the other side of the portal;
		let way be the best route from the location to the far side;
	otherwise:
		make no decision;
	if way is nothing:
		make no decision; 
	let N be "[way]";
	say "[one of]Feel free to look around some more. When you're ready to move on from here, try[or]No rush, but just a reminder that when you want to move to a new location, you can go[stopping] [N in upper case]." (A);
	now the expected action is the action of going way;
	now the held rule is the teach compass directions rule;
	now movement reminder is the time of day;
	rule succeeds.

Movement reminder is a time that varies.

Carry out going (this is the register going rule):
	add the teach compass directions rule to the completed instruction list, if absent.


[Because it can be annoying if the game persistently tells you to drop something when you don't want to, this one explains the rule and then immediately removes it, rather than harping on about the topic.]
An instructional rule (this is the teach dropping rule):
	if the teach dropping rule is listed in the completed instruction list, make no decision;
	unless the player carries at least two things, make no decision;
	let target be a random thing carried by the player; 
	let N be "[the target]";
	say "If you want to get rid of something that you're holding you can always drop it, like this: DROP [N in upper case]." (A);
	add the teach dropping rule to the completed instruction list, if absent;
	rule succeeds.

Carry out dropping something (this is the register dropping rule):
	add the teach dropping rule to the completed instruction list, if absent. 

An instructional rule (this is the teach taking rule):
	if the teach taking rule is listed in the completed instruction list, make no decision;
	if the player can see a take-worthy thing (called target item): 
		let N be "[the target item]";
		say "You can pick things up when you see them, like this: TAKE [N in upper case]." (A);
		now the expected action is the action of taking the target item;
		now the held rule is the teach taking rule;
		rule succeeds;
	otherwise:
		make no decision.

Definition: a thing is take-worthy:
	if it is the player:
		no;
	if it is scenery:
		no;
	if it is not portable:
		no;
	if it is a person:
		no;
	if it is carried by someone:
		no;
	if it is part of something:
		no;
	if it is in a closed container:
		no; 
	yes.

Carry out taking something (this is the register taking rule):
	add the teach taking rule to the completed instruction list, if absent.

An instructional rule (this is the teach inventory rule): 
	if the teach inventory rule is listed in the completed instruction list, make no decision;
	if the player carries nothing, make no decision;
	say "There's more we can do than just looking around. To check what you're holding at the moment, try typing INVENTORY, or I for short." (A);
	now the expected action is the action of taking inventory;
	now the held rule is the teach inventory rule;
	rule succeeds.

Carry out taking inventory (this is the register inventory rule):
	add the teach inventory rule to the completed instruction list, if absent.

A last instructional rule (this is the teach meta-features rule):
	if the teach meta-features rule is listed in the completed instruction list, make no decision;
	say "To save your current position, type SAVE. RESTORE allows you to bring back a game you have previously saved." (A);
	add the teach meta-features rule to the completed instruction list;
	rule succeeds. 

Table of Instruction Followups
selector	followup   
teach dropping rule	"Dropping things will move them into your environment, like this:"
teach taking rule	"Well done. Now you'll get a message to tell you whether you succeeded in picking up something:"
teach compass directions rule	"Good! Like other often-used instructions, compass directions can be abbreviated down to N, S, E, W, NE, NW, and so on. UP and DOWN are also possible -- keep an eye on room descriptions in order to learn more about where you can go and when. [paragraph break]As soon as you enter a new room, you'll get a description of what's there, like this:"

Tutorial Mode ends here.

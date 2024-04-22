Version 7.0.1 of Simple Followers by Emily Short begins here.

"Allows non-player characters to follow the player (or one another); adds a FOLLOW command and a corresponding STOP FOLLOWING command so that the player can issue these orders to non-player characters. Adds adaptive text features."

Section 1 - The shadowing relation

Shadowing relates various people to one person (called the goal). The verb to shadow (he shadows, they shadow, he shadowed, he is shadowed, he is shadowing) implies the shadowing relation. 

Every turn: 
	repeat with pursuer running through people who are shadowing someone:
		let starting-space be the location of the pursuer; 
		let ending-space be the location of the goal of the pursuer; 
		if the starting-space is not the ending-space:
			let next-way be the best route from the starting-space to the ending-space, using doors; 
			if next-way is a direction:
				try the pursuer trying going next-way; 

Section 2 - The FOLLOW action

To prefer is a verb. To realize is a verb. To begin is a verb. To redouble is a verb.

Understand "follow [something]" as following. Following is an action applying to one thing. Understand the commands "pursue" and "chase" as "follow". Understand "start following/pursuing/chasing [something]" as following. Understand the commands "begin" and "commence" as "start".

Check following something (this is the block following rule): 
	say "[We] [prefer] to keep [our] options open." (A) instead.

Check someone trying following (this is the following only people rule): 
	if the noun is not a person, stop the action.

Check someone trying following (this is the following people already followed rule):
	if the person asked is shadowing the noun, stop the action.

Carry out someone trying following (this is the standard shadowing rule): 
	now the person asked shadows the noun. 

Report someone trying following (this is the standard report someone trying following rule): 
	say "[The person asked] [begin] to follow [if the noun is the player]you[otherwise][the noun][end if]." (A)

Unsuccessful attempt by someone trying following (this is the excuses for not following rule):
	if the reason the action failed is the following only people rule:
		say "[The person asked] [realize] [they] [cannot] follow anything inanimate." (A);
	if the reason the action failed is the following people already followed rule:
		say "[The person asked] [redouble] the effort to follow [if the noun is the player][us][otherwise][the noun][end if]." (B)


Section 3 - The STOP FOLLOWING action

To cease is a verb. To look is a verb.

Understand "stop following/chasing/pursuing [something]" as ceasing to follow. Ceasing to follow is an action applying to one thing. Understand the commands "cease" and "desist" as "stop". Understand "quit following/chasing/pursuing [something]" as ceasing to follow.

Check ceasing to follow something (this is the block ceasing to follow rule):
	say "[We] [aren't] [if the player is plural-named]followers[else]a follower[end if] anyhow." (A) instead.

Check someone trying ceasing to follow (this is the can't stop following what isn't followed rule):
	if the person asked is not shadowing the noun, stop the action.
	
Carry out someone trying ceasing to follow (this is the standard stop-shadowing rule):
	now the person asked is not shadowing the noun.
	
Report someone trying ceasing to follow (this is the standard report someone trying ceasing to follow rule):
	say "[The person asked] [cease] to pursue [if the noun is the player]you[otherwise][the noun][end if]." (A)

Unsuccessful attempt by someone trying ceasing to follow (this is the excuses for not ceasing to follow rule):
	say "[The person asked] [look] blank, since [they] [are] ";
	if the person asked is shadowing someone:
		say "following [the random person shadowed by the person asked], not [the noun]." (A);
	otherwise:
		say "already not following anyone." (B)


Section 4 - Another meaning for WAIT

Understand "wait here/still/put" as waiting. Understand the command "stay" as "wait".

Instead of asking someone who is shadowing someone to try waiting (this is the waiting cancels following rule):
	try asking the person asked to try ceasing to follow the goal of the person asked.

Simple Followers ends here.

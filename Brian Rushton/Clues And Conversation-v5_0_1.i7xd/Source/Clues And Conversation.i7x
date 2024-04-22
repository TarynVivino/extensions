Version 5.0.1 of Clues and Conversation by Brian Rushton begins here.

"A simple system for building conversations."

"developed with 6m62"

[Thanks to Michael Lauenstein, Gavin Lambert and Matt Weiner]

Chapter 1 - Quips

Section 1 - Basic definitions

[Quips are the topics or clues you can discuss]

A quip is a kind of thing. 

Section 2 - Properties of quips

[We use physicality to determine what things we can do to quips]

A thing can be physical or unphysical. A thing is usually physical.

A quip is never physical. A quip has some text called the preview. The preview of a quip is usually "Insert preview here.". A quip has some text called history. 

[You can only discuss a quip with it's target, if it has one. If the target is the nobody, you can discuss it with everyone. Thanks to Gavin Lambert for this idea.]

A quip has an object called the target. The target of a quip is usually nothing.

['Meih' means 'not yet'. You don't have to use it; you can just say 'not TargetGiven'. This is just a way to check if you've already discussed something with someone.]

A quip can be TargetGiven or MeihTarget. A quip is usually MeihTarget.

[TargetResponse is the text that you get after saying something]

A quip has some text called TargetResponse. The TargetResponse of a quip is usually "You get no response." 

[TargetSummary is only used when recalling, remembering, or examining a topic you've already discussed. ]

A quip has some text called TargetSummary. The TargetSummary of a quip is usually "You already tried talking about this."

[This is purely for aesthetics. You can call quips 'clues' and it will change all the text to be 'clues']

A clue is a kind of quip.

[When a quip can be spoken to multiple people, we need a more complicated relationship]

[Heeding takes the place of the Target. By default, when you deliver a generic quip, we make everyone heed it]

Heeding relates various people to various quips. The verb to heed means the heeding relation.

[Forsaking takes the place of MeihTarget]

Forsaking relates various people to various quips. The verb to forsake means the forsaking relation.

Section 3 - Preventing dumb actions

[This makes it so you can't 'drop all' or 'take all' and have it involve your topics]

Rule for deciding whether all includes quips (this is the exclude quips from all rule): 
	it does not.

[Thanks to Matt W for this cleaner way than my previous version]

inserting is material behavior.

putting is material behavior.

taking is material behavior.

dropping is material behavior.

switching on is material behavior.

switching off is material behavior.

opening is material behavior.

closing is material behavior.

wearing is material behavior.

pushing is material behavior.

pulling is material behavior.

touching is material behavior.

cutting is material behavior.
	
attacking is material behavior.

waving is material behavior.

burning is material behavior.

rubbing is material behavior.

squeezing is material behavior.
	
tasting is material behavior.

eating is material behavior.
	
drinking is material behavior.

giving is material behavior.

Before material behavior when the noun is unphysical (this is the can't touch immaterial things rule):
	say "That's not a physical object." (A) instead;

Chapter 2 - Quip dynamics

Section 1 - Remembering

[When you examine or remember a topic, it prints its history]

Understand "recall [something]" or "remember [something]" as examining.

Check examining a quip (this is the quip description rule):
	say "[The history of the noun]" (A) instead;

Section 2 - Delivering quips

[Talkative describes all possible targets of a quip. We include 'yourself' as someone guaranteed to exist. We make the player talkative when play begins.]

A person can be talkative or not talkative. A person is usually talkative. Yourself is not talkative.

[Delivery is the way that people get new topics. The 'deliveryflagged' thing is a gimmick to make sure that new topics show up at the end of each turn.]

A quip can be deliveryflagged or not deliveryflagged. A quip is usually not deliveryflagged.

To deliver (CurrentQuip - a quip):
	if CurrentQuip is carried by the player:
		do nothing;
	otherwise:
		now CurrentQuip is deliveryflagged;
	
[Now some replacement phrases]

A quip has some text called ClueOrTopic. The ClueOrTopic of a quip is usually "topic".

The ClueOrTopic of a clue is usually "clue".

To say HasCluesOrTopics:
	say "[if the number of clues carried by the player > 0]clue[otherwise]topic[end if]";

To say CapCluesOrTopics:
	say "[if the number of clues carried by the player > 0]CLUES[otherwise]TOPICS[end if]";

[First clear changes the first time we clear flags]

FirstClear is a number that varies. FirstClear is 0.

To clear the flags:
	let somethingDelivered be 0;
	repeat with currentquip running through deliveryflagged quips:
		say "[bracket]New [ClueOrTopic of currentquip] - [currentquip][close bracket][roman type]";
		say "[line break]";
		now history of currentquip is "[currentquip] - [preview of currentquip][line break]";
		now currentquip is carried by the player;
		now currentquip is not deliveryflagged;
		now somethingDelivered is 1;
		if the target of currentquip is nothing:
			repeat with currentperson running through talkative people:
				now currentperson heeds currentquip;
	if somethingDelivered is 1:
		If FirstClear is 0:
			say "[line break][bracket]You can see your list of [HasCluesOrTopics]s by typing [CapCluesOrTopics], or just [if the number of clues carried by the player > 0]C[otherwise]T[end if].[close bracket]";
			say "[line break]";
			now FirstClear is 1;

Every turn:
	clear the flags
	
[This line handles things delivered at the beginning of the game]

Report looking for the first time:
	clear the flags;
	
Section 3 - Renewing and removing topics

[This for topics you want to repeat]

A quip can be renewalflagged or not renewalflagged. A quip is usually not renewalflagged.

A quip can be removalflagged or not removalflagged. A quip is usually not removalflagged.

To renew (CurrentQuip - a quip):
	if CurrentQuip is not carried by the player:
		deliver CurrentQuip;
	otherwise if CurrentQuip is MeihTarget:
		do nothing;
	otherwise:
		now CurrentQuip is renewalflagged;

Every turn:
	repeat with CurrentQuip running through renewalflagged quips:
		say "[bracket]Renewed [ClueOrTopic of currentquip] - [CurrentQuip][close bracket][line break]";
		now CurrentQuip is MeihTarget;
		now CurrentQuip is not renewalflagged;

To remove (CurrentQuip - a quip):
	if CurrentQuip is carried by the player:
		now CurrentQuip is removalflagged;

Every turn:
	repeat with CurrentQuip running through removalflagged quips:
		say "[bracket]Removed [ClueOrTopic of currentquip] - [CurrentQuip][close bracket][line break]";
		now CurrentQuip is MeihTarget;
		now CurrentQuip is nowhere;
		now CurrentQuip is not removalflagged;

Section 4 - Defining the uttering verbs

Understand the command "say" as something new.

[Uttering it to is our main action.]

Uttering it to is an action applying to two things. Understand "say [something] to [someone]" or "tell [something] to [someone]" or "t [something] to [someone]" or "a [something] to [someone]" or "talk about [something] to [someone]" or "say [something] [someone]" or "tell [something] [someone]" or "t [something] [someone]" or "a [something] [someone]" or "talk about [something] [someone]" as uttering it to.

Understand "tell [someone] about [something]" as uttering it to (with nouns reversed).

[Singleuttering automatically tries saying a quip to the target of the noun]

Singleuttering is an action applying to one thing. Understand "say [something]" or "tell [something]" or "t [something]" or "a [something]" as singleuttering.

[This next line and the code it's used in are just a way to to say 'talk to someone who isn't the player' if there is no target]
A person can be playerly or unplayerly. A person is usually unplayerly. The player is playerly.

Check singleuttering (this is the only quips can be singleuttered rule):
	if the noun is not a quip:
		say "That's not something you can say." (A) instead;

Carry out singleuttering (this is the standard singleuttering rule):
	if the target of the noun is nothing:
		if the number of people enclosed by the location of the player > 1:
			repeat with current running through people in the location of the player:
				if current is not the player:
					try uttering the noun to current;
					break;
		otherwise:
			say "There's no one else here." (A);
	otherwise:
		if the target of the noun is in the location of the player:
			try uttering the noun to the target of the noun;
		otherwise:
			say "[The target of the noun] isn't here." (B);	

[We favor singleuttering when possible]

Does the player mean singleuttering something:
	it is very likely;

[HelpfulText is used to remind players how to find information on past topics]

HelpfulText is some text that varies. HelpfulText is "[paragraph break][bracket][We] [can] REMEMBER or RECALL a topic to remind [ourselves] about previous conversations.[close bracket][line break]"
	
A quip has a list of things called historylist. 

Check uttering it to (this is the can't utter in darkness rule):
	if in darkness:
		say "It's too dark to find the person [we] [are] talking to!" (A) instead;

Check uttering it to (this is the uttering requires quips rule):
	if the noun is not a quip:
		say "[We] [can] only discuss your current thoughts as listed in your [HasCluesOrTopics]s." (A) instead;
	
Check uttering it to (this is the quips must be carried rule):
	if the noun is not carried by the player:
		say "That's not a [ClueOrTopic of the noun] [we] currently possess." (A) instead;

Check uttering it to (this is the uttering requires people rule):
	if the second noun is not a person:
		say "[We] [can] only do that to something animate." (A) instead;

Carry out Uttering it to (this is the standard uttering rule):
	if the second noun is the target of the noun:
		if the noun is MeihTarget:
			say TargetResponse of noun;
			say "[line break]"; 
			now the noun is TargetGiven;
			now history of the noun is "[the noun] - [preview of the noun][paragraph break][TargetSummary of noun][line break]";
		otherwise:
			say "[We] [have] already discussed this with [Target of the noun].[HelpfulText]" (A);
	otherwise if second noun heeds the noun:
		if the second noun does not forsake the noun:
			say TargetResponse of noun;
			say "[line break]"; 
			now the second noun forsakes the noun;
			add the second noun to historylist of the noun, if absent;
			now history of the noun is "[the noun] - [preview of the noun][paragraph break][We] [have] already discussed this with [historylist].[line break]";
		otherwise:
			say "[We] [have] already discussed this with [the second noun].[HelpfulText]" (B);
	otherwise:
		say "That's not something [we] plan on discussing with [the second noun]." (C);

Section 5 - When the order is reversed

Querying it to is an action applying to two things. Understand "ask [someone] about [something]" as querying it to.

Carry out querying (this is the standard querying rule):
	try uttering the second noun to the noun;

Section 6 - Guiding the player when using the wrong conversational format

Talking to is an action applying to one thing. Understand "talk to [someone]" as talking to.

CurrentPerson is some text that varies. CurrentPerson is "the player".

To say CapPerson:
	say "[CurrentPerson in upper case]";

[HasCluesorTopics is defined in Section 2 above]

[If the player is using general topics that apply to everyone, we have to add in some weird code]

Check talking to (this is the can't talk to yourself rule):
	if the noun is the player:
		say "It may be better to talk with others." (A) instead;
	
Check talking to (this is the can't talk to objects rule):
	if the noun is not a person:
		say "[We] [can] only do that with something animate." (A) instead;

[CounterThing checks if the player is carrying any quips specific to the person you are talking to or general quips]

Carry out talking to (this is the standard talking to rule):
	now CurrentPerson is "[the noun]";
	say "To speak with [the noun], choose a [HasCluesOrTopics] from below and SAY [bracket]the [HasCluesOrTopics][close bracket] TO [CapPerson].[paragraph break]" (A);
	let counterThing be 0;
	repeat with currenttwo running through quips carried by the player:
		if the target of currenttwo is the noun:
			increment counterThing;
		if the target of currenttwo is nothing:
			increment counterThing;
	if CounterThing > 0:		
		repeat with current running through quips carried by the player:
			if current is TargetGiven:
				if Target of current is the noun or the noun heeds current:
					say "[bracket]The [HasCluesOrTopics]s with an asterisk (*) can no longer be discussed with [the noun].[close bracket][paragraph break]" (B);
					break;
		say "[bold type]Things to say to [the noun]:[roman type]" (C);
		repeat with currentquip running through all quips carried by the player:
			if Target of currentquip is the noun:
				say "[line break]   [if currentquip is targetgiven]*[end if]";
				say "[currentquip] - [preview of currentquip]";
			otherwise if the noun heeds currentquip:
				say "[line break]   [if the noun forsakes currentquip]*[end if]";
				say "[currentquip] - [preview of currentquip]";
		say "[line break]";
	otherwise:
		say "[bold type]Things to say to [the noun][roman type][line break]    You can't think of anything at this time.[line break]" (D);

Chapter 3 - Inventory

Section 1 - Taking inventory
	
The print empty inventory rule is not listed in the carry out taking inventory rulebook.
The print standard inventory rule is not listed in the carry out taking inventory rulebook.

[EmptyText is some text that varies. EmptyText is "[line break]   nothing[line break]".]

[We don't want quips showing up in regular inventory]

Carry out taking inventory (this is the quip-based inventory rule):
	if the number of physical things carried by the player is 0:
		say "[We] [are] carrying nothing." (A);
	otherwise:
		now all things enclosed by the player are marked for listing;
		now all quips carried by the player are unmarked for listing;
		say "[We] [are] carrying:[line break]" (B);
		list the contents of the player, with newlines, indented, including contents,
			giving inventory information, with extra indentation, listing marked items only;
	say "[first time][line break][bracket]You can see topics for speaking to others by typing T or TOPICS[close bracket].[line break][only]" (C);

[Carry out taking inventory (this is the quip-based inventory rule):
	say "[We] [are] carrying:";
	repeat with currentitem running through physical things carried by the player:
		now EmptyText is "";
		say "[line break]   [a currentitem]";
	say "[EmptyText][first time][line break][bracket]You can see topics for speaking to others by typing T or TOPICS[close bracket].[only]";
	now EmptyText is "[line break]   nothing";]

Section 2 - Taking topic inventory

[I put this in its own section to make it easier to take out]

Topicing is an action out of world. Understand "t" or "topics" or "thoughts" or "c" or "clues" as topicing.

Section 3 - Actual rules for taking inventory

After printing the name of a quip (called currentquip) when topicing (this is the preview printing rule):
	Say " - [the preview of currentquip]" (A).

Carry out topicing (this is the standard topicing rule):
	repeat with current running through quips carried by the player:
		if current is TargetGiven:
			say "[bracket]The [HasCluesOrTopics]s with an asterisk (*) can no longer be discussed.[close bracket][paragraph break]" (A);
			break;
	let generalcounter be 0;
	repeat with currenttwo running through quips carried by the player:
		if the target of currenttwo is nothing:
			increment generalCounter;
	if generalcounter > 0:
		say "[bold type]General [HasCluesOrTopics]s:[roman type]" (B);
		repeat with currentquip running through all quips carried by the player:
			if Target of currentquip is nothing:
				if every talkative person forsakes currentquip:
					say "[line break]  *";
				otherwise:
					say "[line break]   ";
				say currentquip;
		say "[line break]";
	repeat with current running through talkative people:
		let counterThing be 0;
		repeat with currenttwo running through quips carried by the player:
			if the target of currenttwo is current:
				increment counterThing;
		if CounterThing > 0:
			say "[bold type]Things to say to [the current][roman type]" (C);
			repeat with currentquip running through all quips carried by the player:
				if Target of currentquip is current:
					if currentquip is targetgiven:
						say "[line break]  *";
					otherwise:
						say "[line break]   ";
					say currentquip;
			say "[line break]";
		otherwise:
			if current is the player:
				do nothing;
			otherwise if generalCounter > 0:
				do nothing;
			otherwise:
				say "[bold type]Things to say to [the current][roman type][line break]    You can't think of anything at this time.[line break]" (D);
				
Report topicing (this is the advice on talking to just one person rule):
	say "[We] [can] see just the topics for one person at a time by TALKing TO that person." (A);

Chapter 3 - Topics that apply to everyone

CurrentTarget is a person that varies. CurrentTarget is yourself.

Check uttering something to someone (this is the uttering target assigning rule):
	now CurrentTarget is the second noun;

[You must create your own attributes here, one for each person you can talk to. See example Group Chat for an idea of how to do this.]

Clues and Conversation ends here.

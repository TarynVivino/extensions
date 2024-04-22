
Section: Philosophy

Inform 7 is most successful in its modeling of things (like TAKE, DROP, EXAMINE, etc.) Therefore, this extension creates conversational topics or clues as inventory items, called 'quips', and treats them as much like 'things' as possible.

To avoid confusion, this extension mods the standard inventory to list topics and physical items separately.

Section: How to make topics

Every topic is called a 'quip' (modelled after similar code from Emily Short). The terms 'topic' and 'quip' are used interchangeably in this documentation.

Every quip needs a target. This is the person you can tell it to.

For example:
	
	Accusation is a quip. The target of Accusation is Simba.

Every quip has text called the 'preview'. This is what's shown in your 'Topic Inventory' (which players access by typing TOPICS, CLUES, C, or T).

	Accusation is a quip. The target of Accusation is Simba. The preview of Accusation is "'Murderer!'"

The text displayed when you talk to someone is called the TargetResponse of the quip.

	Accusation is a quip. The target of Accusation is Simba. The preview of Accusation is "'Murderer!'"

	The TargetResponse of Accusation is "'Murderer!' you say.

	'No, no, no no no!' says Simba."

Section: Generic topics

If you want to be able to say the quip to multiple people , you can make the target nothing. This is the default, so you can just leave the target unsaid. These quips are 'generic'.

	Hello is a quip.
	
This lets you say 'Hello' to everyone. There is a variable called CurrentTarget that lets you know who you're talking to, and this can be used for customizing the response.

	Hello is a quip. TargetResponse of Hello is "[if CurrentTarget is Dreary Dan]'Hello!' you say cheerfully.

	'Whatever,' says Dreary Dan.[otherwise]'Hello!' you say cheerfully.

	'Hello,' says [CurrentTarget].[end if]"

If legibility becomes an issue, you can use tables instead.

Section: Remembering conversation

If you want people to remember what happened in a conversation, you can add TargetSummary to a quip. Only quips with a specific target need TargetSummary.

	The TargetSummary of Accusation is "You accused Simba of murder."

If a quip can be discussed with multiple people, the target summary is an automatically generated list of who you've discussed it with.

If you want to be able to discuss a quip with many (but not all) people, you can use the 'heeds' relation to exclude people. For instance:
	
	Cheerful is a quip. Ebenezer Scrooge does not heed Cheerful.

Section: Giving a player a topic to discuss

Use the phrase 'deliver -quip name-' to give a quip to the player. If a player already has the quip, nothing will happen. If they don't have it yet, the game will announce the new quip.

	Hello is a quip.
		
	When play begins:
		deliver Hello;

Section: Talking verbs

The verb for talking is Uttering It To. So if you say the quip Dog to Dan, the game calls it 'Uttering Dog to Dan'.

Section: Repeating a topic

If you want a quip to come back, you can 'renew' it:
	
	Report eating the popsicle:
		renew Hungry;
		
If a quip has a specific target, it can only be said once unless you renew it.

Quips without a target can be said to anyone over and over.

Section: Removing a topic

If you want to take away a topic completely and announce then remove it:
	
	Report taking the dog:
		remove Lost;

Section: Clues

If you use the word 'clue' instead of quips, then the game will refer to quips as 'clues' instead of 'topics'.

	Barking is a clue.
	
Section: Parts of code it messes with

This extension changes the behavior of taking inventory and the command SAY. It uses the abbreviation T and C.

The quips are carried by you, so 'repeat with current running through things carried by the player' will include them. To ignore them, use the adjective 'physical', like:
	
	Repeat with current running through physical things carried by the player:

Section: Having things happen when you talk

You can do this by using 'report uttering something to someone'.

	Report uttering Payment to the shopkeeper:
		now PlayerGold is 10;
		
Quips that have a specific target have a flag called TargetGiven you can check.

	Compliment is a quip. The target of Compliment is Doorman. The preview of Compliment is "'Looking sharp!'".

	The description of the doorman is "The doorman looks [if Compliment is TargetGiven]happy[otherwise]sad[end if]."

Section: Excluding people from talking altogether.

If a person is 'talkative', you can say generic quips to them (one whose currenttarget is nothing). To exclude someone from conversation, you can make them 'not talkative'.

As discussed earlier, to keep a person from talking about a specific generic topic, use the following format:
	
	Cheerful is a quip. Ebenezer Scrooge does not heed cheerful.


Version 5.1.1 of Quip-Based Conversation by Michael Martin begins here.

"An extension to Reactable Quips to allow for more traditional menu-based conversation."

Include Version 10.1 of Reactable Quips by Michael Martin.

[Version 5.1: Update for Inform 10.1 by Nathanael Nerode; just version number changes here and Reactable Quips.]
[Version 5/171116: Update for 6M62 by climbingstars.]
[Version 5: Update for 6E59. Removes references to deprecated features in Inform.]
[Version 4: Update for 5T18. Syntax and documentation updates; Version 3 should still work as long as RQ is the right version.]
[Version 3: Update for 5G67. Fixes an understanding precedence problem between RQ and QBC.  Gives better parser errors if garbage is typed while a conversation is live.]
[Version 2: Update for 4X60. Requires at least version 6 of RQ because previous versions don't work on 4X60.]
[Version 1: Initial release. We require at least version 3 of RQ because we rely on the conditional Understand commands to handle overrides.]

Section 1 - Cancelling ASK, TELL, and ORDERS

Before asking someone about (this is the reject asking for talking rule): clue talking instead.
Before telling someone about (this is the reject telling for talking rule): clue talking instead.
Before answering someone that (this is the reject answering for talking rule): clue talking instead.
Before asking someone to try doing something (this is the reject commanding for talking rule): clue talking instead.

The QBC talking cue is some text that varies. The QBC talking cue is usually "[bracket]Use TALK TO to interact with characters.[close bracket]".

To clue talking:
	say "[QBC talking cue][paragraph break]".

Section 2 - Member fields and default values

A person has a quip called a greeting.  The greeting of a person is usually quip_null.
A person has a table-name called the litany.  The litany of a person is usually the Table of No Conversation.  

[This is the currently active litany.]
The qbc_litany is a table-name that varies.  The qbc_litany is the Table of No Conversation.

Table of No Conversation
prompt	response	enabled
a text	a quip		a number

[QBC is never active if RQ is.]
To decide whether QBC is active:
	if the number of filled rows in the qbc_litany is not zero and not RQ is active, yes;
	no.

Section 3 - Initiating conversations

Talking to is an action applying to one visible thing.  Understand "talk to [something]" as talking to.

Check talking to (this is the can only talk to talkables rule): 
	if the noun provides the property litany and the noun provides the property greeting, do nothing; 
	otherwise say "Generally, it's best to talk to living things." instead.

Check talking to (this is the can only talk to people with things to say rule):
	if the greeting of the noun is quip_null and the number of filled rows in the litany of the noun is zero:
		say "[generic ask quip][paragraph break]" instead.

Carry out talking to (this is the basic talking to rule):
	if the greeting of the noun is not quip_null, deliver the greeting of the noun quip;
	if the number of filled rows in the litany of the noun is not zero:
		now the qbc_litany is the litany of the noun;
		display the QBC options.

[This is for when we have a Reactable Quips-style followup in the middle of a conversation.]
After responding with (this is the revert to normal conversation rule):
	display the QBC options.

To display the QBC options:
	if the story has ended, stop;
	if RQ is active, stop;
	let qbc_index be 0;
	repeat through qbc_litany:
		if the enabled entry is 1:
			increase qbc_index by 1;
			say "[bracket][qbc_index][close bracket] [prompt entry][line break]";
	if qbc_index is not 0, now the number understood is 0;
	otherwise terminate the conversation.

Does the player mean talking to a person: it is likely.

Section 4 - Delivering lines

QBC responding with is an action applying to one number.  Understand "[number]" or "say [number]" as QBC responding with when QBC is active.

Carry out QBC responding with (this is the perform talking rule):
	let qbc_index be 0;
	repeat through the qbc_litany:
		if the enabled entry is 1:
			increase qbc_index by 1;
			if qbc_index is the number understood:
				now the enabled entry is 0;
				deliver the response entry quip;
				display the QBC options;
				rule succeeds;
	follow the RQ out of range rules for qbc_index.

Section 5 - Recaps

QBC recapping is an action out of world applying to nothing.  Understand "repeat" or "recap" as QBC recapping when QBC is active.

Carry out QBC recapping (this is the perform QBC recapping rule):
	let qbc_index be 0;
	repeat through qbc_litany:
		if the enabled entry is 1:
			increase qbc_index by 1;
			if qbc_index is 1, say "[RQ options prologue][paragraph break]";
			say "[bracket][qbc_index][close bracket] [prompt entry][line break]";
	[This "can't happen" but there's no reason to not check.]
	if qbc_index is 0, say "[QBC no conversation error][paragraph break]";

The QBC no conversation error is some text that varies. The QBC no conversation error is usually "[bracket]You are not currently in a conversation.[close bracket]".

Section 6 - Utility functions

To enable the (q - a quip) quip for (o - a thing):
	repeat through the litany of o:
		if the response entry is q, now the enabled entry is 1.

To disable the (q - a quip) quip for (o - a thing):
	repeat through the litany of o:
		if the response entry is q, now the enabled entry is 0.

To enable the (q - a quip) quip:
	repeat through the qbc_litany:
		if the response entry is q, now the enabled entry is 1.

To disable the (q - a quip) quip:
	repeat through the qbc_litany:
		if the response entry is q, now the enabled entry is 0.

To shift the conversation to (t - a table-name):
	now the qbc_litany is t.

To run a conversation on (t - a table-name):
	shift the conversation to t;
	display the QBC options.

To terminate the conversation:
	now the qbc_litany is the Table of No Conversation.

Section 7 - Straightening out the parser

Before printing a parser error when QBC is active and the latest parser error is the didn't understand that number error:
	now the latest parser error is the didn't understand error.

Quip-Based Conversation ends here.

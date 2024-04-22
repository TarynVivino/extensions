Version 10.1.1 of Reactable Quips by Michael Martin begins here.

"A table-based approach to NPC conversation chains, as well as allowing rules to fire on lines of conversation."

[Version 10.1 - Version number update for Inform 10.1 by Nathanael Nerode.  The version number is a coincidence, I swear!]
[Version 10/220523 - Restore the ability to type "3" as well as "say 3".  It works under Inform 10.1 if specified separately.]
[Version 10/220522 - Update for Inform 10.1 by Nathanael Nerode.  Probably will still work with 6M62.]
[Version 10/171116 - Update for 6M62 by climbingstars.]
[Version 10 - Quick patch and update for 6E59, correcting the compilation problems and removing any reliance on deprecated features or syntax.]
[Version 9 - Updated for 5T18, correcting run-time problems and ducking some library bugs.]
[Version 8 - Made it cleaner for clients to check whether or not RQ is active.  Cleaned up the parser errors a little.]
[Version 7 - Remove the ugly hack from version 6 that copes with the 4X60 bug.]
[Version 6 - Add > SAY X syntax to match QBC. Allow delivery of nested quips. Make example clickable.  Basic quipping rule changed to be compatible with 4X60.]
[Version 5 - Made a procedural rule static.]
[Version 4 - Cleanups for indexing.  Rule ordering bugfix.  Removed redundant rules.  Permit current quip to change in a "before quipping" rule.  Reset the number understood when necessary to duck a parser issue.  Add a specification for quips.  Removed ugly hacks to make parser asides work right in versions of Inform predating version 4S08.]
[Version 3 - Replaced parentheses with brackets where appropriate, as is traditional for parser asides.  Removed the "wait silently" action by using conditional "understand" statements instead -- this produces sensible error messages in all circumstances as of version 3T38 of Inform 7.  Expanded documentation to show how default ask and tell quips can be individually universally redefined.  ]
[Version 2 - Modified "if index is the noun" to "if index is the number understood" to compensate for Inform 7's improved type checking in 3R85.  Improved the output of REPEAT, and added RECAP as a synonym.]
[Version 1 - Initial release.]

Section 1 - Quips

A quip is a kind of value.  The quips are defined by the Table of Quip Texts.  The specification of quip is "Represents a line or exchange of dialogue, which may be linked to other quips via followups or linked to ask or tell responses."

The current quip is a quip that varies. The current quip is quip_null.
The pertinent quip is a quip that varies.  The pertinent quip is quip_null.

A person has a quip called default ask quip. The default ask quip of a person is usually quip_null.
A person has a quip called default tell quip. The default tell quip of a person is usually quip_dtell.

Quipping is an activity.  The last for quipping rule (this is the basic quipping rule): say "[quiptext of the current quip][paragraph break]";

To deliver the (q - quip) quip:
	now the current quip is q;
	carry out the quipping activity;
	let rq_index be 0;
	repeat through Table of Quip Followups:
		if the current quip is the quip entry:
			increase rq_index by 1;
			say "[bracket][rq_index][close bracket] [option entry][line break]";
	if rq_index is not 0:
		now the pertinent quip is the current quip;
		now the number understood is 0;
	otherwise:
		now the pertinent quip is quip_null.

To nest the (q - quip) quip:
	let x be the current quip;
	now the current quip is q;
	carry out the quipping activity;
	now the current quip is x.

To decide whether RQ is active:
	If the pertinent quip is quip_null, no;
	yes.

Requesting a recap is an action out of world applying to nothing.  Understand "repeat" or "recap" as requesting a recap when RQ is active.

Carry out requesting a recap (this is the perform recap rule):
	let rq_index be 0;
	repeat through Table of Quip Followups:
		if the quip entry is the pertinent quip:
			increase rq_index by 1;
			if rq_index is 1, say "[RQ options prologue][paragraph break]";
			say "[bracket][rq_index][close bracket] [option entry][line break]";
	if rq_index is 0, say "[RQ no options][paragraph break]".

Responding with is an action applying to one number.
Understand "say [number]" as responding with when RQ is active.

Understand "[number]" as responding with when RQ is active.

[This rule Can't Run, as the Understand commands stand..]
[Carry out responding with when the pertinent quip is quip_null (this is the can't talk out of conversations rule): 
  say "[bracket]BUG: Responded despite there being no conversation options available![close bracket]".]

[Likewise, this test is redundant.]
Carry out responding with [when the pertinent quip is not quip_null] (this is the perform responding rule):
	let rq_index be 0;
	repeat through Table of Quip Followups:
		if the quip entry is the pertinent quip:
			increase rq_index by 1;
			if rq_index is the number understood:
				deliver the result entry quip;
				rule succeeds;
	follow the RQ out of range rules for rq_index.

Before doing something [other than requesting a recap or responding with] when the pertinent quip is not quip_null (this is the force conversation rule):
	unless the current action is requesting a recap or the current action is responding with:
		say "[RQ reaction demand][paragraph break]";
		stop the action.

The force conversation rule is listed first in the before rules.

This is the instant quip reaction rule:
	if RQ is active, rule succeeds.

The instant quip reaction rule is listed before the every turn stage rule in the turn sequence rules.

Section 2 - Hitword-based conversation

The block asking rule is not listed in any rulebook.
The block telling rule is not listed in any rulebook.
The block answering rule is not listed in any rulebook.

Carry out an actor asking someone about something (This is the RQ asking about rule): 
	repeat through Table of Ask Results:
		if the noun is the NPC entry:
			if the topic understood includes topic entry:
				deliver the result entry quip;
				rule succeeds; 
	if the noun is a person:
		say "[quiptext of the default ask quip of the noun][paragraph break]"; 
		rule succeeds; 
	say "[bracket]BUG: Managed to talk to [a noun], who is not a person![close bracket]";
	rule succeeds.

Carry out an actor telling someone about something (this is the RQ telling about rule): 
	repeat through Table of Tell Results:
		if the noun is the NPC entry:
			if the topic understood includes topic entry:
				deliver the result entry quip;
				rule succeeds; 
	if the noun is a person:
		say "[quiptext of the default tell quip of the noun][paragraph break]"; 
		rule succeeds; 
	say "[bracket]BUG: Managed to talk to [a noun], who is not a person![close bracket][paragraph break]";
	rule succeeds.

Carry out an actor answering someone that something (this is the RQ answering that rule): 
	repeat through Table of Tell Results:
		if the noun is the NPC entry:
			if the topic understood includes topic entry:
				deliver the result entry quip;
				rule succeeds; 
	if the noun is a person:
		say "[quiptext of the default tell quip of the noun][paragraph break]"; 
		rule succeeds; 
	say "[bracket]BUG: Managed to talk to [a noun], who is not a person![close bracket][paragraph break]";
	rule succeeds.

Section 3 - Quip Tables

Table of Quip Texts
quip		quiptext
quip_null	"[generic ask quip]"
quip_dtell	"[generic tell quip]"

Table of Quip Followups
quip (a quip)		option (text)		result (a quip)
with 1 blank row

Table of Ask Results
NPC (a person)		topic		result (a quip)
with 1 blank row

Table of Tell Results
NPC (a person)		topic		result (a quip)
with 1 blank row

Section 4 - Straightening out the parser

Before printing a parser error when RQ is active and the latest parser error is the didn't understand that number error:
	now the latest parser error is the didn't understand error.
  
Section 5 - Text overrides

The generic ask quip is some text that varies. The generic ask quip is usually "You can't think of anything to say on that topic.".
The generic tell quip is some text that varies. The generic tell quip is usually "You can't think of anything to say on that topic.".
The RQ options prologue is some text that varies. The RQ options prologue is usually "The available options are:".
The RQ reaction demand is some text that varies. The RQ reaction demand is usually "[bracket]I need some kind of reaction from you to continue the scene.  Enter a number, or say REPEAT to reacquaint yourself with your options.[close bracket]".
The RQ no options is some text that varies. The RQ no options is usually "[bracket]No responses are currently available.[close bracket]".
The RQ out of range rules are a number based rulebook.
An RQ out of range rule for a number (called max) (this is the basic RQ out of range rule): say "[bracket]Valid responses range from 1-[max].  Type REPEAT to relist the options.[close bracket][paragraph break]".

Reactable Quips ends here.

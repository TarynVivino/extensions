Chapter - Why to use

Suppose you're writing an IF story with several compliant characters who do whatever you tell them to.  (Such as Infocom's Suspended.)

When writing an IF story with compliant characters who generally do what they're told, it is somewhat frustrating to type
	John, get the hat
and get the response:
	There is no reply.
When the reason is that there is no hat object.

Inform 7 normally redirects parser errors from commands like this to 'answer <topic>' so that the character can respond to arbitrary statements.  But in an story -- such as Infocom's "Suspended" -- which features compliant characters who the player orders around a lot, this is simply frustrating to a player who has made a typo or conceptual error.

This extension instead reports those parser errors.  It uses variants of the messages from Neutral Standard Responses, adapted to the context of giving other characters orders.  (It depends on Neutral Standard Responses partly because the default responses in the Standard Rules don't work very well for a Suspended-style game focused on ordering other characters around, and partly to use the low-level code there.)

This extension produces the sort of parser errors which would be given to the player by Neutral Standard Responses if she had tried to 'get the hat' herself:
	[You don't need to use the word 'hat' in this story.]
	
For the same reason, it is frustrating in a game with compliant characters to type
	John, wear the white socks
And get the rather useless response:
	John is unable to do that.

This extension provides default unsuccessful attempt responses for various actions to give more informative responses similar to those given to the player, such as:
	John can't wear the socks.
	John isn't holding the socks.
	John is already wearing the socks.
	
So far, "take", "remove", "drop", "put on (supporter)", "insert into (container)", "wear", "take off (clothes)", and "give" actions are implemented.  This is because I was writing a dress-up game where characters can be ordered to change clothes.

I haven't finished the rest of the verbs yet, though I plan to.

Chapter - How to Use

First, download:
	Neutral Standard Responses by Nathanael Nerode
	and this extension

Then add to your story file:
	Include Compliant Characters by Nathanael Nerode.

You will still have to write a persuasion rule (as documented in Writing With Inform), such as:
	Persuasion rule for asking John to try taking or removing or dropping or putting on or inserting into:
		persuasion succeeds.
	Persuasion rule for asking John to try wearing or taking off or giving:
		persuasion succeeds.

You'll also still need to write an implementation for the verbs which aren't implemented in the standard rules; but many are implemented in the Standard Rules.

Chapter - Notable restrictions

One additional restriction has been added.  A character can't pick up an enterable container which contains a person.  This is to avoid certain rather tricky situations where a person is inside a container carried by another person, which requires a complicated implementation to work right.

Chapter - Additional Ways To Give Orders

If the characters in your story are mostly there to be ordered around, it's nice if several ways of giving orders work.  While "character, command" has been the standard for a long time, Zork II used a completely different syntax -- 'tell robot "command"', which is perhaps more natural.

This extension translates
	say "command" to person [with the quotes]
	tell person "command" [with the quotes]
	order person to command
	instruct person to command
	tell person to command

Into the standard form:
	person, command
	
It also catches and rejects
	person, order/instruct/tell other person to command
	tell person to tell other person to command

It won't catch
	tell person "other person, command"
	say "other person, command" to person

These will turn into
	person, other person, command

And then fail with the usual error for that.

You can disable all of these with:
	Volume - Disabled (in place of Volume - Additional Ways To Give Orders in Compliant Characters by Nathanael Nerode)

Chapter - Holdall Enhancements

This extension makes sure a message is emitted for an actor putting something in the actor's holdall, which it isn't in the Standard Rules.

It also allows the actor to put things in the holdall to make room for clothes being removed, which was previously a missing implicit action.  (This is out of scope for this extension, perhaps, but I did it anyway.)  Likewise, someone can now put things in their holdall to make room for gifts.

Chapter - Giving

As you might expect, compliant characters accept gifts and give gifts when ordered to.  This extension eliminates the "block giving" rule and gives parser error feedback for all other gifts.

However, to avoid some real complications, a character cannot give an enterable containing a person to another person.  This is usually impossible because the character couldn't take the enterable in the first place, but if the author has overridden that, the giving rules still prohibit it.

Chapter - How to change and extend the extension's behavior

Section - Getting in before the parser errors are printed

This sort of rule is where the parser messages are printed:
	Check an actor answering something (called commandee) that when the latest parser error is the can't see any such thing error:
		say "[The commandee] can't see any such thing.";

This also short-circuits the answering process; no carry out answering or report answering rules will be run.

If you make your own check answering rules, they will go before the rules in this extension and can overrride them.  If your own check answering rule returns success, it will allow the carry out answering and report answering rules to take place.

By default the report answering rulebook contains one rule, the "block answering rule", which simply says "You speak."  But if you write your own rules, you can use this technique to allow a character to respond to one specific arbitrary topic which isn't a command (such as "veronica, 17") -- while still using this extension to check for parser errors all other commands given to veronica.

Section - Making your own unsuccessful attempt rules

Unsuccessful attempt rules are the way to get helpful "John can't wear the refrigerator" messages rather than generic "John can't do that" messages.

You may have to do this for additional verbs which I have not implemented, especially for verbs which you have given a lot of custom behavior.

There are several undocumented gotchas in doing this relating to default rulebook behavior.

Unsuccessful attempt rules which return *no decision* will pass along to the next rule, and will eventually pass through to the default "Jane can't do that" response.  ("rfalse" in I6.)
	make no decision;
But if the rule succeeds it will suppress the default response.  ("rtrue" in I6.)
	rule succeeds; [Suppresses default message]
And if the rule fails it will ALSO suppress the default response! ("rtrue" in I6.)
	rule fails; [Suppresses default message]

Extremely unfortunately, the default outcome for an unsuccessful attempt rule is success.  (This was checked by reading I6 generated source code).  This means that the default response is suppressed by the mere existence of a rule, even if it does nothing.  So this code doesn't work:
	if the reason the action failed is:
		-- the can't take off what's not worn rule:
			say "[The actor] [aren't] wearing [the noun]." (A);
Instead, it will end action processing completely, and give no output if the action failed for any reason other than the can't take off what's not worn rule -- not desirable.

So whenever you don't match your special cases and want to pass along to the default rule, you must EXPLICITLY "make no decision".

It gets worse if you use a switch statement, like this (using an explict make no decision):
	if the reason the action failed is:
		-- the can't take off what's not worn rule:
			say "[The actor] [aren't] wearing [the noun]." (A);
	make no decision;
			
The compiler adds an implicit otherwise which ends the rule.
	if the reason the action failed is:
		-- the can't take off what's not worn rule:
			say "[The actor] [aren't] wearing [the noun]." (A);
		-- otherwise:
			rule fails;
	make no decision;
	
This breaking your fallback to the default!  So you must explicitly write this:
	if the reason the action failed is:
		-- the can't take off what's not worn rule:
			say "[The actor] [aren't] wearing [the noun]." (A);
		-- otherwise:
			make no decision;

This actually works and is the form you should use.  The actual code in this extension is:
	Unsuccessful attempt by an actor taking off (this is the actor failed to take off rule):
		if the reason the action failed is:
			-- the can't take off what's not worn rule:
				say "[The actor] [aren't] wearing [the noun]." (A);
			-- the can't exceed carrying capacity when taking off rule:
				say "[The actor] [are] carrying too many things already." (B);
			-- otherwise:
				make no decision;

If you've already printed a failure message in a check rule, you'll need to suppress the unsuccessful attempt message, such as this example:
	Check an actor giving something enterable to (this is the don't accept things with people in them rule):
		if the noun contains a person:
			if the second noun is the player:
				say "[The noun] [look] too heavy for [us] to carry." (A);
			otherwise if the actor is the player:
				say "[We] [offer] [the noun] to [the second noun], but [the second noun] [decline], saying '[The noun] [look] too heavy to carry.'" (B);
			otherwise if actor is visible:
				say "[The actor] [offer] [the noun] to [the second noun], but [the second noun] [decline], saying '[The noun] [look] too heavy to carry.'" (C);
			stop the action;

	Unsuccessful attempt by someone trying giving something enterable to:
		if the reason the action failed is the don't accept things with people in them rule:
			do nothing; [We have already emitted the error message.  Avoid a bogus "John is unable to do that."]
		otherwise:
			make no decision.
				
If you want to override the rules in this extension, make sure your rules are listed earlier in the unsuccessful attempt rulebook.

Chapter - Say, Tell, Answer, etc.

In addition to the usual "Jane, go north", several other ways to issue orders are implemented for player convenience:

	tell Jane to go north
	instruct Jane to go north
	order Jane to go north
	
These all pass through the "ordering it to" action in the Check stage, which rewrites it as "Jane, go north" and tells it to reparse.  You can intercept it first if you like:
	Check ordering something (called target) to (this is the new ordering rule):
		... [you can use "the topic understood" for the potential order]
	The new ordering rule is listed before the reparse as command rule in the ordering it to rulebook.

Several other methods of talking are also rewritten as commands:
	say go north to Jane
	speak go north to Jane
	answer go north to Jane
	shout go north to Jane
	
These, however, are first run through the "speaking it to" action, which redirects to the "ordering it to" action.  So you can intercept only these if you like; perhaps you don't want these to be processed as orders:
	Check speaking to something (called target) (this is the new speaking rule):
		... [you can use "the topic understood" for the potential order]
	The new speaking rule is listed before the redirect speaking to ordering rule in the speaking it to rulebook.

The reparse as command rule will also strip quotation marks from the topic, so it can successfully handle:
	tell Jane to "go north"
	instruct Jane to 'go north'
	say "go north" to Jane
	answer 'go north' to Jane
	shout "go north" to Jane

...et cetera.


Section - Stripping quotation marks from a topic

In addition to its use within the reparse as command rule, stripping quotation marks from "the topic understood" may be a generally useful thing to do.	Accordingly, it is provided as a say-phrase:
	[the/-- quote-stripped topic understood]

This will turn all of the following:
	"foo bar"
	'foo bar'
	foo bar
into the same "foo bar" (without quotation marks).

Section - Non-Commands

Even in a game with a lot of commands, you may want to handle some things not as commands.  Note that the following will not be handled as commands; this extension does not change their behavior at all:
	ask Jane about topic
	tell Jane about topic

More interesting are these cases:
	say password to Jane
	tell Jane password
	Jane, password

These will all end up in the "answering it that" action, and will be processed by this extension as a command, finally coming up with a parser error (assuming password isn't a verb!).
You can deal with this in one of three ways.

First, you could make password a verb.

Second, you can intercept "answering it that" before this extension gets to it, just for the word "password".  Note the British spelling of recognise in the error name:
	Check an actor answering something (called the commandee) that when the latest parser error is the not a verb I recognise error (this is the divert the password rule):
		let tmp be a text;
		now tmp is "[quote-stripped topic understood]";
		if tmp exactly matches the text "password":
			try passing the test with the commandee instead;

	Passing the test with is an action applying to one thing.

	Report passing the test with something (called the commandee):
		say "[Commandee] accepts your password!";

Third, you could intercept "answering it that" for all unknown verbs.  Again, remember the British spelling of recognise:
	Check an actor answering something (called the commandee) that when the latest parser error is the not a verb I recognise error (this is the divert the password rule):
		let tmp be a text;
		now tmp is "[quote-stripped topic understood]";
		if tmp exactly matches the text "password":
			try passing the test with the commandee instead;
		otherwise:
			try giving incorrect password the topic understood to the commandee instead;

	Passing the test with is an action applying to one thing.

	Giving incorrect password it to is an action applying to one topic and one thing.

	Report passing the test with something (called the commandee):
		say "[Commandee] accepts your password!";

	Report giving incorrect password to something (called the commandee):
		say "[Commandee] says, 'Sorry, ['][the quote-stripped topic understood]['] is not the right password.'";
		
Note that in this context, the topic understood is the entire statement given to the commandee.  So if you write "Jane, alpha beta gamma", the topic understood will be "alpha beta gamma".  So you can check for multi-word passwords.

Section - Disabling rules

Obviously, you can also turn off or replace the enhanced holdall rules or the rules prohibiting taking enterables containing people, by the usual methods described in Writing With Inform: "not listed in any rulebook" or "listed instead of".

The additonal ways to give orders can be disabled as noted above.

Chapter - Interactions with other Extensions

This version of this extension depends on version 5 or later of Neutral Standard Responses by Nathanael Nerode; it uses low-level code from that extension and reuses some of those responses (so that the story author only has to override the response in one place).
This version of this extension depends on Inform 10.2 for its support hooks and support for switch/case statements based on rules.
This version of this extension depends on Reparse by Nathanael Nerode for those low-level reparsing tricks.

Chapter - Changelog

	5.5.240121 - Break out Reparse as a separate extension, and include it.
	5.4.240115 - Use "configuration flag" syntax from newest version of Inform.
	5.3.240114 - Patch to prevent turn count from advancing when reparsing.
	5.2.230729 - Change "CONSTANT" to "Constant" to compile under Inform 10.2.
	5.2.230728 - Revert changes necessary due to bug in released version of Inform 10.1 but fixed for 10.2.
	5.1.230727 - Large changes needed to work around bug in released version of Inform 10.1
	5.0.220604 - Small documentation fixes
	5.0.220524 - Format Changelog
	5.0.220523 - Documentation changes and cleanup now that patches to core Inform aren't needed.
			- Requires Inform 10.1 compiled after 23 May 2022.
			- (this was very early in the beta phase for Inform 10.1, so most copies will be fine.)
	5.0.220521 - Adaptation to Inform 10.1.0 -- requires patch to Inform.
	4/210328 - Slicker handling for "say take box to jane".
			- Much slicker and faster handling for "say 'x' to jane" and other quotation marks typed by the player.
			- Documentation of ways to handle passwords and similar special cases.
			- More Chapters, Volumes, Parts, etc. for better overriding.
	3/210313 - Additional handling for "say 'x' to jane", "tell jane 'x'"
			- Additional handling for indirect orders
			- Additional handling for "jane, take all"
			- Additional handling for other corner cases
	2/171007 - Update in association with version 4 of Neutral Standard Responses
			- Fix misunderstood word reporting.
			- Fix several tricky paragraph break errors.
	1/171003 - Fix line break issue in scenery message.
	1/171002 - First version.


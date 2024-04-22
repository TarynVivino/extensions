Every Inform project contains dozens of sentences of text not written by the project's author, which explain the results of actions or refuse to carry out commands that aren't understood or that contradict the world model. The default set of these library messages, which have accumulated like barnacles on the interactive fiction community since its maiden voyages in the 1970s, contains many misleading, distracting, or unhelpful texts that experienced players see past but newcomers stumble over. This extension replaces the worst offenders with more neutral or helpful variations.

Simply including the extension is all that is necessary. Read on only if you're interested in the gory details.

Section - Rationale

The main complaints levied against the standard reponses are:

They sometimes imply a certain tone of wry amusement which descends from the Infocom/text adventure era, and which is not always appropriate to modern works of IF.
	
There is not a clear distinction between messages narrating story world events and those giving parser refusals, leading to a muddying of the difference between the author's voice and the default system messages.
	
Error messages often do not contain information instructing players how to better restate their command.
	
They can sometimes contradict the story world, as in the assumption "That's plainly inedible," or mislead the player about a course of action, as in "This dangerous act would achieve little."
	
Inconsistencies in style, such as whether command examples are given in CAPS or 'quotes', or which messages are wrapped in square brackets and what that signifies.

The extension attempts to address all of these concerns as much as possible. Jokes or insults have been replaced by more neutral responses.  Many error messages have been rephrased to more clearly state what confused the parser or instruct the player towards a better command to try. Messages that make assumptions about the player's intentions or the world model have been softened so as not to appear incongruous with the story. All command examples are now given in 'quote' format.  And by default, all parser / out-of-world messages are wrapped in brackets and put in italics.

Section - Noncommittal responses

Many of the replacement responses in this extension are deliberately noncommittal, in order to be appropriate no matter what the story author is doing.  This is in order to deal with commands like "pick up Fred", where the player may be using it in a metaphorical way and the story author may want the player to go through the steps of seducing Fred.  Or "attack box", where the story author may want the player to be more specific about how to attack the box.  These responses in this extension often use the following two phrases:
	To say or that's not the way: say ", or [regarding nothing]that [aren't] the way to do so".  [this is ", or that's not the way to do so" in the present tense]
	To say or it's the wrong time: say " in these circumstances".
	
If you want to be more definite about telling the player that she is unable to do things, you can blank these out:
	To say or that's not the way: do nothing.
	To say or it's the wrong time: do nothing.

Section - Parser Style versus Story Style

Whether a message comes from the parser or the story narrator is something of an existential or aesthetic question in some cases: is "But you aren't on the sofa at the moment" a parser objection or a narrator observation?

The rule in this extension is that only out-of-world, metatextual responses are "parser messages".  This consists of responses which break the fourth wall by talking about the command line, saving, restoring, undoing, or talking about what is permitted in the story.  So "You hear nothing unexpected" and "You aren't holding the apple" are both story messages, while "You don't need to use the word 'xxx' in this story" is a parser message.

Parser messages are styled using a pair of phrases, which must always be used as a pair:
	"[as the parser]I didn't understand that command.[as normal]"

These are the default definitions:
	To say as the parser -- beginning say_as_the_parser: say "[italic type][bracket]".
	To say as normal -- ending say_as_the_parser: say "[close bracket][roman type]".
	
To override this, use code like the following:

	To say as the parser -- beginning say_as_the_parser: say "[bold type]The parser says: '".
	To say as normal -- ending say_as_the_parser: say "'[roman type]".
	
These say statements may be used in your own text to style parser messages.  With a bracket following a period at the end of a sentence, Inform's line breaking algorithm gets confused, so it's often necessary to write:
	say "[as the parser]Hi, I'm the parser.[no line break][as normal][line break]".

Or if you're running the paragraph on:
	say "[as the parser]Hi, I'm the parser.[no line break][as normal]".
	
One final subtlety:  if you're responding to an action like "take" which has a paragraph break after "take one thing" but not after each line in "take all", you'll want to use an additional phrase "single action conditional paragraph break" (see the section on line breaking):
	say "[as the parser]You shouldn't try to take that in this story.[as normal][single action conditional paragraph break]";

Section - Overriding Responses

If you don't want parser messages to be styled differently from other library messages:
	To say as the parser -- beginning say_as_the_parser: do nothing.
	To say as normal -- ending say_as_the_parser: do nothing.

Of course, all responses can be individually overridden using the usual responses system.

Section - Use Different Line Breaking in Multiple Object Lists

This extension provides several utility phrases to allow you to make the same text line-break correctly both for multiple action reports like:
	the box: (putting the toy in the holdall to make room) Taken.
	the cat: You can't take the cat.
	
	>

And on single action reports like:
	(putting the toy in the holdall to make room)
	Taken.
	
	>

The say phrases available are:

	single action line break

This is a line break if doing a single action, and no line break if doing multiple actions.  I haven't actually found a use for this:

	single action conditional paragraph break

This is a conditional paragraph break only if there is a single action.  This corrects the report for:
	the box: You can't boil the box.
	the cat: Boiled.

	single action paragraph break

This is a paragraph break only if there is a single action.  I haven't actually found a use for this, as the single action conditional paragraph break is more useful.

	multiple action run paragraph on

This could be used where Inform really wants to break the paragraph.  For multiple actions, it runs the paragraph on; for single actions, it doesn't.  I haven't found a use for this either.

	single action command clarification break

This is one space if doing multiple actions, and otherwise a command clarification break.  The purpose of this is specifically to avoid a line break in the following:
	the box: (Putting the toy in the holdall to take room) Taken.

It should generally be used only for such situations.

Section - You can't see any such thing

The message "You can't see any such thing." is traditionally printed in many circumstances.  Part of the difficulty is the wide variety of circumstances it can appear under. From the player's perspective, this message appears when she tries to use a verb with
	a) something neither mentioned nor implemented (like the sky)
	b) something mentioned in descriptive text but not implemented
	c) something implemented but not given the specific word used as a synonym
	d) a misspelled word
	e) a word mistakenly understood as part of the direct object, rather than part of the grammar line, as in >TAKE INVENTORY NOW which is matched as {take | inventory now}.
	f) something that exists but has never been seen and is not in scope
	g) something previously seen but no longer in scope, perhaps without the player realizing it's no longer available

In nearly all of these cases, the player believes the object they're referring to should exist, meaning the message is often frustrating.

Distinguishing between these subtle cases can be difficult. For instance, short of capturing all text output and analyzing it, there is no way to distinguish A from B. Perhaps the easiest distinction to make is between commands containing dictionary words and those that don't, which separates A-D from E-G.

This extension, by default, explicitly tells the player if a word they typed is not in the story's dictionary. The classic argument against this, that sneaky players can use it to figure out the existence of yet-unseen objects, seems less relevant today than it did when puzzles comprised most IF content (not to mention having something of a nanny-state quality, like a novelist hovering around ensuring readers don't flip ahead and see IMPORTANT NOUNS they aren't supposed to know about yet). Perhaps a more relevant objection is that messages of this sort can make the parser seem primitive ("I don't know the word 'love.'")  I believe the benefit to players of knowing that a command didn't work because a certain word isn't important (rather than wondering if it's just not in scope, or they misspelled it, or they typed it in the wrong spot in the grammar line) outweighs these concerns, and I've attempted to make the message prescriptive rather than expository: "You don't need to use the word 'love' in this story." However, if you'd like to restore the traditional behavior, you can do so with 'Use traditional can't see any such thing'.

If the parser fails because it doesn't recognize a word, this extension will give an informative error message like:
	"[You don't need to use the word 'kludge' in this story.]"

You can change this to, for instance, the traditional Infocom-style message as follows:
	The command includes word not in dictionary rule response (A) is "I don't know the word '[word at position N]'".

In the response's context, "word at position N" is the first non-dictionary word.
This helps out players who know not to try the word again.

If the word is recognized but out of scope, the parser will instead say:
	"You can't see anything called 'kludge' right now.  [Or I misunderstood you.]"

You can change this as follows:
	The command includes word not in scope rule response (A) is "Naughty player, referring to things you can't see such as [the misunderstood word]."

In the response's context, "the misunderstood word" is the first word not understood by the parser; it's the word which will be replaced by "oops".
In certain responses, this isn't valid; use "the extraneous word" instead in those responses.

If you want to conceal from the player which words are understood, you can restore the default Inform 7 message:
	You can't see any such thing.

by using the option
	Use traditional can't see any such thing.
	
In addition, the Standard Rules have a bug in the 'remove thing from container' implementation which results in "You can't see any such thing" being printed for items which are visible but not inside the container.  This extension fixes this bug and gives the proper responses for that case.  This is fixed whether or not you "Use traditional can't see any such thing".

Section - Further ideas for 'You can't see any such thing'

Several additional extensions can help break things down further. "Remembering" carves off G from E-F, while "Poor Man's Mistype" can sometimes address D. "Smarter Parser" can sometimes offer helpful messages for certain types of A command related to body parts and common environmental features like the sky. Eric Eve's Text Capture could be a tool in distinguishing A from B.

"The word 'sky' doesn't refer to anything right now" is used by TADS3.

Another option is "Here are some things you can see: [the list of visible things which are not the player]."

Section - Compatibility with Other Extensions

This incorporates, and updates, the entirety of Neutral Library Messages by Aaron Reed, Unknown Word Error by Mike Ciel, Unknown Word Error by Neil Cerutti, and Dunno by Neil Cerutti.  It is incompatible with all of these extensions; do not include them.

Some of the response replacements, particularly those where multiple responses were used to build a single sentence, were significantly more difficult to implement than others and involved hacking into I6 code.  These are in separate volumes and chapters; these can be individually replaced if they are causing trouble.  The "Standard Responses" volume should be safe in any case.

I strongly recommend the "Tab Removal" extension.  This replaces tabs with spaces in commands typed by the player.  Without it, error messages for commands containing tabs are quite cryptic.

The "Compliant Characters" extension depends on Neutral Standard Messages.  It enhances error messages for commands given to other characters.  With Compliant Characters, if the persuasion rules succeed a command like
	Jane, take blox

will give a response like
	[You don't need to use the word "blox" in this story.]

or
	Jane already has that.

or
	Jane can't take that because that seems to belong to you.

instead of the unhelpful default:
	Jane is unable to do that.

Compliant Characters is a separate extension because it is intended for stories where you want the *story* to give responses to mistyped or illogical commands, while some games may prefer that the *character* give responses in character (which is the Inform 7 default assumption).

Section - Extension History

This extension is based on Neutral Library Messages by Aaron Reed.  Aaron wrote many of the changed responses.  Aaron also wrote most of the documentation (athough I have made some substantial edits).  However, Neutral Library Messages stopped working when Inform 7 created the "responses" system.  Adapting to the responses system required a nearly complete rewrite.

I (Nathanael Nerode) took the opportunity of the rewrite to do a complete reorganization.  The response replacements are now in the source code in the order produced by the "responses 1" command, for ease of updating with future versions of Inform.  Additional messages were fixed and some of Aaron's neutral messages were made even more neutral.

I also made one philosophical design change.  Messages are styled "as the parser" if they are metatextual.  Discussing save, restore, undo, or command errors is metatextual: these are things which explicitly talk to the player and not to the player character.  Telling the player that the player does not need to do something in this story is also metatextual -- giving the player meta-information.  Messages are not styled as the parser if they reflect logical errors which the player character might make which are within the world model (such as trying to put a box inside itself), which they were in Aaron's version.

Section - Changelogs

Neutral Standard Responses:
	Version 6.2.240303: Repair "remove all from container" responses
						while retaining improved message for "remove cat from box" when cat isn't in box.
	Version 6.1.240129: Improved responses for "burn" and "think".
	Version 6.0.240114: Use "as a configuration flag" syntax from new version of Inform.
	Version 6.0.230722: adapt to new (work in progress) version of Inform.
	Version 5.0.220521: adapt to Inform v10.1.0.
	Version 4/210908: in several rule responses, changed "here" to "[here]" (which will only ever matter outside of present tense) -- ZL
	Version 4/171007:
		Add line break helper phrases and documentation.  Fix several tricky line break errors correctly (including some from the Standard Rules).
		New and much better I6 method for determining the misunderstood word and for determining whether it is a dictionary word.
		Major fixes to "You can't see that" responses.  Fix error on "take all but (item not in play)".
		Repair bug in the Standard Rules implementation of Remove (which gave misleading error messages).
		Set oops target on additional errors which didn't set it.
	Version 3/171002: Line break fix.
	Version 3/171001: Remove parser voicing from attack, throw, and kiss.  Name the unrecognized verb in the error message.  Redirect bogus message triggered only on 'get 100 items'.
	Version 3/170927: Fixes to two bugs reported by Daniel Stelzer.
	Version 3/170926: Incorporated remaining "difficult" features of Neutral Library Messages.
	Version 2: Unreleased: complete code rewrite to improve maintainability, included all straightforward message replacements.
	Version 1: Unreleased: adapted Neutral Library Messages to responses system.

Neutral Library Messages:
	Version 3: Modified NPC action rejections to use the same verb the player typed in cases where this could be confusing (hug mapping to kiss).
	Version 2: Fixed bug in misc message 72 to use "the person asked" instead of "the noun"; clarified documentation.

Unknown Word Error:
	Version 2 by Mike Ciul corrected a problem with the "undo from" referent.
	Version 1 by Neil Cerutti was a wrapper of Dunno.

Dunno - A Library Extension by Neil Cerutti (cerutti@together.net) for Inform 6
	Version 1.1 - 2 Apr 2001: Modified by Andrew Plotkin for Glulx compatibility.
	Version 1.0 - 25 Jun 1999: Initial release.


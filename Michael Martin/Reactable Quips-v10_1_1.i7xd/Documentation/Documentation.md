Reactable Quips provides a table-driven conversation system for NPCs that allows a mixture of traditional ask/tell and menu-based systems.  The intended model is that under normal circumstances, the player character may initiate conversation by asking or telling an NPC about a topic.  That NPC will then respond.  However, NPCs may occasionally say or do things that demand or imply some kind of reaction from the PC -- the player must then choose some option off a menu to characterize the reaction.

Regardless of the intended model, it is quite possible to use the extension to implement a pure ask/tell system.

Section: Defining and firing off quips

The most fundamental concept in the extension is the "quip".  Quips are values, not things; they are used to index into the quip tables.

Thus, the one task we must always perform is filling in the Table of Quip Texts.  A default table is provided by the extension, so you will need to continue the table in your own code:

	Table of Quip Texts (continued)
	quip	quiptext
	greeting	"'Why, hello there!'"
	discuss weather	"'Looks like rain, or my name isn't George Washington.'"
	standoff	"'What's it to you, Mac?'"

We then (if we are using the ask/tell model) use the Table of Ask Results and Table of Tell Results to attach quips to NPCs and topics.  The topics may be patterns, much like understanding commands as actions are.  However, the library will match against any text that contains the topic (much like the "Complimentary Peanuts" example in the Recipe Book).  The results are quips.

	Table of Ask Results (continued)
	NPC	topic	result
	Bob	"weather" or "nice day"	discuss weather

	Table of Tell Results (continued)
	NPC	topic	result
	Bob	"hi/hello"	greeting

People have a "default ask quip" and "default tell quip" that can be used to give a generic response to unknown topics.  This defaults to the first two quips in the table, which are predefined to "You can't think of anything to say on that topic."  If you wish to universally redefine either of these, redefine the globals "generic ask quip" or "generic tell quip".   See also "Customizing parser messages", below.

We can also script quip delivery:

	Instead of examining Bob, deliver the greeting quip.

Section: Attaching rules to quips

Quips can be attached to rules; however, quips aren't things, and so can't be treated as "something" or "anything."  Instead, we use rulebooks associated with the quipping activity:

	Before quipping when the current quip is greeting: say "You walk up and say hello."

Quips may require a reaction.  Possible responses (and the quips those responses lead to) are stored in the Table of Quip Followups:

	Table of Quip Followups (continued)
	quip	option	result
	greeting	"Make small talk"	discuss weather
	greeting	"Get down to business"	standoff

If a quip is in the table of quip followups, the game will not progress until a choice has been made.  If a quip does not appear in the table of quip followups, then after delivering the quip, normal gameplay resumes.

If you want to check on your own whether or not a response is being awaited, the condition to check is:

	if RQ is active

Section: Customizing parser messages

Most of the text produced by Reactable Quips can be modified.  The two most probable things to change are the "generic ask quip" and the "generic tell quip", which are the default message when you ask or tell/answer about a topic a person has no defined response to.  Both default to "You can't think of anything to say on that topic."

If the player attempts something that is not selecting a reaction when a reaction is required, the parser will usually reply with "[I need some kind of reaction from you to continue the scene.  Enter a number, or say REPEAT to reacquaint yourself with your options.]" To change this message, reassign "the RQ reaction demand."

If the player requests a recap of his options, it will preface the options with "The available options are:". To change that text, reassign "the RQ options prologue".  Ordinarily this can only happen when a reaction is pending, but in case it doesn't, the "RQ no options" text will be printed. This defaults to "[No responses are currently available.]".

If you wish to rewrite the error message for an invalid number, you will need to replace "the basic RQ out of range rule".  The RQ out of range rules operate on numbers; the number received is the maximum valid value at the time of the error.  Here is the entirety of the basic rule, for use as a template:

	An RQ out of range rule for a number (called max) (this is the basic RQ out of range rule): say "[bracket]Valid responses range from 1-[max].  Type REPEAT to relist the options.[close bracket][paragraph break]".


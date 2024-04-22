Quip-Based Conversation builds upon the Reactable Quips extension to provide a table-driven conversation system for NPCs smoothly handles Photopia or LucasArts-style conversation menus.  The player character may initiate conversation with a >TALK TO NPC command.  After an optional greeting exchange, the player selects dialogue from a menu.  Options may become available or unavailable as a result of these statements.  The basic functionality of Reactable Quips is retained; NPCs may occasionally say or do things that demand or imply some kind of reaction from the PC -- the player must then choose some option off a new menu to characterize the reaction.  After the reaction is selected, the traditional menus return.

Section: Defining quips

The most fundamental concept in the extension is the "quip".  Quips are values, not things; they are used to index into the quip tables.

Thus, the one task we must always perform is filling in the Table of Quip Texts.  A default table is provided by the extension, so you will need to continue the table in your own code:

	Table of Quip Texts (continued)
	quip	quiptext
	greeting	"'Why, hello there!'"
	discuss weather	"'Looks like rain, or my name isn't George Washington.'"
	standoff	"'What's it to you, Mac?'"
	silence	"You decide to remain silent for the moment."

Section: Making people talk

People have a "greeting" which is a quip that is delivered when you TALK TO them.  This defaults to the internal value "quip_null" which will result in no greeting and all, moving straight to options.

People also have a "litany" which is a table that holds their actual conversational options.  This defaults to the Table of No Conversation, in which no options are presented at all.  Other litanies have three columns: "prompt" - a string indicating the player's prospective line of dialogue; "response" - a quip that is the NPC's reply; and "enabled", a number that should be 1 if the line is available the first time the character is spoken to, and 0 otherwise.

	George is a man in the Cherry Orchard.  The greeting of George is greeting.  The litany of George is the Table of George Conversation.

	Table of George Conversation
	prompt	response	enabled
	"How's the weather look?"	discuss weather	1
	"How're your teeth doing?"	standoff	1
	"Say nothing"	silence	1

Rules may be attached to quips as usual; see the Reactable Quips documentation for how this works in detail.  Briefly, we use rulebooks associated with the quipping activity, and refer to the variable "the current quip" to determine which ones are in use.

A wide variety of phrases are available for use in these rules; most relevant are "enable the X quip" and "disable the X quip", where X is the name of the response quip you wish to make available in the current litany.  If you wish to enable or disable quips in other litanies, you may "enable/disable the X quip for Y" where Y is the name of the person in whose litany you wish to modify the option.  To modify or eliminate the default conversation characteristics of a character, the greeting or litany may be changed normally with commands like "change the litany of X to Y" -- however, changing the litany of a character will not modify the current conversation.  To modify that, you instead "shift the conversation to X".  To run a conversation without an attached person, you may "run a conversation on X".  This will not deliver a greeting quip.  Finally, when talking is done, one may "terminate the conversation".  This is an appropriate reaction to good-bye or say-nothing quips, depending on how they are handled.

Quips disable themselves by default when used.  For permanent quips (such as "say nothing", above), we must re-enable them by hand:

	After quipping when the current quip is silence: enable the silence quip.

If "silence" is shared across NPCs, this one rule will work for all of them.  For custom farewell quips, individual rules will be used.

Section: Intermingling conversation with other activities

Quips in a litany may have followups defined as per Reactable Quips; see the Reactable Quips documentation for details on how this works.  Note that while Reactions require a response from the player, ordinary conversation does not.  This is a departure from the Phototalk model, but tracks more modern works such as City of Secrets or Beyond.  If you wish to require conversation to continue until stopped, include the following code in your project.

	Before doing something when QBC is active (this is the QBC force conversation rule):
		unless the current action is QBC responding with or the current action is QBC recap, say "[bracket]I need some kind of reaction from you to continue the scene.  Enter a number, or say REPEAT to reacquaint yourself with your options.[close bracket][paragraph break]" instead.

	The QBC force conversation rule is listed first in the before rules.

This code may change across versions of Quip-Based Conversations, so if you upgrade mid-project, check this section again.  Also, make sure that all conversations have some option that that both re-enables itself and terminates the conversation, or players will get stuck!

If you keep the default, interruptible conversations, you will need to ensure that conversations terminate when the PC and the NPC being spoken to are no longer in the same location.  If NPCs do not move, a simple

	Before going: terminate the conversation.

will suffice; terminating a conversation that is not in progress is harmless.  If you wish to check to see if you are in a conversation, as we did above in the force conversation rule, the condition to check is

	if QBC is active

Section: Customizing messages

QBC builds upon Reactable Quips, and so most of the text customizations available there also apply to QBC. The most relevant are the "generic ask quip", which is printed if the player attempts to speak to an NPC whose litany is entirely exhausted and who has no greeting defined, and the RQ out of range rules, which are followed on invalid input.

QBC also defines two new text variables: The two new ones are the "QBC talking cue" - the hint to the player that TALK TO is the preferred verb for conversation - and the "QBC no conversation error", which is printed if a recap is forced when no conversation is active. The latter is unlikely to see use in normal circumstances.




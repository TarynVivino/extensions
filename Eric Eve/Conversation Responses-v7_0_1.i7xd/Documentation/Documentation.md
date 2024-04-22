Section: Various Responses

Conversation Responses allows response rules for various conversational commands to be written in the following forms:

	Response of Bob when asked about Bob:
	Response of Bob when asked about "life":
	Response of Bob when told about "[money]":
	Response of Bob when asked about a container:
	Response of Bob when asked about something fixed in place:
	Response of Bob when told about Jim:
	Response of Bob when shown the wallet:
	Response of Bob when given the wallet:
	Response of Bob when asked for the wallet:
	Response of Bob when asked for "sympathy":
	Response of Bob when anwered that "probably":
	Response of Bob when saying yes:
	Response of Bob when saying no:
	Response of Bob when saying sorry:

This may seem to have little advantage over writing rules like "After asking Bob about life", but it also allows the following forms for ask/tell or give/show:

	Response of Bob when asked-or-told about "life":
	Response of Bob when asked-or-told about the wallet:
	Response of Bob when given-or-shown the gold coin:

It also avoids using the After rulebook, since all these Response rules are triggered from the action-specific Report rules (which may be more efficient when there would otherwise need to be a lot of action-generic after rules to cater for a large number of conversational responses).

But this extension only really comes into its own when combined into others (such as Conversational Defaults and Conversation Nodes), where using these Response rules helps ensures that the various rulebooks are consulted in the right order.

Section: Hello and Goodbye

This extension also provides special report rules for saying hello and goodbye to NPCs:

	Greeting response for Bob:
	Implicit greeting response for Bob:
	Farewell response for Bob:
	Implicit farewell response for Bob:

An implicit greeting is triggered if we address an NPC without explicitly saying hello. An implicit farewell is triggered is we walk away from an NPC in mid-conversation without first saying goodbye. In the former case the extension will use an Implicit Greeting Response if present, or a Greeting Response if no Implicit Greeting Response has been defined. Likewise if we walk away from the current interlocutor in mid-conversation, the extension will trigger an Implicit Farewell Response if one has been provided, but will otherwise fall back on the appropriate Farewell Response. If neither an Implicit Farewell Response nor a Farewell Response has been defined, then no kind of implicit farewell will be displayed (and likewise with an implicit greeting).



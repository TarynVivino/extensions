Chapter: Overview

Section: Summary

This extension provides three main features: (1) implementing asking and telling about things as well as objects; (2) allowing players to use abbreviated forms of the ASK and TELL commands; and (3) some rudimentary greeting protocols (saying hello and goodbye).

Note that this extension uses the extension Epistemology by Eric Eve, which therefore also needs to be installed on your machine for this extension to work.

Section: Changes in Version 7

The global variable called "the default interlocutor" is now an object that varies (formerly it was a person that varies). These now allows it to take the value nothing when there is no current interlocutor. The phrase "reset the interlocutor" now sets the default interlocutor to nothing.

The say goodbye when moving rule, which triggers an implicit farewell when moving away from the location of the current interlocutor, is now triggered at the carry out stage instead of the before stage of going. This change prevents the triggering of an (inappropriate) implicit farewell when travel is attempted but not permitted.

Chapter: Asking and Telling about Things

Two new actions are provided: informing about it and quizzing about it (corresponding to TELL SOMEONE ABOUT A THING and ASK SOMEONE ABOUT A THING). By default this allows anything in the game world to be asked about (although this can be changed by imposing knowledge restrictions, as in the example that follows). Responses can be customised with rules like:

	After informing Fred about the golden goose:
	say "'I've just seen a golden goose - out in the yard!' you exclaim.

			'You've been out in the sun too long,' he opines."

Chapter: Revised Ask For

The ASK FOR action in the library is rather restricted in its use. It assumes that the player is asking an NPC to hand over something in plain sight. But we might want to enable ASK BOB FOR INFORMATION or ASK FOR SYMPATHY or ASK BOB FOR GOLDEN KEY (even when the golden key is nowhere in sight).

This extension thus detaches the grammar ASK SOMEONE FOR SUCH-AND-SUCH from the ask it for action and attached to a new pair of actions, somewhat arbitrarily named requesting it for and imploring it for. Requesting it for matches "ask [someone] about [any known thing]", while imploring it for matches "ask [someone] about [text]". By default these actions do nothing at all, so it's up to us to write whatever handling we want for them in our game (including any default responses), or we can use Conversation Responses and Conversation Defaults, which provide some handling for them (if we use these two extensions we also don't need to remember the rather arbitrary action names, since we can then write rules likes 'response of Bob when asked for his hat' or 'response of Bob when asked for "sympathy"' or 'default ask-for response for Bob').


Chapter: Abbreviated ASK and TELL

Once a conversation is under way, commands such as TELL FRED ABOUT GOOSE and ASK BILL ABOUT JULIA can be abbreviated by the player to T GOOSE and A JULIA. If no conversation is under way when one of these command forms is used, the game will try to pick a random interlocutor, if one is available.

The author doesn't have to do anything to enable this feature, but it may be useful to know that the actions invoked by these actions are called implicit-asking, implicit-telling, implicit-quizzing and implicit-informing.

Similarly the player can use ASK FOR MONEY or ASK FOR FORGIVENESS, which trigger the implicit-requesting action (if the player asks for a thing) or the implicit-imploring action (if the player asks for a topic). These will be converted into the appropriate requesting it for/imploring it for actions.


Chapter: Greeting Protocols

Section: Hello and Goodbye

This extension provides commands like SAY HELLO TO FRED or SAY GOODBYE TO BILL to explicitly start and end conversations. The corresponding actions are Saying hello to someone and Saying goodbye to someone.

The commands FRED, HELLO and BILL, GOODBYE have the same effect as SAY HELLO TO FRED and SAY GOODBYE TO BILL respectively.

The command GOODBYE by itself will terminate the conversation with the current interlocutor (if there is one).

The command HELLO by itself will start a conversation with a randomly chosen interlocutor, if one is available to be spoken to.

In all these commands, GOODBYE may be abbreviated to BYE.

The actions corresponding to HELLO and GOODBYE are called hailing and leavetaking - but since these are usually rerouted to saying hello to and saying goodbye to, we probably shan't need to worry about them much.

The default responses to the commands aren't very interesting ("You say hello to Fred." and "You say goodbye to Bill") so you'll probably want to provide your own, e.g.:

	After saying hello to Fred:
	say "'Hi, there, Fred old fellow!' you exclaim

	'Well, hello there!' he grins."

	After saying goodbye to Jill:
	say "'Well, cheerio then,' you say.
	
	'Bye now - you take care!' she replies."

Section: Implicit Greetings

In addition to these explicit greetings, Conversation Framework also implements implicit greetings. Whenever we address a conversational command to someone who isn't already the current interlocutor, an implicit SAY HELLO TO the new interlocutor will be executed. Likewise, if we terminate a conversation by simply moving to another location, an implicit SAY GOODBYE TO is executed. If we have not defined any saying goodbye or saying hello rules of our own, nothing much will appear to happen with these implicit greetings, but if we have, we shall find our hello and goodbye rules being invoked.

We may want to distinguish between greetings that the player has explicitly commanded (through commands such as SAY HELLO TO, or BYE) and those he has triggered by using a conversational command (to start a conversation) or a movement command (to end one). To that end we can test whether the global variables greeting type and farewell type contain the values implicit or explicit, e.g.:

	After saying hello to Fred when the greeting type is explicit:
	say "'Hi, there, Fred old fellow!' you exclaim.

	'Well, hello there!' he grins."

	After saying hello to Fred when the greeting type is implicit:
	say "Fred looks up when you speak."

	After saying goodbye to Jill when the farewell type is explicit:
	say "'Well, cheerio then,' you say.
	
	'Bye now - you take care!' she replies."
	
	After saying goodbye to Jill when the farewell type is implicit:
			say "Jill waves vaguely and goes back to her reading."

Chapter: Yes, No and Sorry.

Conversation Framework converts commands like BOB, YES and SAY YES TO BOB to just YES (i.e. the saying yes action), and similarly with BOB, NO and BOB, SORRY or SAY NO TO BOB or SAY SORRY TO BOB.

It also treats all these commands as conversational, so that they will trigger greeting protocols, just like ASK and TELL.

Chapter: Conversations and Player Knowledge

Section: Player Knowledge

Conversation Framework includes the Epistemology extension in order to restrict conversational commands relating to objects (as opposed to topics) to things the player character knows about. Thus ASK BOB ABOUT DIAMOND RING or TELL BOB ABOUT DIAMOND RING or ASK BOB FOR DIAMOND RING will only match quizzing it about, informing it about, or requesting it for with a second noun of diamond ring if the player character already knows about the diamond ring (otherwise the command will match asking it about, telling it about, or imploring it about with a topic understood of "diamond ring").

Every thing in the game is either known or unknown, but this is not a property that can be set directly. A thing is known either if the player character has seen it or if it familiar: the familiar/unfamiliar property is one we can set directly (with 'now x is familiar/unfamiliar').

Since the player might well to come to know something in the course of conversation, we provide a convenient 'to say' phrase ('make something known' or 'make something familiar') which can be used to make an object familiar (and hence known) within a piece of text that's being said, e.g.:

	After quizzing Bob about Bob:
	say "'How are things?' you ask.

'Not too good, I've lost my wallet,' [make lost wallet known] he tells you."

This allows the player to refer to the lost wallet in subsequent conversational commands (whereas previously ASK BOB ABOUT WALLET would have been treated as asking him about some unknown topic).


Section: Subjects

We may sometimes want to ask characters about things that would not normally be implemented as objects in the game, such as life, liberty and the pursuit of happiness. To allow this the Epistemology defines the subject kind. So we could, for example, define:

	life is a subject.

Which then allows us to write rules like:

	Instead of quizzing Fred about life.

Note that a subject is familiar by default. If we want a subject to start out unfamiliar (because the player is not meant to know about it until he makes some discovery or another character tells him about it) we could define it as unfamiliar (and change it to familiar once it becomes known), for example:

	the secret formula is an unfamiliar subject.


Section: Disambiguation

One problem that can arise with allowing the player to ask (quiz) or tell (inform) about things in the game is that since all known things are in scope for the quizzing it about and informing it about actions, several things may match what the player types, leading to undesirable exchanges like:

	>ask bob about the ball
	Which do you mean, the rubber ball, the Bingleys' Ball, the ball gown, the ball or the ball?

To be sure, in some cases the player may have asked a genuinely ambiguous question for which a disambiguation prompt may be the best response. Often, though, players will find it annoying and inappropriate, and it would be better if the parser simply picked one of the alternatives.

There's more than one way of dealing this; the best one will depend on the precise nature of the game we're writing. One method might be to define a set of does the player mean statements:

	{*}Does the player mean quizzing about something conversation-preferred: it is likely.

	Does the player mean informing about something conversation-preferred: it is likely.

	Does the player mean implicit-quizzing something conversation-preferred: it is likely.

	Does the player mean implicit-informing something conversation-preferred: it is likely.

We can then implement the conversation-preferred adjective in whatever way best suits us. We could define it as a property:

	A thing can be conversation-preferred. A thing is usually not conversation-preferred.

But we may feel this is a bit inefficient if we need only to pick out a few items that need rescuing from disambiguation prompts in this situation. An alternative might be to define an adjective that applies to a handful of objects:

	Definition: a thing is conversation-preferred:
	if it is the Bingley's Ball, decide yes;
	if it is the tall fence, decide yes;
	if it is the meaning of life, decide yes;
	decide no.

There are other ways of tackling this problem; not least, using Jon Ingold's Disambiguation Control extension would allow a finer degree of control. The main thing is to be alert to the potential problem and to come up with some way of dealing with it.


Chapter: Final Notes

Section: The Current Interlocutor

The global variable current interlocutor contains the person the player is currently talking to (or nothing, if no conversation is in progress).

If you want to end a conversation programmatically (bypassing the leavetaking protocols) use the statement

	reset the interlocutor;

Section: Other Conversation Extensions

As its name implies, Conversation Framework is intended to provide a framework for conversations: it is not a complete conversation system. If you need further functionality, you may want to use one or more of the following extensions in addition:

The extension Conversational Defaults provides an additional framework for handling default responses to all the conversational commands handled here.

The extension Conversation Responses provides a framework for handling conversational commands through rules like 'Response of Bob when asked about Mary'.

The extension Conversation Nodes provides a means of adding further structure to a conversation at particular points.

The extension Conversation Suggestions provides a means of suggesting topics of conversation to the player.

The extension Conversation Package uses all of the above and also includes code to make Conversation Suggestions work better with Conversation Nodes.



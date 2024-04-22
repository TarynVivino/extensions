Chapter: Introduction

Section: Overview

In some games that involve a considerable amount of conversation, it can be helpful to tell the player what conversation options may be worth trying. This extension provides a TOPICS command that lists whatever topic suggestions we define. For example:

	>talk to bob
	"Hi there!" you say.

	"Hello," he replies
	(You could ask him about himself, Amanda, the gold ring or the lighthouse; or tell him about yourself or the strangers.)

	>topics
	You could ask him about himself, Amanda, the gold ring or the lighthouse; or tell him about yourself or the strangers.

It is not possible to have the game work out itself which topics are available for discussion; we have to manage topic suggestion lists in our own code, but this does give us control over precisely what suggestions we display to the player. There is no need to list every topic that may give a non-default response; it may often be better just to list the more relevant ones, or we may want to avoid spoilers.

This extension uses Conversation Framework. It can also be used alongside Conversation Responses and Conversational Defaults. If you want to use Conversation Suggestions with Conversation Nodes you'll probably be better off using Conversation Package.

Section: Acknowledgements and Notes

Version 3 incorporates some code contributed by Matt Wigdahl, which takes effect if Complex Listing by Emily Short is present. The provides an alternative method of formatting lists of suggestions to use "or" rather than "and". Without Complex Listing, Conversation Suggestions uses indexed text to do this, which obliterates any special formatting applied to suggestions in the list. For example, if you wanted individual topic suggestions to be shown in blue, you might add a rule like:

	Rule for printing the name of something (called item) when listing suggested topics:
		say "[blue letters][printed name of the item][default letters]";

By default, however, this formatting will be lost, since Conversation Suggestions converts the output to indexed text before displaying it. To preserve such formatting we need to add the following to our code:

	{*}Include Complex Listing by Emily Short

Conversation Suggestions will then use Complex Listing rather than indexed text to process the list of suggested topics, and our formatting will be preserved.


Chapter: Setting Up Suggestion Lists

Section: Ask and Tell Suggestions

Each actor in our game has three suggestion lists, defined in the following three properties:

	ask-suggestions
	tell-suggestions
	other-suggestions

This assumes that most of the time we'll want to suggest things the player can ask or tell people about, but it also allows us to make other kinds suggestions of suggestion as well.

We can set up initial lists of things we can ask or tell an actor about simply by defining these lists on the NPC in question, for example:

	Bob is a man.
	The ask-suggestions are  { bob, amanda, gold ring, lighthouse }.
	The tell-suggestions are  { yourself, the strangers }.

Note that the objects we put in these lists are the simply the objects that the player can ask or tell Bob about. This means that if we want to suggest discussing an abstract topic (such as the weather) we need to define an object to represent that topic:

	The weather is a familiar thing.

We have to make such a topic familiar, otherwise the player won't be able to refer to it in a conversational command (and it won't be listed as a suggestion).

If we want the suggested name of an object in a suggestion list to differ from its ordinary printed name, we can just write a rule for printing the name of the whatever when listing suggested topics, for example:

	Rule for printing the name of the gold ring when listing suggested topics:
	say "the mysterious ring".

Conversation Suggestions contains a special object for making suggestions about the current interlocutor. If we write the following:

	Bob is a man.
	The ask-suggestions are  { self-suggestion, amanda, gold ring, lighthouse }.

The suggestions will be shown as:

	You could ask Bob about himself, Amanda, the gold ring or the lighthouse.

Which reads more naturally than:

	You could ask Bob about Bob, Amanda, the gold ring or the lighthouse.

self-suggestion will automatically display as "himself" or "herself" depending on the gender of the current interlocutor.

Conversation Framework already ensures that ASK BOB ABOUT HIMSELF is translated into ASK BOB ABOUT BOB.

Section: Other Suggestions

Although it's likely that most of the time we'll want to suggest things the player can ask or tell about, we may occasionally want to suggest other kinds of conversational response, for example "You could say or no" or "You could give him the gold ring" or "You could say Jane". For this purpose we use the other-suggestions list, which should contain objects of kind misc-suggestion. The printed name of an misc-suggestion should have a printed name that displays a suggestion phrase that could follow "You could", for example:

	ring-suggestion is an misc-suggestion. The printed name is "give him the gold ring"
	jane-suggestion is an misc-suggestion. The printed name is "say Jane"

This extension predefines three misc-suggestions that are likely to be commonly used:

	yes-suggestion
	no-suggestion
	yes-no-suggestion

The last of these displays "say yes or no", which might be slightly neater than the "say yes or say no" that would result from listing yes-suggestion and no-suggestion separately.

Then to make these three suggestions available when addressing Bob we'd define:

	Bob is a man.
	The other-suggestions are { yes-no-suggestion, ring-suggestion, jane-suggestion }.

If we had a number of other-suggestions, we might want some control over the order in which they're displayed. To be sure, they'll start out being displayed in the order in which we list them in the other-suggestions property, but once we start adding and subtracting misc-suggestions as the situation changes this will no longer be the case. The misc-suggestion kind therefore has a seqno property to allow us to control the order in which they're displayed: other-suggestions are sorted in seqno order before being displayed. This would allow us, for example, to group all suggestions of the form "show him the whatever" together by giving them the same seqno.

By default misc-suggestions have a seqno of 100, but yes-suggestion, yes-no-suggestion and no-suggestion have seqnos of 10, 10 and 12 respectively, so that they'll normally be displayed at the start of the list.

Chapter: Managing Suggestions

Section: Adding and Removing Suggestions

We've just seen how to set up an initial list of conversation suggestions. That's all very well, but the chances are that the suggestions we want to offer will change over the course of the game. We'll want to remove some suggestions as they cease to be relevant (perhaps because the player has already asked the NPC about that topic) and add others as new things come to light.

We'll often want to add or remove things as a result of things that are said, so this extension defines the following phrases to add or remove suggestions:

	To say remove  (obj - a thing) tell suggestion:
	To say remove (obj - a thing) ask suggestion:
	To say remove (obj - a thing) other suggestion:
	To say add (obj - a thing) tell suggestion:
	To say add (obj - a thing) ask suggestion:
	To say add (obj - a thing) other suggestion:

These can then be used like this:

	"[remove gold key tell suggestion]"
	"[remove bob ask suggestion]"
	"[remove yes-no other suggestion]"
	"[add matilda tell suggestion]"
	"[add treasure ask suggestion]"
	"[add ring-suggestion other suggestion]"

Usually, though these would be embedded in longer pieces of text giving the NPC's response to some conversational command, e.g.:

	After quizzing Bob about Bob:
	say "'How are you today, Bob?' you ask.

	'Oh fine, just fine,' he replies, [remove bob ask suggestion]'Absolutely broke, but fine.'"

Section: Suggestions and Player Knowledge

In one particular case the Conversation Suggestions extension can automatically take care of when suggestions occur. The Epistemology extension (included via Conversation Framework) keeps track of what the player knows about. Something is known either if the player has seen it, or if it is defined as familiar. Anything else is unknown. Conversation Suggestions automatically removes anything unknown from the list of suggestions it displays.

This means that you can include unknown things in the initial ask-suggestions and tell-suggestions lists, and they won't actually be displayed until they become known. Making them known (e.g. through using "now the magic ring is familiar" or "[make the magic ring known]") will then simultaneously make them available to be asked and told about (or rather quizzed and informed about) and make them appear in the list of suggested topics.

Section: Suggestions and Greetings

By default a list of conversation suggestions is displayed either when the player enters a TOPICS command, or when the player issues an explicit greeting command (such as TALK TO BOB or BOB, HELLO). The latter behaviour can be disabled by changing suggest-on-greeting to false.


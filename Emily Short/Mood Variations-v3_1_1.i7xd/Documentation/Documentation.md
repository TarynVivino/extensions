This is quite a light-weight extension, designed to be used with a larger conversation library of your choice. It makes certain assumptions -- namely, that there is some character known as "current interlocutor" (defined as in "current interlocutor is an object that varies"). The current interlocutor might sometimes be nothing. Some of Eric Eve's conversation extensions use this convention, for example.

We must also define our own spectrum of moods appropriate to the game we're currently writing. If we are using a simple model in which characters can only like, be neutral toward, or dislike the player, we might write:

	The moods are friendly, neutral, and hostile.

...though in a more complicated game we could equally give a much richer range of options.

Mood Variations tracks two moods for each person: the current mood and the previous mood. This allows for situations where we change the mood, then want to provide some text or some other effect for the transition. ("Alabaster", for instance, uses mood changes as a trigger to modify the accompanying graphics.)

We might want to set everyone's moods to start with:

	The current mood of a person is usually neutral.
	The previous mood of a person is usually netural.

At the end of each turn sequence, the "previous mood" is updated to match the current one. This is done by the "mood record-keeping rule".

The chief purpose of all this is to allow us to write text alternatives that are keyed to the mood of the person to whom we are speaking. So for instance:

	Instead of asking Pam about "love":
		say "'It's all right for some,' says Pam[when friendly], winking[or hostile], with a bit of a snarl in her voice. Clearly you've gotten on her bad side[at other times] blandly[end when]."

will select our first option if Pam is friendly; the second if her mood is hostile; and the third if her mood is neutral. The order in which we defined our moods the first time determines the order in which they may be invoked by the textual substitution.

We will probably also want the ability to set the mood of the current interlocutor in response to what is being said. We may do this with the "set..." token, as in

	Instead of asking Pam about "chicken":
		say "Pam sighs heavily[set hostile].".

As long as "set..." is followed by the name of a mood, the current interlocutor will be given that mood. We can also do this outside a say phrase, as in:

	Carry out attacking the current interlocutor with something:
		set furious.

A restriction of this system is that it does not offer phrases for setting or checking moods for NPCs other than the current interlocutor. This is because the extension is designed as a fairly streamlined solution for games in which the player is usually talking to one person at a time. It would be more complicated syntactically (to the point of not offering a useful shortcut) if we were to require the author to say *whose* moods were being checked during print options.

Changelog:

	Version 3.1 was adapted to Inform 10 by Nathanael Nerode, by replacing I6 code with I7 code (how clean!), fixing whitespace issues, and adding sections.  Because of the change in version number format, this will only work with Inform 10, but if you change the version number back to old-style, it would probably still work with older versions.  The interface for the story writer is unchanged.


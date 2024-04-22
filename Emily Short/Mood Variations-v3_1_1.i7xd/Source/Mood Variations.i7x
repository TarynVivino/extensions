Version 3.1.1 of Mood Variations by Emily Short begins here.

"Allows the author to define a mood value for characters and then use text substitutions such as '[when bored]The king fidgets on his throne[or sleepy]The king snores[at other times]The king grins[end when].' Moods will be interpreted in 'writing a paragraph' and similar contexts as the mood of the person described in the paragraph, but at other times according to the mood of the person to whom the player is currently speaking."

Section - Mood kind

Mood is a kind of value.

[Note that the story writer will have to define the moods.]

Section - Mood properties

A person has a mood called the current mood.
A person has a mood called the previous mood.

Section - Set mood phrases

[Note that the story writer will have to define the current interlocutor.]
	
To say set (attitude - a mood):
	now the previous mood of the current interlocutor is the current mood of the current interlocutor;
	now the current mood of the current interlocutor is attitude.

To set (attitude - a mood):
	now the previous mood of the current interlocutor is the current mood of the current interlocutor;
	now the current mood of the current interlocutor is attitude.

Section - Mood rule

Before reading a command (this is the mood record-keeping rule):
	repeat with target running through people:
		now the previous mood of the target is the current mood of the target.

Section - Active mood phrase

to decide which mood is the active mood:
	if the item described is a person:
		decide on the current mood of the item described;
	otherwise:
		decide on the current mood of the current interlocutor.

Section - Implementation in Inter

To say when (N - a mood) -- beginning say_by_mood:
	(-
		switch( (+ the active mood +) )
		{-open-brace}
		{N}:
	-).
	
To say or (N - a mood) -- continuing say_by_mood:
	(-
		{N}:
	-).
	
To say at other times -- continuing say_by_mood:
	(-
		default:
	-).
	
To say end when -- ending say_by_mood:
	(-
		{-close-brace}
	-).

Mood Variations ends here.

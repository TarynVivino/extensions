Punctuation Removal provides phrases for removing unwanted punctuation marks from the player's command before attempting to interpret it. These are

	remove exclamation points
	remove question marks
	remove quotes

and, to do all three of these things at once,

	remove stray punctuation.

Also provided, but not included in "remove stray punctuation", is

	remove periods

which we should use sparingly, since the player's command might reasonably include multiple actions separated by full stops. Similarly dangerous is

	remove apostrophes

A more common need is to be able to parse titles such as "mr." and "mrs." sensibly. Inform reads any full stop as the end of the sentence, which leads to such exchanges as

	>x mr. sinister.
	You see nothing special about Mr. Sinister.

	That's not a verb I recognise.

because Inform has interpreted as though the player had typed

	>x mr.
	You see nothing special about Mr. Sinister.
	
	>sinister
	That's not a verb I recognise.

To get around this, we want to remove full stops only when they appear as parts of standard titles. "Punctuation Removal" provides the phrase

	resolve punctuated titles
	
which turns all instances in the player's command of "mr.", "mrs.", "ms.", "prof.", "st.", "dr.", and "rev." into "mr", "mrs", "ms", "prof", "st", "dr", and "rev" respectively. Now (assuming Inform understands "mr" as referring to the correct character) we get such output as

	>x me. x mr. sinister.
	As good-looking as ever.

	You see nothing special about Mr. Sinister.

These phrases should be used during the After reading a command activity, so for instance in a game designed to be very patient with the player's quirks:

	After reading a command:
		remove stray punctuation.

Or, if we have titled characters,

	After reading a command:
		resolve punctuated titles.

Section: Change Log

6.1
- support for unicode input on glulx
- case-insensitivity
- added Ms.
- added tab stripping


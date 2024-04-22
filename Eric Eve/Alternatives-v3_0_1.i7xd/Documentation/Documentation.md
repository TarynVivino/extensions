Chapter: Alternatives

Section: The Basics

This extension adds a number of conditions that can be used with IF, WHEN and the like:

	X is either A or B
	X is either A or B or C
	X is either A or B or C or D
	X is either A or B or C or D or E
	X is either A or B or C or D or E or F

	X is neither A nor B
	X is neither A nor B nor C
	X is neither A nor B nor C nor D
	X is neither A nor B nor C nor D nor E
	X is neither A nor B nor C nor D nor E nor F
	
For this to work, either A, B, C, D, E  and F must all be the same kind of value as X. Thus, for example, if X is an object, A, B, C etc. must all be objects or if X is a number then A, B, C etc. must all be numbers. Apart from this restriction, these phrases can be used with any kind of value, including new kinds defined by a game author. This allows us to use tests like:

	if the colour of the noun is either red or blue...

	Instead of eating the noun when the colour of the noun is neither blue nor orange nor green...

(Assuming, of course, that we have defined colour as a kind of value which includes red, blue, green and orange among its possible values). Note in this case that we must test "the colour of the noun" not just the "noun"; the following condition will not compile:

	If the noun is either red or blue,

Instead we must write:

	if the colour of the noun is either red or blue...

The reason is that the phrase is testing for literal equality, and a thing can never be equal to a colour.

Section: Other Restrictions and Workarounds

Note that Alternatives only works for comparisons, that is for testing whether one value is equal to one of up to six other values, or unequal to all of six other values. Although it might be useful to be able to do so, Alternatives does not allow us to write, for example:

	After taking either the bucket or the spade:
		say "You pick up [the noun] with gusto."

It is, however, often possible to achieve the desired effect with a slight rephrasing. We can, for example, write:

	After taking when the noun is either the bucket or the spade:
		say "You pick up [the noun] with gusto."

And this will have the desired effect.

A similar technique can be used to handle numerical values input by the player, for example:

	{*}Guessing is an action applying to one number.

	Understand "guess [number]" as guessing.

	After guessing when the number understood is either 2 or 3 or 5 or 7 or 11 or 13:
		say "Ah, a prime number less than 17!"
	
	Report guessing: Say "[the number understood] doesn't interest me much."
	
Section: Changes in Version 2

The number of items that can appear on the right hand side of the comparison has been increased from five to six. This is probably more than enough for most purposes, but should several users wish this to be extended further that is something I could consider for a future version.

Version 1 allowed objects and numbers to be compared with these phrases, and tentatively allowed other types of value. Version 2 is no longer tentative about comparing other types of value with these phrases. On the other hand Version 2 enforces stricter type checking at compilation time. Version 1 would allow:

	if the noun is either the ball or 2 or red or "fred",...
	
Which was hardly useful, and which will no longer compile in Version 2.

These changes employ features of Inform 7 that are new to Release 6E59.
	


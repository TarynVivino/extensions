Assorted Text Generation supplies routines for producing prose in various common situations.

Section: Overview

Phrases defined by Assorted Text Generation Include:

	selection of (superset - a description) conforming to the description (subset - a description) is-are
	
	none of (superset - a description) is-are
	explicit none of (superset - a description) is-are
	explicit both (superset - a description)
	explicit both (superset - a description) is-are
	explicit (superset - a description) is-are both/all
	(superset - a description) is-are both/all

	ordinal of (N - a number)
	numerical ordinal of (N - a number)
	(N - a number) to the nearest (A - a number)
	(N - a number) in ballpark terms

	in-on (item - a thing) [and variations with "a" and "the"]
	placement of (item - a thing)

	you or (culprit - a person) [and variations with "a" and "the"]
	me or (culprit - a person) [and variations with "a" and "the"]
	(culprit - a person) or I [and variations with "a" and "the"]

By default, all phrases produce output in lower case. If we want to change to another casing (sentence case will probably be most common), we can always write, e.g.:

	let N be indexed text;
	let N be "[selection of the visible doors conforming to the description open visible doors is-are]";
	say "[N in sentence case]".

This removes the need for numerous variant phrases for capitalized output.

Section: Selection

	After looking:
		let N be "[selection of the visible doors conforming to the description open visible doors is-are]";
		say "[N in sentence case] open.".

to produce such phrases as "Neither of them is open.", "All three of them are open.", "The black door is open.", and so on. It is necessary to give both descriptions in full and not to take a shortcut such as "selection of the visible doors which are open". It is the author's responsibility to ensure that the subset description is really a subset of the superset description. (It would be possible to check for this within Inform, but at some runtime performance cost if the sets are complicated; so we preferred the speedier option.)

Along the same lines, we can write

	describe which visible doors are open visible doors with members being "open";

which will produce the entire sentence as given above, followed by a full stop and a space but no line break. Sometimes we may want to suppress this sentence if no members belong to the relevant set, in which case we may write

	describe which visible doors are open visible doors with members being "open", when necessary;

which will print no sentence in the case that no open visible doors exist.

Note that this isn't a say phrase, and the reason is that we need to be able to pass those bits of text such as "open" that could not be embedded within a larger phrase.

A slighly more sophisticated option is:

	describe which visible doors are open visible doors rather than closed visible doors with members being "open" and nonmembers being "closed";

to generate text such as "The green door is closed." or "The green door and the blue door are open." This phrase produces a sentence that ends with a full stop and a space but does not conclude the paragraph, so it is suitable for including in longer paragraphs.

This phrase will always choose to write the sentence that requires the least enumeration, so if there are five doors in a room and all but the red one are open, it will say "The red door is closed." rather than "The green door, the blue door, the yellow door, and the pink door are open."

Section: Numbers

	say "[ordinal of N]"

will produce output such as "first," "second," "tenth," "twenty-first," and so on. It should be reliable up through quite high numbers, and has been tested up to a thousand. "numerical ordinal of N" produces 1st, 2nd, 3rd, and so on.

	(N - a number) to the nearest (A - a number)

allows us to write, e.g.
	
	say "[N to the nearest 5 in words]"

in a way that is uniform with Inform's built in

	say "[the time of day to the nearest five minutes in words]"

and may be useful for approximations.

	say "[N in round numbers]"
	say "[adjectival N in round numbers]"

produces textual output in a way similar to that shown in the manual example Ballpark; the adjectival form is to print text like "no" or "a couple of", while the bare form would print "zero" or "a couple" for the same numbers. Thus

	When play begins:
		repeat with N running from 0 to 4
		begin;
			say "You see [adjectival N in round numbers] [if N is 1]person[otherwise]people[end if] here; that's right, [N in round numbers].";
		end repeat.
	
would produce the output

	You see no people here; that's right, zero.
	You see one person here; that's right, one.
	You see a couple of people here; that's right, a couple.
	You see several people here; that's right, several.
	You see a few people here; that's right, a few.


Section: Locational phrases

	say "[in-on the item]"

produces "in the item" or "on the item" depending on whether or not the item is a container; in-on item and in-on an item work in the expected way.

	say "[placement of item]"

produces "on the ground", "carried by the vicar", "worn by the vicar", "in the box", or "on the shelf", depending on the nature of the containment involved. If the person in question is the player, the result will be "carried by you" or "worn by you".

Section: Referring to someone who might be the player

Quite often we need to refer to a person who might be the player, in contexts where the default "yourself" would look awkward. For these purposes we have

	you or vicar
	you or a/an vicar
	you or the vicar

And (for use in first-person contexts) there is also
	
	me or vicar
	me or a/an vicar
	me or the vicar
	vicar or I
	a/an vicar or I
	the vicar or I

As usual, these should be explicitly sentence-cased if necessary, with the exception that "I" is always printed in the upper case by default.


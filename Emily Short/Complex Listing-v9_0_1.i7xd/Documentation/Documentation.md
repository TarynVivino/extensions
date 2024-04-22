Complex Listing provides two significant abilities: the ability to change the way a list is delimited (that is, to use semi-colons, sentence fragments, dashes, or othermore exotic techniques, instead of the usual commas with a final "and"); and the ability to determine an ordering for the list according to criteria of our choosing.

(Because Complex Listing is relatively powerful, the complete description of what it does may be a bit daunting, especially for less experienced users. It may be more congenial to skip down to the examples and then return to the full instructions later.)

Chapter: Basic listing features

There are three stages to setting up and printing a complex list: marking the items we are going to include; arranging the list in order; and printing the list.

Section: Preparing a list

First we must

	prepare a list of (whatever criteria)
	
For instance, we might say

	prepare a list of furry animals which are visible.
	
This marks the items that are going to be in our list. If we prefer, we may also do this task by hand by changing the desired items to "marked for special listing" (and undesired items to "unmarked for special listing"). If we do the task by hand, we must finish with

	register things marked for listing.

This sets up a table, called the Table of Scored Listing, which contains all the items that we are going to describe in our list, in two columns: output (the thing that is going to be named) and assigned score (the value we've given this item to order it with respect to everything else). (In versions prior to version three, it was necessary to register things marked for listing even after preparing a list. This is no longer the case.)

Things marked for listing are registered automatically if we say "prepare a list of...".

Section: Ordering the list

At this point we may optionally choose to arrange the list in order in some way. One approach is to write our own phrase to go through the Table of Scored Listing and assign scores to each item.

For instance, we might write a phrase to order the Table of Scored Listing according to the monetary value of items, their current relevance to the plot, their size, etc., etc., etc. -- it can be anything we want to include for the purpose of adding nuance to the descriptive prose. We can already

	order list by length.
	
to arrange according to the number of letters in the name of the item. (This is built into the extension not because it is inherently more interesting than all the other ordering principles we might apply, but because it is mildly annoying to program, so it seemed best to provide it pre-written.)

The list arranging activity automatically sorts the Table according to its assigned score entry, but like all activities this can be overwritten if we would rather do something else; so that one could instruct the list arranging activity to sort the table randomly or in inverse order, if so desired.

Section: Printing the list

Now we're ready to use the list, which we may do by saying "[prepared list]". At that point the items in the list will be printed in the order we have established (without any article, matching the behavior of "[list]"), and the table cleared. Failing to prepare the table properly before listing it may cause bugs, though if it finds itself entirely empty it will say "nothing" rather than giving run-time errors. There are the following variants as well:

	say "[the prepared list]."
	say "[a prepared list]."
	
which tell Inform to use definite or indefinite articles; and

	say "[is-are the prepared list]."
	say "[is-are a prepared list]."
	say "[is-are prepared list]."

which add the appropriate verb, just as with regular list-saying.

Chapter: Customizing Complex Listing

Section: The concept of list styles

This is also the juncture at which we may change the delimiters of the text. Complex Listing has a Table of List Style Assignments which lists different ways in which a list may be configured, and it may be reasonable simply to show what this looks like:

	Table of List Style Assignments
	list style	first delimiter	second delimiter	alternate second delimiter	indefinite name phrase	definite name phrase
	sequential	", "	"[if the serial comma option is active],[end if] and "	" and "	"[a current listed object]"	"[the current listed object]"
	disjunctive	", "	"[if the serial comma option is active],[end if] or "	" or "	"[a current listed object]"	"[the current listed object]"
	semi-colon	"; "	"; "	" and "	"[a current listed object]"	"[the current listed object]"
	comma	", "	", "	" and "	"[a current listed object]"	"[the current listed object]"
	null	" "	" "	" and "	"[current listed object]"	"[current listed object]"
	hyperconnective	" and "	" and "	" and "	"[a current listed object]"	"[the current listed object]"
	fragmentary	". "	". "	". "	"[A current listed object]"	"[The current listed object]"
	enumerated	"; "	"; "	"; "	"([current enumeration]) [a current listed object]"	"([current enumeration]) [the current listed object]"

The first delimiter appears between all but the last pair of items in a list. The second delimiter appears between the last pair of items in a list of three or more things; and the alternate second delimiter appears between the last pair in a list of exactly two things. (This is because we may want "the fish and the donkey" but "the cat, the fish, and the donkey".)

The indefinite name phrase instructs Inform in how to say the name of the object if there's an indefinite article, and the definite name phrase if there's a definite article. Notice that this is not wholly consistent, because, for instance, in fragmentary-style listing each item receives its own sentence fragment and a capitalized definite article, rather than the usual uncapitalized one.

Section: Pre-defined list styles

"Sequential" is the default mode of listing and conforms with Inform's usual "thing, thing, thing[,] and thing" list style. It obeys the serial comma use option just as ordinary listing does. If no delimiter is specified, the list will be written in this manner. "Disjunctive" style, though not very flashy, is likely to be the most useful alternate mode, since it replaces the usual "and" with an "or", appropriate for offering the player options or asking him questions. Most of the others are perhaps self-explanatory. "Enumerated" presents a list with each element numbered, and "[current enumeration]" may be used elsewhere to indicate the number of the item currently being listed.

To pick a special delimiter, we use phrases like

	say " [the prepared list delimited in comma style]."
	say " [a prepared list delimited in hyperconnective style]."

and we may also add our own variations simply by continuing the table in our own code.

Section: Delimiting the list in our own way

Of course, there are times when even this does not give adequate flexibility. This whole process is carried out by the "delimiting a list" activity, and if we want, we can write our own rules for delimiting a list. The current version looks like this:

	Rule for delimiting a list (this is the standard delimiting rule):
		choose row with list style of current list style in the Table of List Style Assignments;
		if current listing index is 1
		begin;
			if current listing total > 2, say "[second delimiter entry]";
			otherwise say "[alternate second delimiter entry]";
		otherwise;
			if current listing index > 0, say "[first delimiter entry]";
		end if.

But if we liked we could replace this with more complicated logic to apply under some circumstances; for instance, instructions to group items in different numbers of combinations so that we generate lists like "a chicken, a horse, a duck; a red hen; a heron." This gets increasingly detailed and picky, but provides significant leverage towards writing routines that will generate human-like prose.

Section: Say list of... and Empty out... phrases

In the providing these functions, Complex Listing also defines some other phrases that the author may find useful even when not actually saying prepared lists.

	say list of (any table name)
	
will do the printing-and-delimiting on any table name containing an output column, in case we want to write lists of objects from some other table. And then

	empty out (any table name)

strips blank every entry of every row of that table, and should not be used casually.


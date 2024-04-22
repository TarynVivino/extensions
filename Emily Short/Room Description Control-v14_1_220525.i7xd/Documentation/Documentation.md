This extension is designed to help resolve certain challenges in Inform's default room description, allowing items to be more flexibly concealed and the order in which objects are mentioned to be fully controlled by the author. To do so, it replaces "the room description paragraphs about objects rule" from the carry out looking rules, and also the "describe contents entered into rule" from the report entering rulebook. The latter means that if the player gets into an enterable container and Inform generates a description of the other things in the container, that description will follow the rules for room descriptions.

Chapter: Room Description Control's Process

There are three stages to using Room Description Control.

Section: Concealment

(1) Concealment. Room description control allows the author to mark any visible item as "not marked for listing" before it reaches the later stages of room description, using description-concealing rules. Thus we might turn off mention of items on a high shelf like this:

	A description-concealing rule when the player is not on the chair:
		now every thing enclosed by the high shelf is not marked for listing.

or make some objects invisible in certain circumstances:

	A description-concealing rule:
		if the diamond is in the glass, now the diamond is not marked for listing.

	A description-concealing rule when the player wears the peril-sensitive sunglasses:
		now every dangerous thing is not marked for listing.

After concealment, all remaining items -- that is, every visible thing except the player, the player's possessions, scenery objects, and items explicitly concealed -- are added to a Table of Seen Things.

Section: Sorting

(2) Sorting of objects. Next we are allowed to determine the order in which we would like items in a room description to appear in the Table of Seen Things. Room Description Control calls an object-based rulebook called the ranking rules to determine how items should be ranked. The higher an item's rank, the higher it will be sorted in the Table of Seen Things and the sooner in the room description it will appear. So for instance we might encourage Inform to mention people sooner than everyone else:

	A ranking rule for a person (called special-target):
		increase the description-rank of the special-target by 10.

or to prefer items with initial appearance properties:
	
	Definition: a thing is initially-described if it provides the property initial appearance.

	A ranking rule for an initially-described thing (called special-target):
		increase description-rank of the special-target by 5.

All the ranking rules are considered in sequence unless a rule explicitly succeeds or fails, so if we have multiple ranking rules applying to a single item, they will all be observed; description-ranks can thus be determined cumulatively.

Section: Reporting to the player

(3) Writing a paragraph about. Finally, Room Description Control goes through the Table of Seen Things and executes the Writing a paragraph about activity for each unmentioned item it finds there. (Things whose names have been printed earlier during the room description are thereafter marked "mentioned" and will not have their writing a paragraph about activity called. This emulates the default behavior of Inform.)

An item is considered to be "mentionable" when it is unmentioned and marked for listing.

This is where the burden falls on us to provide a set of writing a paragraph about activities that will produce the kind of output we want. This is not necessarily a minor undertaking.

Several possible collections of writing-a-paragraph rules are provided as sister extensions as of this writing:

The minimalist "Single Paragraph Description" combines all description of all items into a single paragraph. This is likely to be unattractive and unruly in all but the most spartan games, but it is provided in response to a specific author request.

"Ordinary Room Description" emulates as closely as possible the Inform default behavior while still relying on Room Description Control; this means that concealment and priority rules can be applied while otherwise retaining the look and feel of a game. Ordinary Room Description also makes use of the listing nondescript items activity.

"Tailored Room Description" is the most complex solution: it does away with parenthetical lists of contents and instead produces detailed full paragraphs.

If none of these suit, we may wish to craft our own set of writing a paragraph rules instead.


Note also that under this system, the activity of listing nondescript items becomes irrelevant.

An addendum about concealment. We may also find that we want TAKE ALL to attempt to take only items that are currently not concealed according to our concealment rules. We may in that case add the following bit to our code:

	Rule for deciding whether all includes something (called special-target):
		now every thing is marked for listing;
		follow the description-concealing rules;
		if the special-target is not marked for listing, it does not.

Chapter: Debugging and Background

Section: Debugging

A debugging verb PARAGRAPHS is provided. Turning PARAGRAPHS on will cause the description process to print out its table of seen things (with ranking numbers for all objects) before formulating the description.

Section: Changelog

	Version 14.1.220524: (Updated by Nathanael Nerode.)  Switch to Inform 10.1 version numbering.  Comments and whitespace fixes.  Shorten action names for paragraph debugging to avoid conflict and compile under 10.1.  Remove triple loop over all objects in favor of single loop over all objects.  Fix treatment of undescribed objects.  Reorganize Chaneglog.
	Version 14/210401: Improved paragraph debugging; comments and some style modernization.
	Version 14/210322: (Updated by Nathanael Nerode.) Name all rules so they can be replaced/removed by story authors.  Put Table of Seen Things in its own section so it can be overridden by authors.  Additional changes taken from Counterfeit Monkey version: Rename "output" column in Table of Seen Things to "output subject" column, to avoid conflicts.  Remove dependency on Complex Listing.
	Version 13/160517: Update to work with Inform 6M62. Remove dependency on Plurality.
	Version 12 does some cleanup and brings the extension in line with adaptive responses.
	Version 10 removes deprecated phrases.
	Version 8 adds a fix for bugs involving multiple identical objects, so that they will not each earn their own individual listings.
	Version 7 adds the don't mention things out of play rule; this means that if the author places some things in scope by hand, they will not be assumed to belong to the room description. This can be overridden by replacing or suspending the rule. Version 7 also adds section headings to the documentation.
	Version 6 updates to use "object-based rulebook" rather than "object-based-rulebook", as required by Inform 5G67, and also clears up a bug whereby an NPC entering an object could trigger a description of the location entered.
	Version 5 fixes a small but very annoying bug preventing proper release of finished game files.


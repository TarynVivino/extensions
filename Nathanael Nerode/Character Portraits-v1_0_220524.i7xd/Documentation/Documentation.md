Section - Basic Usage

Ever wanted to write a serious dress-up game?  This extension allows you to make the production of descriptions of people as complicated as the production of description of rooms is in the Standard Rules.

You will have to include the following:
	Include Large Game Speedup by Nathanael Nerode
	Include Character Portraits by Nathanael Nerode.

Then, by default, this extension does... nothing.

To use it, you will want to write something like this:

	Carry out examining a person (called subject) (this is the examine people with portrait rule):
		if the description of the subject is not "":
			say "[description of the subject]  ";
		describe portrait for subject;
		now examine text printed is true.
		
The reason this isn't turned on by default is, quite simply, that you may only want to do this for certain kinds of people.  Perhaps people may have ordinary descriptions, while only a few people will implement the full dressing-up machinery.  To do this, you might write:

	A doll is a kind of person.
	Carry out examining a doll (called subject) (this is the examine person with portrait rule):
		if the description of the subject is not "":
			say "[description of the subject]  ";
		describe portrait for subject;
		now examine text printed is true.
		
	Jenna is a doll.  The description of Jenna is "Jenna is a fashion model."

Now, the description of Jenna will include
	a listing of everything she's wearing (first)
	a listing of any body parts ("part of" Jenna) which have descriptions and are not scenery (second)
	a listing of everything she's carrying (third)
	
Section - Writing a portrait sentence about

The main way to customize the description is through the "writing a portrait sentence about" activity.  For instance:

	the red dress is a wearable thing.  The description of the red dress is "A shiny, bias-cut, nylon dress in fire-engine red."
	Rule for writing a paragraph about the red dress:
		say "A slinky red dress lies crumpled on the floor.";
	Rule for writing a portrait sentence about the red dress:
		say "[regarding the holder of the red dress][They]['re] wearing a slinky red minidress.";

Note the use of "the holder of the red dress" in the rule.

Section - Changing order of sentences and adding objects

Normally the portrait will include the character's worn items, carried items, and components (body parts).
However, any item which is scenery, or "concealed" (see "deciding the concealed posssessions of" in Writing With Inform) will be omitted.

You can add an item to the portrait by adding a rule like this:
	After choosing notable portrait objects of Jenna:
		set the portrait priority of the magic glow to 5.

"Choosing notable portrait objects" is an activity.  You can use "set the portrait priority" anywhere in this activity, but it's best to use an "after" rule so that the usual rules can activate first (and so that the usual rules won't override your custom rules).

You can change what order portrait sentences are listed in.  Smaller numbers go first:
	set the portrait priority of (object) to 5

By default, clothing is 10, body parts are 20, and carried items are 30.

All portrait sentences will be printed before the "Jenna is also wearing..." sentences.

Section - Suppressing mention of an object in the portrait

Normally any item which is scenery will be omitted.  In addition, any component (body part) without a description will be omitted.

This will delist an otherwise-listed object, preventing it from being described in the character portrait:
	set the portrait priority of (object) to 0

You can do this in the rules for the character:
	Rule for choosing notable portrait objects of Jenna:
		set the portrait priority of the invisible box to 0.

You can do this in the rules for the object as well:
	Before printing a portrait sentence about the invisible box:
		set the portrait priority of the invisible box to 0; [Never mention it]

It doesn't work to set priority to anything greater than 0 in the rules for printing a portrait sentence, however; the priority order is already determined by the time that rule is checked.

If you want to eliminate the automatic listing of body parts:
	The show body parts in portrait rule is not listed in any rulebook.

Section - Rules for listing bunches of items in portrait

You can also override the methods used for listing the items which don't have their own sentences.  We define four activities:

	listing worn items in portrait of something
	listing carried items in portrait of something
	listing body parts in portrait of something
	listing miscellaneous items in portrait of something

Each of these will be called with the appropriate set of items "marked for listing".

The miscellaneous category is strictly for items which are not part of the character and not carried or worn by the character -- so they will only be listed if they were added deliberately by the story author.

The body parts listing may not be what you want because the full name of each body part, by default, will be something like "Jenna's hand".  The easiest way to fix this is to assign a shorter "printed name" to each of the body parts.

Section - Changelog

	1.0.220523 - Update for Inform v 10.1 version numbering
	1/171007 - Fix line breaks
	1/171006 - First version


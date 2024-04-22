
Section: Usage

This extension introduces two new properties: "bulky" and "insubstantial".

"Bulky" means the player can carry the item, but may not carry anything else at the same time. Picking up such item will make the player automatically drop everything else they are carrying. Picking up something when the player is carrying a bulky item will make them drop the bulky item first.

"Insubstantial" means the thing is so small or carried in such location that it doesn't have to be dropped to carry a bulky item. Worn items are never dropped so they don't need to be marked insubstantial manually.

To illustrate, if the story contains the following items:

	The huge boulder is a thing. It is bulky.
	The pocket lint is a thing. It is insubstantial.
	The walking stick is a thing.

If the player carries the walking stick and the pocket lint when they pick up the boulder, they would drop the walking stick but not the pocket lint. Likewise they could pick up the pocket lint while carrying the boulder, but if they picked up the walking stick they would drop the boulder before doing so.

Note that by default inserting bulky items in containers (or on supporters) does not make the containers bulky; thus you could insert a boulder into a matchbox and circumvent the mechanics. See below for examples of containers that either change their bulkiness based on their contents or reject inserting bulky items.


By default, if the player is carrying something when they try to pick up a bulky item, they will automatically drop everything they have before picking it up. If we wish to block the action instead, the following code accomplishes this:
	
	The making room before taking a bulky item rule is not listed in any rulebook.
	The dropping a bulky item before taking something else rule is not listed in any rulebook.

	Instead of taking a bulky thing when the player is carrying something not bulky:
		say "[The noun] [are] too big to carry with your hands full."

	Instead of taking something when the player is carrying a bulky thing:
		say "You can't carry anything else as long as you're hauling [the random bulky thing carried by the player] with you."


Section: Release history

Version 3 (released April 2014) adds compatibility with the new release of Inform.

Version 2 fixed a bug where you would drop and lift again a bulky item you were already carrying when you tried to pick it up and added the example for a smarter TAKE ALL.



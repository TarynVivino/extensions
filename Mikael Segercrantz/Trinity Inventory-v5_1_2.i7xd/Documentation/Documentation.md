Chapter: Introduction

Provides a wide, prose-style, customisable inventory listing, of the following form:

	You're holding a briefcase and a lemon. You're wearing the old top hand, and you have a folder of papers in the briefcase. You also have a map of Slovakia in the folder of papers.

Section: Version history

	Version 1/071124 - A basic rewrite of Jon Ingold's Written Inventory extension, to modify the output to match more closely how the game Trinity (by Infocom) displays the inventory listing.

	Version 2/071217 - Added support for the inventory listing property to things. Also modified the way containment is shown, allowing for an occasional use of ", and " instead of ". ".

	Version 3/071223 - Separated the printing of articles out from the lists into separate rules, which improves the support for the inventory listing property, as well as brings better support of indefinite and definite articles. Fixed a bug with containers showing their contents, even when opaque and closed. Also fixed a bug with the player's holdall's contents not being listed, as well as a bug with contents of supporters not being listed. In addition, fixed a bug (partially introduced in Version 2/071217) regarding nested containers/supporters not listing their contents. Also found a bug which had existed already in Version 1/071124, where if the player wasn't wearing anything, it would write out two dots separated by a space; this has now been fixed.

	Version 4/080508 - Updated to fit version 5T18 of Inform 7, by adding the inventory listing property back to things. It also changes the syntax to use the new if-while-repeat syntax.

5.1.1 updated for 10.2 -- ZL

Chapter: Usage

Section: Customizing the contents of something

This works by printing objects directly carried and worn first (if there are any). It then runs an activity on any objects one level lower, called the "inventory listing the contents of" activity. By default this will provide the "In the briefcase..." style sentence above, but it can be customised:

	Rule for inventory listing the contents of the folder of papers: say ". The folder of papers contains [list of things in the folder of papers]";

Note the period at the start of the rule's output, and the lack of one at the end.

Section: Suppressing the contents of something

Should we want to suppress something's contents from an inventory listing, use a "do nothing rule":
	
	Rule for inventory listing the contents of the lemon: do nothing instead.

Note, that this will produce a list of the contents of the contents of the lemon (so it may append "In the pips of the lemon is the genetic material necessary for a new lemon tree"). To eradicate this, give the lemon's contents the "mentioned" property:

	Rule for inventory listing the contents of the lemon:
		now everything enclosed by the lemon is mentioned; do nothing instead.

Section: Removing something from listing

To remove an object from being listed in the inventory is possible, separately for when it is carried and for when it is worn. To do this, you can use the phrases "unlisted when carried" and "unlisted when worn". If, at some point in the game, you need to change the item back to listed form, you can use "listed when carried" and "listed when worn" respectively. The defaults in both cases are for the item being listed.

	The player wears a vacation outfit. The vacation outfit is unlisted when worn.

Section: Adding certain containers or supporters as having their contents listed even if empty

In certain cases, it might be necessary to list a container's contents, even if that container is empty. Even this is possible using this extension: you can define the container as "empty-listed" or "not empty-listed" as required, with the default being "not empty-listed".

	A container called your pocket is a part of the vacation outfit. Your pocket is empty-listed.

Section: Parts of things

A final note: the extension automatically describes containers and supporters, and considers anything which contains a component part, but by default this third type of object prints nothing (since most of the time printing the parts of an object is unhelpful). This does provide an entry-point should you want an object to comment on its parts:

	Rule for inventory listing the contents of the ring-tailed lemur:
		say ". The lemur's extraordinary tail is coiled around your neck";

...and should any of those parts be containers or supporters themselves, they will be considered even if the part itself it ignored. (Therefore a player wearing a coat with a deep pocket should be told he is wearing the jacket, unless it is marked as not listed when worn, and the contents of the pocket will be listed, without being told separately that the pocket is part of the coat).

Section: The inventory listing property

As of Version 2/071217, this extension provides support for the "inventory listing" property. This property, described more closely in "Writing with Inform" in the section "Three descriptions of things", allows us to override the printed name of a thing when it is displayed in an inventory listing. This support has been improved with Version 3/071223, such that the "inventory listing" property can now contain a preceding article, or something working to that effect, as the article display mechanism has been separated from the list display to separate rules.

For example,

	A plain ring is in the Gazebo. The inventory listing of the plain ring is "that worthless old ring."

gives the following transcript

	Gazebo
	The gazebo stands slightly off to one edge of the lawn, almost in the center, but slightly closer to the edge the house is towards. A path leads north towards an intimidating forest and south towards the spooky old Victorian-style house you inherited from your great-aunt Mathilda.

	You can see a plain ring here.

	> TAKE RING
	Taken.

	> I
	You are holding that worthless old ring.

Chapter: Definitions

Note the extension provides one relation and two adjectives: "empty" and "non-empty" describe containers and supporters appropriately, and other things will be declared non-empty if and only if they have no component parts. (But a supporter with component parts may be empty if there is nothing on it). The relation is called "encasement" and describes direct enclosure. (That is, containment, carrying, wearing, or incorporation).


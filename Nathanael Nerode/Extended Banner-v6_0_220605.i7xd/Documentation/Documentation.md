Extended Banner provides all of the tools necessary to rewrite the banner that is printed when a game begins.

Section: Fully Customizable Banner

By default, it primarily defines several new text substitutions: the extended story headline, the story serial number, and the I7 version number. For example, the game "Totally Normal Banner" has a rule which would print a version of the banner that's the same as the default one.

You can tweak this, as with the example game "Less Normal Banner".

Section: Predefined Copyright Options

To add a copyright line to the banner, you don't have to write a rule like the one in "Totally Normal Banner". Instead, you can define the story copyright string with the year or years for which you're claming copyright:

	The story copyright string is "2005-6".

You can also change the rights you are claiming by changing the story rights string (this is only printed if you specify the story copyright string):

	The story rights statement is "Released under the Creative Commons Attribution-NonCommercial-ShareAlike 2.5 License"

By default the story rights statement is "All rights reserved".

Note that if you replace the default story copyright line rule then it won't print the story copyright string or story rights statement, but you can still use these in your own rule.

Changelog:

	6.0.220604: rearrange examples & documentation to format nicely
	version 6: rewritten by Nathanael Nerode to compile in Inform 10.1 and to foolproof blank string handling; also provide a copy-pasteable example, and reorganize
	version 5: updated by Gavin Lambert to compile in 6M62 and make it easier to entirely replace the copyright line
	version 4 and earlier: originally by Stephen Granade


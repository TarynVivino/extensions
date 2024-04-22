Extended Banner provides all of the tools necessary to rewrite the banner that is printed when a game begins.

It was originally written by Stephen Granade; but in version 5, Gavin Lambert updated it to compile in 6M62 and made it easier to entirely replace the copyright line.
Version 5.0.1 is an update to make it compatible with 10.1.2.

By default it does nothing but define several new text substitutions: the extended story headline, the story serial number, and the I7 version number. For example, the following rule would print a version of the banner that's the same as the default one:

	Rule for printing the banner text:
		say "[bold type][story title][roman type][line break][extended story headline][if story author is not blank] by [story author][end if][line break]Release [release number] / Serial number [story serial number] / Inform 7 v[I7 version number][line break]" instead.

The "if story author is not blank" text substitution uses a new phrase that determines whether or not a piece of text is blank.

For additional examples of customisations, see below.


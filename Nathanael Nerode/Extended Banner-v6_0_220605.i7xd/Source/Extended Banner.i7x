Version 6.0.220605 of Extended Banner by Nathanael Nerode begins here.

"More control over what is printed in a banner, including an easily-included copyright line."

"based on Version 5 by Gavin Lambert; which was based on Version 4 by Stephen Granade"

Section - I7 Version Number

Include (-

[ I7VersionNumber;
	print (PrintI6Text) I7_VERSION_NUMBER;
	#ifdef DEBUG;
	print " / D";
	#endif;
];

-)

Section - Serial Number Glulx (for Glulx only)

Include (-

[ SerialNumber i;
	for (i=0 : i<6 : i++) print (char) ROM_GAMESERIAL->i;
];

-)

Section - Serial Number Z-machine (for Z-machine only)

Include (-

[ SerialNumber i;
	for (i=0 : i<6 : i++) print (char) HDR_GAMESERIAL->i;
];

-)

Section - Access Low-Level Data

[The extended story headline is necessary so that, if the author doesn't set the story headline value, "An Interactive Fiction" is printed out.]
To say extended story headline: (- TEXT_TY_Say(Headline); -).
To say story serial number: (- SerialNumber(); -).
To say I7 version number: (- I7VersionNumber(); -).

Section - Check Texts for Blank

To decide if (s - text) is blank: if the substituted form of s is "", yes; no.
To decide if (s - text) is not blank: if the substituted form of s is not "", yes; no.

Section - Copyright Line Related Rules

The story copyright string and story rights statement are text variables.

Printing the story copyright line is an activity.

Last rule for printing the story copyright line (this is the standard story copyright rule):
	if the story copyright string is not blank:
		say "Copyright [unicode 169] [story copyright string][if story author is not blank] by [story author][end if][line break]";
		if the story rights statement is not blank, say "[story rights statement]";
		otherwise say "All rights reserved";
		say "[line break]";
	rule succeeds.

Last rule for printing the banner text (this is the extended banner rule):
	say "[bold type][story title][roman type][line break][extended story headline][if story author is not blank] by [story author][end if][line break]";
	carry out the printing the story copyright line activity;
	say "Release [release number] / Serial number [story serial number] / Inform 7 v[I7 version number][line break]";
	rule succeeds.

Extended Banner ends here.

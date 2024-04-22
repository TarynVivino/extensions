Version 2.0.240130 of Standard Rules Dead Code Removal by Nathanael Nerode begins here.

"Reduce the size of games using Room Description Control by removing unused Standard Rules material.  This version tested with Inform v10.1."

Volume - Strip locale apparatus (for use with Room Description Control by Emily Short)

[Note that you must leave out the word Unindexed but include the dash in order to get this to match.]
[At least you don't need to include the space after the dash.]
Section 7 - Response Texts and Vestigial Locale Activities (in place of Section 7 - Locale descriptions - in Standard Rules by Graham Nelson)

[ The stub for "to describe locale" is needed because it's hooked by:
	(a) two rules in Standard Rules which are deleted from rulebooks by Room Description Control;
	(b) a rule in Rideable Vehicles, to describe the contents of the animal just after the player gets on the animal.  We handle this issue the simple way: we don't do it.  Story author can override this.
]

To describe locale for (O - object):
	do nothing.

[ Deleting *any one* of these three lines will blank out a lot of response lines and cause 'quit' to fail in Inform 6M62. Even though they appear unused.  They are presumably referenced internally by NI. ]
Printing the locale description of something (documented at act_pld) is an activity. [30]
The locale paragraph count is a number that varies.
Choosing notable locale objects of something (documented at act_cnlo) is an activity. [31]
[ Deleting this line will throw "Programming errors" and cause 'quit' to fail in Inform 6M62. Even though it appears unused.  It is presumably referenced internally by NI.]
Printing a locale paragraph about something (documented at act_plp) is an activity. [32]

Standard Rules Dead Code Removal ends here.

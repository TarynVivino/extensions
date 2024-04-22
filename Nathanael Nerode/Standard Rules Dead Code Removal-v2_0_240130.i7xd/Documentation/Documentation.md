Section - What This Is

This is an experimental extension for those who would like their generated code to be a little smaller.

Room Description Control replaces a large hunk of Standard Rules code, but it doesn't actually remove any of the code, or the gigantic table (8K in Counterfeit Monkey) associated with it.  This attempts to remove that.

Note that this will subtly change the behavior of Rideable Vehicles: no description of contents of the animal will be printed after mounting a rideable animal.  Authors can always override this.

On the first successful test, this stripped 31KB out of Counterfeit Monkey.  Not a huge amount in an 8.4MB game, but not nothing either.

Section - Changelog

	2.0.240129: Update to current Inform v10.2/11, which is very picky about how to name replaced sections.
	2.0.220521: Update to Inform v10.1, which renamed sections of the Standard Rules, largely for the better.
	1: First version.


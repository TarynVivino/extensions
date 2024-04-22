Section - Purpose and Function

If you're using the English language, there's a lot of unnecessary gender tracking code in the Inform 6 templates layer, which is used for French, German, etc.  This includes heavily used loops when listing objects.  My extension Gender Options replaces a substantial amount of the gender tracking code.  Since the Inform 6 compiler doesn't do any optimization, it's worth doing it ourselves.  This gets rid of the rest of the dead and irrelevant gender tracking code for a small speedup.

It is strongly recommended to tell the I6 compiler to strip out unused subroutines to shrink the story file size.
	Use OMIT_UNUSED_ROUTINES of 1.

Section - Interaction with Other Extensions

This requires rather invasive replacements of large sections of I6 template code just to change one or two lines.  This may interfere with other extensions which patch the I6 code.  If this happens, each section can be individually disabled, as follows:

	Section - Disabled 1 (in place of Section - Patch ScoreMatchL in Gender Speedup by Nathanael Nerode)
	Section - Disabled 2 (in place of Section - Patch PrefaceByArticle in Gender Speedup by Nathanael Nerode)
	Section - Disabled 3 (in place of Section - Patch PNToVP and RegardingMarkedObjects in Gender Speedup by Nathanael Nerode)
	Section - Disabled 4 (in place of Section - Patch WriteListOfMarkedObjects in Gender Speedup by Nathanael Nerode)

One section exists solely to support other extensions which are patching the other sections, so you shouldn't replace it, but if you need to:
	Section - Disabled 7 (in place of Section - Replace GetGNAOfObject in Gender Speedup by Nathanael Nerode)

The ScoreMatchL changes specifically conflict with Disambiguation Control by Jon Ingold, which is not currently working with 10.1 (and no other extension I know of).  I may try to get this working.

The PrefaceByArticle changes conflict with multiple extensions making bugfixes to PrefaceByArticle.  I may try to get the bugfixes pushed upstream.

Fluid Pronouns by Zed Lopez touches all of this code and is likely to conflict with both this and Gender Options.

Section - Changelog:

	4.0.240107: Update to new version of Inform.
	4.0.230722: Update to new version of Inform.
	3.0.220534: Section documentation.  Format Changelog.
	3.0.220523: Adaptation to Inform 10.1.  Additional documentation on extension conflicts.
	2/210331: Change disambiguation treatment with names of rooms.  Should fix Counterfeit Monkey regtests
	1/170816: first version


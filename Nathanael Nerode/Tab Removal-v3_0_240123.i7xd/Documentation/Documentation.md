When the player types tabs, this extension replaces them with spaces.

Tabs can appear in commands when typed at the keyboard by the player.  Tabs are handled very badly in the Standard Rules; they are treated as part of a word (like letters).  They can't be printed by Glulx.  This creates all kinds of confusing problems.  This fixes those problems.

The worst problem:  When Glulxe goes to print an error message which contains a tab which originally came from the keyboard, it issues a runtime error saying that it can't print character 9* (the tab character) -- in the middle of this "word"!  This is a pretty cryptic error message, especially since Glulx can actually print tab characters if they're specified in the Inform source code as [unicode 9].

Accordingly, I recommend that everyone use this extension at all times for all games.

The Z-machine implementation is pretty clean and should continue to work in all versions.

The Glulx implementation has been tested with Inform v10.2, but it is dependent on the internals of the Inform implementation.  (This is because of a nasty bug in the implementation of Inform for Glulx which I haven't been able to track down, where it doesn't translate correctly from the input alphabet to the output alphabet.)

Changelog:

	3.0.240122: Comment improvements
	3.0.240121: Adapt to changes made for Unicde in Inform v10.2.
	2.0.220522: Docs typo fix.
	2.0.220520: Adapt to Inform 7 v10, by changing the method of replacing I6 code.
			Minor documentation updates.  Use authorial modesty on this one.
	1/210314: Change short description.


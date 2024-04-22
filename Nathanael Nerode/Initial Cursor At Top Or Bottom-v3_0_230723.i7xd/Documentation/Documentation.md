Section - To Start at the Top

If you want the beginning of the game to start immediately below the status line, this extension will do that for you automatically.

The standard library prints out three lines at the beginning of the game for historical reasons; this eliminates that.  (Certain Z-Machine interpreters will add an additional blank line, but there is nothing we can do about that.)

Section - To Start at the Bottom

If, as I did, you want to the beginning of the game to start at the bottom of the screen, like the older Infocom games, it's harder.  The only way to do it is to print out a bunch of blank lines.  There is a method specified in both Glulx and Z-Machine to figure out how many lines tall the screen is... but unfortunately, most interpreters are extremely buggy when it comes to this and give the wrong number.  If you can choose your interpreter, currently glulxe, git, or frotz for curses are the least buggy.

Somewhere during startup before printing the banner, do this:

	initialize the cursor to (num) lines above the bottom;

Here, num should be the length (number of lines) of the initial banner, first room title and descriptive text, all the way to and including the first command prompt.  (So it should be at least 1, if you simply print the command prompt and nothing else.)  You can guess how many lines it is or perhaps calculate it (that is beyond the scope of this extension).

If you have a one-line room description and a standard banner, 8 lines above the bottom will work.  See the example "Bottom".
	before printing the banner text:
		initialize the cursor to (num) lines above the bottom;

Section - Parameters

The interpreter is supposed to tell us how many lines there are on the screen.  This number goes in

	semi-cooked screen height

But the interpreter is often inaccurate.  So

	the interpreter screen height error

is set to a worst-case estimate of how wrong the interpreter is.  If the error is 4, the interpreter thinks the screen is 4 lines longer than it really is.  If we print too many blank lines, we will say "[MORE]" at the very start of the game.  In order to avoid this, the default is to compromise and print far enough up that it's above the bottom on the most defective interpreter.  If you know what interpreter you're using or are intolerant of interpeter bugs, you can change this: for instance, if you're using frotz for curses, you can set it to 0:

	the interpreter screen height error is 0.

Unfortunately there is no good way to detect the interpreter from within the game file.

There's one more parameter you can adjust:
	the interpreter start line

This tells us which line of the screen the game is starting on by default.  Due to different screen models, this is 1 for Glulx (meaning the first line of the window) and 2 for Z-Machine (including the status line as line 1).

This extension removes the 3 newlines which are printed by default in the standard library, but if you disable that portion of the extension, you'd want to increase the interpreter start line by 3.

Section - Z Machine Interpreter behavior

Frotz for curses (1.0 / 1F) starts at the top of the screen by default, in compliance with the standards.  It can be pushed to the bottom using line counting code.  It reports correct screen height.  It also knows how to clear the window.  This is the gold standard!
Bocfel (1.1/1C) starts at the bottom of the screen by default.  The line counting code is unnecessary.  It reports correct screen height but will produce a "more" if you try to use the last line of the screen, so error of 1.
Zoom (1.1 / 3Z) starts at the top of the screen.  It can be pushed to the bottom using line counting code -- but claims 30 lines on a 25-line screen, for a huge 5 line error.  It also knows how to clear the window.
Xfrotz (1.0 / 1F) can be pushed to the bottom of the screen using line counting -- but claims 46 lines on a 40-line screen, for a monumental 6 line error.  It also knows how to clear the window.
Unfortunately, "frotz-dumb" (1.1 / 1F), used by Inform 7 in its internal interpreter, is *defective*, violates the Z machine standard, and doesn't report the screen height correctly.  It should report 255, meaning "infinite scroll".  Instead it claims 40 lines on a 36 line screen, for a 4 line error -- but it's not predictable how many extra lines it reports; it adds arbitrary numbers!  It also can't clear the window.
Most unfortunately, there is *no obvious way for the game file to spot the difference* between the two frotzes.

Section - Glulx interpreter behavior

Git starts at the bottom of the screen by default.  It will trigger a "more" on the last line of the screen if you're not careful.  It reports correct screen height.
Gargoyle uses git.
Glulxe starts at the top of the screen.  It reports correct screen height and can use the last line of the screen.
glulx-dumb, used by Inform 7 in its internal interpreter, starts at the top of the window.  It reports correct screen height and can use the last line of the screen.  However, it can't clear the window.

Section - Thanks

	Thank you to Doug Orleans for writing "Everything We Do is Games" -- an "empty game" which attempts to exit immediately, inspired by John Cage.  His research, documented in the source code, explained where the three bogus newlines were coming from.

Section - Changelog

3.0.237022 updated for the latest version of Inform (changes in 10.1 or later)
	2.0.220604 reformatted the examples.
	2.0.220524 reformatted the Changelog.
	2.0.220521 adapted the extension to Inform v10.
	1/170827 was the first released version.


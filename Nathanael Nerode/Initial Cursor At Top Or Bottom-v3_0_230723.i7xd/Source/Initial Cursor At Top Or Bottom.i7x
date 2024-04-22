Version 3.0.230723 of Initial Cursor at Top or Bottom by Nathanael Nerode begins here.

"This small extension eliminates the three newlines printed before the banner.  It also provides a tool to attempt to place the cursor at the bottom of the screen, like old Infocom games.  Due to wild variance between interpreters, it is not reliable.".

Section 1 - Advance Screen to Bottom

The interpreter screen height error is a number which varies.
The interpreter start line is a number which varies.

[Please note that an extra line break might be printed if we "say" *anything*, including debugging code.  This is an artifact of the paragraph breaking system.]

[Window clearing actually doesn't work on several interpreters.]
To clear the main window: (- VM_ClearScreen(WIN_MAIN); -)

To initialize the cursor to (n - a number) lines above the bottom:
	if we should advance the screen to the bottom:
		let cooked screen height be semi-cooked screen height minus interpreter screen height error;
		let targeted line be cooked screen height minus n;
		Clear the main window;
		repeat with counter running from interpreter start line to targeted line:
			say "[line break]". [*This puts a carriage return at the end of line # counter]			


Section 2 - Screen Height (for Z-machine only)

To decide if we should advance the screen to the bottom:
	if raw screen height is 255, decide no; [* This signifies a teletype style interpreter]
	decide yes.

To decide which number is the raw screen height: (- VM_ScreenHeightWord() -)
[* Z-machine uses 1-based screen height.]

To decide which number is raw font height: (- VM_FontHeight() -)

To decide which number is raw font width: (- VM_FontWidth() -)

Include (-
[ VM_ScreenHeightWord; return (HDR_SCREENHUNITS-->0); ];

[ VM_FontHeight; return (HDR_FONTHUNITS->0); ];

[ VM_FontWidth; return (HDR_FONTWUNITS->0); ];

-)

To decide which number is semi-cooked screen height:
	decide on raw screen height divided by raw font height.

The interpreter screen height error is usually 6.  [* Worst case: xfrotz.]
The interpreter start line is usually 2.

Section 3 - Screen Height (for Glulx only)

To decide if we should advance the screen to the bottom:
	decide yes.

To decide which number is the raw screen height: (- (VM_ScreenHeight() + 1 ) -)
[* Glulx annoyingly uses zero-based screen height.]

To decide which number is semi-cooked screen height: decide on raw screen height.

The interpreter screen height error is usually 1. [* For git, to avoid triggering "more".]

The interpreter start line is usually 1.

Section 4 - Suppress Initial Newlines

[* There are three bogus newlines included because of the behavior of obsolete ITF and Zip inteprereters.
Get rid of them.  In the latest version we do not need to drop into I6 to do this.]

The initial whitespace rule is not listed in any rulebook.

Initial Cursor at Top or Bottom ends here.

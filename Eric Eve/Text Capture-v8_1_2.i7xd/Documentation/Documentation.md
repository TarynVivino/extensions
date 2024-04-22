Section: Overview

This extension defines four new phrases:

	start capturing text
	stop capturing text
	say captured text
	if text capturing is active

The first and second of these phrases allow you to capture any text before it is sent to the screen. The captured text can subsequently be displayed (or copied to an indexed text variable) using the third of these phrases.

A typical situation where this is useful is when we want to not only suppress the standard report from an action (with 'silently') but any failure reports as well. A typical pattern would be:

	start capturing text;
	silently try taking the noun;
	stop capturing text;

If it proved impossible to take the noun (because it was fixed in place or locked in a glass container, say), the failure message would not be displayed, and the action would be completely silent. The failure message would still be available however; we could either display it at some other point with:

	say captured text;

Or store it in an indexed text variable for later use:

	now mytextvar is "[captured text]";

The test "if text capturing is active" can be used to determing whether or text capturing is currently in progress. The phrases "start capturing text" and "stop capturing text" effectively make this check in any case, so that issuing "start capturing text" when text capturing is already active does nothing, as does "stop capturing text" when text capturing is not active.

Section: Limitations

1.  The extension uses only a single text buffer, and each time a start capturing text/output something/stop capturing text sequence is executed, the buffer contents will be overwritten. You can get round this by copying the contents of the buffer to an indexed text variable, as shown above.

2.  By default the text capture buffer has a maximum length of 256 characters, so it should only be used for fairly short pieces of text. Overflowing the buffer will cause a run-time error in Z-Code games, and the loss of all characters beyond the 256th in Glulx games. If a larger buffer is needed, use the maximum capture buffer length option:

	Use maximum capture buffer length of at least 512.

3.  Beware of using certain debugging verbs such as RULES or RULES ALL whenever text capturing might become active, since their output will be captured as well, which will almost certainly overflow the buffer.


Chapter: Change log

8.1.1 Updated for 10.2, removed FyreVM support -- ZL

Chapter: Examples


This is an expansion of Emily Short's Glulx Text Effects extension which allows the writer to use or manipulate any of the standard Glk styles. The tables and such work almost exactly as in Glulx Text Effects (so don't use them together), and this extension should be fully "backwards-compatible" with Glulx Text Effects code.

The styles are called normal style, italic style, preformatted style, header style, bold style, alert style, note style, block-quote style, input style, special-style-1, and special-style-2. (The last two are hyphenated to maintain compatibility.)

To invoke any of these styles, use the say phrase "using [style]". For example, "This text is [using bold style]bold[using normal style]!" would be equivalent to "This text is [bold type]bold[roman type]!" on the Z-machine.

The Inform style names match the Glk ones, with a few exceptions: the User1 and User2 styles are named as in Glulx Text Effects, and the Emphasized and Subheader styles are renamed to italic and bold (which is what Inform uses them for by default).

The one change to the table is the addition of the "glulx background color" column, which changes the background color of the specified style. On Gargoyle changing the color of the normal style changes the background color of the window, but this is non-standard behavior.


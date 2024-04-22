Chapter: Version Note

This version of the extension breaks compatibility with any previous version earlier than version 4. It is highly recommended to upgrade all code using any previous version of Atmospheric Effects to use this version.

Version 4 of Atmospheric Effects was a complete rewrite, containing almost all the features available in previous releases. This version is improved to work better, and to separate the displaying of scenic messages from the generation of them in a greater degree. (In the last version, where the messages were generated just before the prompt, the scene changing mechanism had run between the result of the action and the generation of messages; now, the messages are generated just after getting the result of the action, and the messages are displayed only just before prompting for the next command, which seems to fix the problem of messages dependent on scenes.)

Section: 6L02 Compatibility Update

This extension differs from the author's original version: it has been modified for compatibility with version 6L02 of Inform. The latest version of this extension can be found at <https://github.com/i7/extensions>.

This extension is released under the Creative Commons Attribution licence. Bug reports, feature requests or questions should be made at <https://github.com/i7/extensions/issues>.

Chapter: The Kinds Provided

This extension provides four kinds of value; a scenic type, a running type, a further type and an ignoring type.

Section: The Sceninc Types

The scenic types are
	* fully random (with full random as a synonym), displaying messages in a completely random order, without regard to if the message has been shown or not;
	* random, displaying messages in a constrained random order, so that each message in the table is shown once before any message may repeat; and
	* ordered, listing the messages in the same order they are defined in the table.

Section: The Running Types

The running types are
	* run once (with once as a synonym), the messages of the table will show up only once; and
	* run forever (with forever as a synonym), the messages will loop once the table has been used, and if the scenic type is random, again in a random order (making sure the same message does not appear twice in a row).

Section: The Further Types

The further types are
	* default, which changes to the Table of Default Messages once all the messages in the current table have been exhausted; and
	* stopping, which stops the current table once it has been exhausted and doesn't bring in a new source of messages.

Section: The Ignoring Types

The ignoring types are
	* ignore, which
		1) In the Atmospheric Definition table on things tells the extension to ignore rooms and regions (note that at the moment this means that even if the thing has ran out of messages, it forces the room and regions to be quiet whenever it is present);
		2) In the Atmospheric Definition table on rooms tells the extension to ignore regions;
		3) In the Atmospheric Definition table on regions tells the extension to ignore larger regions; and
		4) In the subtables of the Atmospheric Definition table tells the extension to ignore all lines after the current line in case a message was shown.
	and
	* do not ignore, which is the opposite of ignore.

Section: How Types Interact

For entries with a scenic type of fully random, the running type and the further type are completely ignored, and for entries with a running type of run forever, the further type is completely ignored.

Chapter: The Tables Required

Section: The Table of Atmospheric Definition

To use scenic effects in our games, we need to define the following table:

	Table of Atmospheric Definition (continued)
	loci		ignoring		subtable
	an object	an ignoring type	a table-name

The loci entry contains the name of the room or region for which to use the subtable entry for messages, while the ignoring type tells the extension whether to ignore messages from larger entities containing the player.

Section: The Sub-Tables of the Table of Atmospheric Definition

In addition, for each separate subtable required, we need to define a table following the form of:

	Table of Example Atmospheric Definition
	during	initch		latch		aftcnt		curcnt		sctype		runtype		frtype		igtype		subtable
	a scene	a number	a number	a number	a number	a scenic type	a running type	a further type	an ignoring type		a table-name

Where the during entry is the name of the scene during which the messages from the subtable will be displayed (or empty for any time), initch is the initial chance of displaying messasges, latch is the later chance for displaying messages, aftcnt is the number of messages to show before changing from the initial chance to the later chance, curcnt is the current amount of messages shown, sctype is the scenic type of the messages to be shown, runtype the running type, frtype the further type, igtype the ignoring type and finally subtable contains the name of the table from which the messages will be picked.

If any of these entries except the during entry and the subtable entry are missing, they will be initialized automatically. The initial chance to 100 percent, the later chance to the initial chance, the after count to 0, the scenic type to random, the running type to run forever, the further type to stopping and the ignoring type to do not ignore. If the subtable is the Table of Default Messages, the running type is automatically set to run forever and the further type to stopping. The current count is always initialized to 0. If there is no subtable entry, the whole row is ignored.

Section: The Sub-Tables of the Sub-Tables of the Table of Atmospheric Definition

For each separate table of messages required, we also need to define a table according to the following specification:

	Table of Example Messages
	used		message
	a number	text

Section: The Table of Messages to Show

In addition, we may need to continue the Table of Messages to Show, in case there may be more than 20 messages to show at one time. This is done as follows:

	Table of Messages to Show (continued)
	message
	with <number> blank rows

Chapter: The Tables Defined

This extension provides a few tables of its own, each one empty except for one blank row to contrain the contents of the table. We have already encountered one of these, the Table of Atmospheric Definition, which is used to initialize the locations and regions of the game world with the correct scenic messasges.

The second one is the Table of Default Atmospherics. If we fill this table up with information, the messages of any subtables of it will be shown in any room or region not mentioned in the Table of Atmospheric Definition.

We are also provided with the Table of Default Messages, which can be filled with messages to be used when the further type of some messasge source is default and all the messages in the original table of messages have been shown.

Also, the extension brings us the Table of Messages to Show, which is used to collect the messages to be displayed during one turn. The default size of the table is 20 rows, which may be increased if necessary.

Chapter: Overriding

Section: How to Override this Extension's Default Behavior

If necessary, it is possible to override two of the rules provided by this extension. The first, called "the scenic messaging rule", allows for the modification of the message-generating process. The second, called "the scenic displaying rule", allows for the modification of the message-displaying process. If we wish to override one or both of these rules, it is possible with a procedural rule such as the following one:

	Procedural rule:
		substitute own messaging rule for the scenic messaging rule;
		substitute own displaying rule for the scenic displaying rule.

Section: How the Scenic Messaging Rule is Defined

The scenic messaging rule provided by the extension is defined as follows:

	A first every turn rule (this is the scenic messaging rule):
		correct synonyms;
		check thing messages;
		check room messages;
		check region messages.

Section: How the Scenic Displaying Rule is Defined

The scenic displaying rule provided by the extension is defined as follows:

	A last before reading a command rule (this is the scenic displaying rule):
		display all messages.

This rule has been defined as a before reading a command rule, so that the first messages will be shown before reading the first command in the game.

Chapter: Internals

The extension defines a kind of value called shown type used on regions. It is highly recommended that it not be used by anyone.

The extension also defines a region called the empty region. It is used by the extension to manage looking through regions.



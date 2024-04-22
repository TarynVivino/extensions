Section: Using Debug Tags

Many programmers now use debug tags, also known as comment tags, to mark points in their code that need attention.  This extension adds a way of doing this in Inform that is scriptable, manageable, and, most importantly, doesn't mess up released code.

A debug tag is just an object like anything else.  We create one thusly:
	
	{*}CANNOT OPEN DOOR is a debug tag.
	
However, we generally don't refer directly to debug tags.  Instead, we create different types, for ease of reference:
	
	{*}CANNOT OPEN DOOR is a FIXME.
	IMPLEMENT DOOR OPENING MECHANISM is a TODO.
	
Both these tag types are defined by the extension.  A list of all such predefined tag types is given in a later section.

When the game starts, we will be given a list of all debug tags.  With default settings, the previous example would generate the following:
	
	DO NOT RELEASE: SERIOUSLY INCOMPLETE
	STOPSHIP: CANNOT OPEN DOOR.
	TODO: IMPLEMENT DOOR OPENING MECHANISM.
	
Note that the FIXME tag calls itself a STOPSHIP.  Tags have control over what they call themselves (called the type of the tag), and we try to keep the number of different reported types for tags down to a minimum for easy reading, even as more and more different actual types are defined.  (STOPSHIP and FIXME, for instance, are both valid kinds of tags with type "STOPSHIP".)

During the game, the command TAGS will reprint the list of debug tags for convenience.  Tags are automatically moved to nowhere at the beginning of released games, and the printout will not appear.

Section: Advanced Usage and Creating Debug Tags

Tags can be put in locations.  This will be reported at game start, and provides an Inform-friendly way of reminding yourself where the problem is.  Example B uses this.  Tags are scenery, so they shouldn't affect beta-testing much.

Each tag also has an assignee.  This is just a text field for the name of who should be fixing the bug or implementing the feature.  Example B demonstrates this.

Finally, each tag has a priority.  Smaller numbers mean more serious bugs.  Normal tags are at 100 by default; "serious" tags like STOPSHIP and FIXME are at 10.  By default, having any tags with priority of 99 or higher will cause a "DO NOT RELEASE" message to be displayed at the beginning of the game.  The urgent tags message, the priority of each tag, and the urgency threshold can all be overridden.  Example B demonstrates how, and the relevant lines are repeated here:

	{*}An unimplemented object is a kind of debug tag.  The priority of an unimplemented object is usually 1.
	The urgent tags message is "Some F-35 systems not fully implemented."
	The urgency threshold is 5.
	
This will cause unimplemented objects, but not serious tags, to cause an urgent tags message to be shown.  If you don't want the message to ever be shown, set the urgency threshold to -1.  If you set it to 0, it will be reset to 99.

Tags are always printed sorted in priority order, lowest first.

Section: Defaults and Predefined Debug Tags

The default urgent message is "DO NOT RELEASE: SERIOUSLY INCOMPLETE".  The default urgent threshold is 99 -- tags with priority of 100 or lower will not cause the message to be printed.

Predefined serious tags ("STOPSHIP"):
	
	STOPSHIP
	FIXME
	BUG
	
Predefined standard tags ("TODO"):
	
	TODO
	XXX
	HACK
	NOTE
	QUESTION
	ALERT
	CAVEAT
	IDEA


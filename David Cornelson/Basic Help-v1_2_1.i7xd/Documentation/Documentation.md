This extension allows you to add basic Interactive Fiction help to your game.

When play begins, that the help system will display a message telling of its existence.

After a parser error, the hint system will remind the player it's available.

For the first 4 turns in the game, the hint system will show a notice.

The author can add common commands by using the list 'add' feature and this will display them within the 'help commands' description.

	when play begins:
		add "xyzzy" to Help Common Commands.

After the help has stopped reminding the player, the author can set the Help Switch to true and for another 4 turns, the help reminder will be displayed.

If the author simply wants to remind the player directly, they can 'Print the Help Notice' at any time.


Section: 6L02 Compatibility Update

This extension differs from the author's original version: it has been modified for compatibility with version 6L02 of Inform. The latest version of this extension can be found at <https://github.com/i7/extensions>.

This extension is released under the Creative Commons Attribution licence. Bug reports, feature requests or questions should be made at <https://github.com/i7/extensions/issues>.



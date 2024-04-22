
Thanks to Neil Butters for the code feedback!

Section: Basic Use

Punctuation, words that sound like other words, and made-up words aren't always clear when spoken by a screen reader. Nevertheless, parser IF requires players to spell the names of things in order to refer to them. This extension aims to make stories more screen-reader-friendly by allowing players to request the spelling of any visible thing.

This extension adds two actions:  "listing visible items for spelling" and "spelling the numbered word."

The command SPELL leads to the "listing visible items for spelling" action. This action will automatically display a list of visible things, numbering them for the player's reference. This list is made only after clearing any numbers that have previously been assigned to things in the story.

To request the spelling of an item, the player can then type SPELL followed by the item's number on the list.


Section: Options

By default, players will be asked at the start of play if they are using a screen reader. Then if the player answers YES, the spelling features will be briefly explained. To turn off this opening question and introduction (for instance, if we want to introduce the spelling features elsewhere) we can set "introduce simple spelling features" to "false":

	{*}introduce simple spelling features is false.
	
If we do want the question and introduction, but only in a released version of the story, we can put the above code in a section marked "Not for release":

	*:
	Section - Introducing spelling features - Not for release
	
	introduce simple spelling features is false.

By default, this extension will check for duplicates when making a spelling list so as not to include the same entry twice. This is helpful if we have duplicate items in our story and want to avoid, for instance, listing twenty identical coins as twenty separate items on the list. If we want to skip the check-for-duplicates step, we can set "inspect simple spelling list for duplicates" to "false":

	{*}inspect simple spelling list for duplicates is false.



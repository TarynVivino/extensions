Glulx Image Centering adds the ability to display an image that is centered (left/right) on the screen. To do this, it uses up the first of the two available custom user text styles, defining it to be center-justified.

To invoke Glulx Image Centering, we say

	display figure foo centered.

To display cover art in our game, we might include something like this:

	Include Glulx Image Centering by Emily Short. Include Basic Screen Effects by Emily Short.

	When play begins:
		display figure of small cover centered;
		pause the game.

This would display a picture in the middle of the screen, then wait for a keypress, then clear the screen before going on with the game.

A word of warning: not all Glulx interpreters will necessarily handle this operation correctly. Authors are advised to check the performance of their game on a variety of interpreters, or have their beta-testers do so.



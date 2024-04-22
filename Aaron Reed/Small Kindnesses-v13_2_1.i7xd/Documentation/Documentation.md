Players often stumble on minor annoyances in the standard behavior of an Inform game. Many of these have been "fixed" over and over again by individual authors. This extension packages up a number of these small kindnesses, many taken from examples in the Inform 7 documentation, to make things a little easier for your players.

This extension is designed to play well and overlap as little as possible with several similar extensions. Anyone including this extension should highly consider also using Modified Exit by Emily Short, Locksmith by Emily Short, Extended Grammar by Aaron Reed, and Implicit Actions by Eric Eve. It borrows a few pieces of functionality from these extensions, in case of compiling for a small platform. This extension should function well with or without any of these.

Simply including the extension is all that is needed, unless you wish to remove some of the behaviors. To remove one, replace the section title with a blank or modified bit in your code (see "Extensions can interact with other extensions" in the docs). For example, if you don't want the implementation of a "use" verb:

	Section: No use verb (in place of Chapter - Implement Use verb for common actions in Small Kindnesses by Aaron Reed)

Here are the names of all the sections.

	Section: Exit leaves when there's only one way to go
	Section: Go Back returns to previous location
	Section: Examining the room
	Section: Automatically leave containers before going
	Section: Show valid directions after going nowhere
	Section: Allow for switching things in darkness
	Section: Don't perform implicit actions for doomed tasks
	Section: Implement Use verb for common actions



Section: Overview

The purpose of the Debug Files extension is to provide a way to record debugging information to a text file while beta testers play the game. This information can then help the author to locate problems found during the testing.

The usual convention is that the beta testers save a transcript of their playthroughs for the author to read. When using this extension the game creates another file, called "debug.glkdata" (the actual extension depends on the interpreter used). The author can have the game output information to this file at any point. The text is not displayed to the player so beta testers can play the game without debug information cluttering the view.

Z-machine can't save external files. Therefore this extension is Glulx-only.


Section: How to use it

To use this extension you have to declare "Use debug files" in addition to including the extension.

	{*}Include Debug Files by Juhana Leinonen.
	Use debug files.

The purpose of the use option is that you can remove that line when you release the game, so that the final version will not save any debugging information. (I7 has a built-in system that could disable the extension in released games, but the use option is there because the author might not want to give debug builds to beta testers.)

There will be two changes in the game itself: firstly, a "play session identifier number" is displayed after the banner text. This random 5-digit number is shown in both the transcripts (if not, the testers should type VERSION after starting the transcript to have it shown) and debug files. The purpose is to facilitate matching debug files to the corresponding transcripts.

Secondly, there is an incrementing number printed before the prompt (the prompt counter). The number helps matching the debug information to the corresponding action in the transcript. Note that this number is not the same as turn count: the prompt counter advances every time the player issues a command, regardless of whether the action advances the turn count.

To save information to the file, use the command 'debug':

	After burning a match:
		say "The match burns quickly out.";
		remove the noun from play;
		debug "There are [number of matches in the matchbox] matches remaining."

The debug text is saved to the file with the prompt counter automatically added. Nothing is printed to the player. If you remove the "Use debug files" option, the debug commands do nothing.

The author might use this functionality to, for example, track a wandering NPC:

	Every turn:
		debug "Bob is now in [the location of Bob]."

The debug file would then read:

	<2>: Bob is now in the gym.
	<3>: Bob is now in women's dressing room.
	<4>: Bob is now in the police lockup.

(numbers would be in square brackets.) The numbers would correspond to the prompt counter shown in the transcript.


Section: About the saved file

The location where the debug file is saved will depend on the interpreter. This is probably the same directory where the game file is. The Inform 7 IDE saves the file to the same location where the project file is.

If the interpreter can't save the debug file for some reason, the game will probably crash.

If the debug file already exists, new information will be appended to the old data.


Section: Version history

Version 2 (April 2014): Modified the extension for compatibility with the new release of Inform.



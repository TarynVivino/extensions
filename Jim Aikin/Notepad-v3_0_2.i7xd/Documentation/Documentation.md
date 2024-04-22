Section: What it does.

Notepad allows the author to create one or more things called notepads. The player can write text on a notepad, read the text, erase the text, add to the text, erase specific strings of characters from the text, and copy the text from one notepad to another. Text on a notepad can be write-protected. Other characters can also use notepads, if ordered to do so by the player.

By default, a writing implement is needed to write on a notepad (but not to erase what's on it -- if you want to implement an eraser object, you'lll need to customize the extension). The writer must be carrying the writing implement.

Version 3 is updated to work with Inform 6L38. The Check rules in Sections 4 and 5 have been edited to reflect Inform's more strict handling of the declaration of temporary variables, the now deprecated syntax "change X to Y" has been removed, and references to indexed text have been dropped. Adaptive text has been implemented so as to allow the use of third-person and past tense narrative.

Section: Using Notepad.

To use Notepad, first create a writing implement and a notepad. The writing implement is not a special kind of thing; anything can be a writing implement (for instance, a fountain pen, which might be implemented as a container that needs to be loaded with ink). Add the writing implement to the list of allowed-pens of the notepad:

	The player carries a piece of chalk. The player carries a slate. The slate is a notepad. The allowed-pens of the slate is {chalk}.

Any number of writing implements can be included in the allowed-pens list for a notepad. If you'd rather let the player write on the notepad without bothering with a writing implement (perhaps because the notepad object is a hand-held computer with a QWERTY keyboard), forget about the allowed-pens list. Instead, set the pen-needed property of the notepad to false:

	The foggy mirror is a notepad. The pen-needed of the foggy mirror is false.

The text of a notepad is held in a property called memo. If you want the notepad to start the game with a message already written on it, put something in the memo property:

	The memo of the foggy mirror is "Beware! Ghouls!"

By default, when a notepad is examined, its memo is printed out in a separate paragraph after the description. If you don't want this effect, perhaps because you're handling it yourself in the description, you can override the default like this:

	The notepad output rule is not listed in any rulebook.

In practice, long texts may slow the interpreter noticeably. The erasing it from action can become quite sluggish with long texts.

Section: New Commands

The player (or an NPC who has been ordered to do so -- all of these actions can also be carried out by an NPC) can "read <notepad>".

The player can "write <any text> on <notepad>". "scribble" and "jot" are understood as synonyms for "write", and either "in" or "on" can be used. The extension makes no distinction between notepads that one would expect to write on (such as a blackboard) and those that one would expect to write in (such as a notebook). All input arrives in the memo buffer in lower-case letters.

The player can "add <any text> to <notepad>". This appends the new text at the end of the existing text. ("append" is understood as a synonym.) If the notepad is blank, "add" works exactly like "write".

The player can "erase <notepad>". This deletes the entire contents of the notepad.

The player can "erase <any text> from <notepad>". ("delete" works as a synonym for "erase"). This command searches the entire text and removes all instances of <any text> from it. The erasing it from command is case-insensitive, so it will delete capital letters (if any have been included in a memo text by the author).

The player can "copy <notepad> to <another notepad>". Copying overwrites the current contents of the destination notepad.

A notepad can be write-protected using the command "protect <notepad>". When it is write-protected, the write, add to, erase, erase from, and copy to commands are disallowed. The commands can be re-enabled using "unprotect <notepad>". This feature is to allow the player to take notes on game-play and avoid accidentally overwriting or erasing the notes.

Section: Known Issues

The notepad doesn't handle space characters perfectly. It will delete extra spaces when the erasing it from action would create them, but spaces themselves can't be erased (except by erasing the words on both sides of a space, and including the space character in the command).

Due to the sheer number of outputs needed and their close linkages to text, no attempt has been made to extract the output text into a table for ease of customization or use in other languages. To change the output, you'll need to copy the action rules into your source, give your copies new names, and then use a command such as "the new check erasing rule is listed instead of the ordinary check erasing rule in the check erasing rulebook."

All text is converted to lower-case when being entered. (Actually, by the parser before the write command is executed.) For this reason, it's not possible to capitalize words that are written. However, text created by the game's author can contain capitals, and these will be preserved when the text is copied from one notepad to another.

It's not necessary that the user be holding the notepad in order to use it. This is meant to accommodate notepad objects such as a whiteboard, which can't be held.

Bugs should be reported to the author at midiguru23@sbcglobal.net or editor@musicwords.net.

Section: About the Examples

Memorabilia is a kind of catch-all example, with which we can try writing, adding, erasing, copying, dropping needed pen objects, and so on.

Beethoven uses the notepad object in an unconventional way (with a little coding help from Tara McGrew). The NPC is deaf, and won't respond to normal commands. But he will respond to commands written in the conversation book if the book is then shown to him. Only one command, "play the piano", is implemented, but this device could form the basis of an entire, though admittedly cumbersome, conversation system. It works by storing the memo of the conversation book in the queued command and then retrieving it using the Rule for reading a command. The truth state Beethoven-willing will only be true immediately after the book has been shown to him.


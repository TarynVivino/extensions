This is an update of Neil Cerruti's Unknown Word Error, which is a wrapper of Neil Cerutti's Dunno extension for Inform 6:

	Dunno - A Library Extension by Neil Cerutti (cerutti@together.net)
	Version 1.0 - 25 Jun 1999
		Initial release
	Version 1.1 - 2 Apr 2001
		Modified by Andrew Plotkin for Glulx compatibility.

If, for some reason, you always wanted the Infocom-style error messages that say:

	I don't know the word "kludge".

instead of the generic message:

	You can't see any such thing.

which is the default in Inform 7.

To get this behavior, simply include this extension in your story.

To customize the message, you must replace the "don't know that word rule":

	Rule for printing a parser error when the latest parser error is the can't see any such thing error (this is the don't know that word rule):
		Let N be the position of non-dictionary word;
		if N is zero:
			make no decision;
		say "I don't know the word '[word at position N]'.";


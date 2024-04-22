Objects Matching Snippets is a very simple extension that provides a convenient way to search for names of objects within a snippet such as the player's command or the topic understood.

There are two relations that can be used for this: snippet-matching ("O is identified with S") and snippet-inclusion ("O is named in S"). These correspond to the built-in phrases "S matches O" and "S includes O."

Snippet-matching tests whether the name of object O matches the snippet S:
	
	say "[The list of things identified with the topic understood] all match the phrase '[the topic understood]' in your command.";

Snippet-inclusion tests whether the name of object O appears in the snippet S:

	say "The rooms [list of rooms named in the player's command] are all mentioned in your command."

Note that these are both object-to-snippet relations, so you can test them on rooms, directions, and regions as well as things.

If you just want to pick an object, you can use the phrase "the most likely O":

	say "You probably meant [the most likely thing identified with the topic understood]."

This phrase will return an object if there is exactly one match, otherwise it will return nothing, even if there were multiple matches.

To control what objects match, you can use a scoring system similar to the Does the Player Mean rules. This is managed using the "Did the Player Choose" rulebook. The difference is that the Did the Player Choose rules are object based, so you need to pass a description of the object you're testing:

	Did the player choose an exclamation when answering someone that: It is very likely.

The "most likely" phrase will reject any objects that score lower than the best choice. But if there are two or more objects that score equally high, it will still return nothing. To find out whether the phrase failed because nothing match or because of multiple matches, you can test "if nothing matched," "if something matched," and which objects were "likeliest" immediately after calling the phrase:
	
	Let the choice be the most likely thing named in the player's command;
	if the choice is nothing:
		if nothing matched, say "You didn't mention any things I recognize.";
		if something matched, say "You mentioned [the list of likeliest things named in the player's command] in your command.";

Remember that the "likeliest" adjective merely runs the "did the player choose" rulebook on the item described - it doesn't test whether that object was part of the "most likely" test just performed, so you must reiterate any other conditions used to invoke the phrase.

To test what objects match any snippet, you can use the "objmatch" testing command:

	>objmatch me
	"list of things identified with the topic understood" = list of things: {yourself}
	"list of rooms identified with the topic understood" = list of rooms: {}
	"list of directions identified with the topic understood" = list of directions: {}
	"list of regions identified with the topic understood" = list of regions: {}


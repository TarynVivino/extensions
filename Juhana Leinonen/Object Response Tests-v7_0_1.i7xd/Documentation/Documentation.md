Chapter: Basic usage

Object Response Tests adds new testing commands ANALYZE and TRY. ANALYZE can be used to execute all available commands on a single object to see whether all the messages make sense. TRY is similar but in 'reverse': it tests one verb with all the objects currently in the location. The syntax is TRY <action>, for example TRY PUSHING.

For actions that don't act on a noun, like jumping or waiting, there's an ANALYZE NOUNLESS (or just NOUNLESS) command that runs all such actions.

There's also an ANALYZE ALL command for those who are feeling adventurous. It runs all the tests on all the objects currently in the location. It is mainly useful for locations with not that many objects to test.

For testing the default library actions, just include the extension in your project and both these commands will become available. Actions related to speaking with persons (saying, telling, asking) are excluded because of the various ways different games handle conversation.


Chapter: Removing and adding tests

Some games may disable some of the standard library actions. To avoid confusion it might be better to skip testing these actions altogether.

	When play begins:
		remove the test burning rule;
		remove the test pushing to rule.


Of course, most games have custom actions that are not defined in the standard library. They can be included in the tests by making testing rules for them and adding those rules in the Table of analyzing actions. They will then be available for both ANALYZE and TRY commands.

	This is the test swimming in rule:
		announce tests for "swimming in [the noun]";
		try the test-actor swimming in the noun.

	This is the test kicking rule:
		announce tests for "kicking [the noun]";
		try the test-actor kicking the noun.

	Table of analyzing actions (continued)
	topic	testing rule
	"swimming in"	test swimming in rule
	"kicking"	test kicking rule
	
For nounless commands the procedure is the same but the table is called "Table of nounless analyzing actions".


Chapter: Changing the actor

It is possible to run the tests as someone other than the player character. The test-actor variable holds the person who will be the actor in the tests. This can be changed during the game with the command ACTOR IS; for example ACTOR IS BOB.

If the test-actor is not the player character any failed actions (that would usually give the "Bob is unable to do that" response) will not print anything at all. Also, the tests will not abide by the persuasion rules. In other words, if you run the tests as Bob, he will respond as if the game's source code read "try Bob shaving the yak", not as if the player had commanded BOB, SHAVE YAK which is by default blocked by the standard library ("Bob has better things to do.").

Note that the test-actor variable is set when the play begins. If the game changes the player character, the test-actor variable doesn't change automatically (that is, if you change the player character mid-game, the tests will be run as the original player character if not instructed otherwise).


Chapter: A note on releasing

The extension automatically disables itself in release versions. Any abovementioned modifications to its behavior should therefore be written in a section that has "Not for release" in the title (see chapter 2.9 "Material not for release" in the I7 manual) to avoid errors in compiling the final product.


Chapter: Version history

Section: Version 7 (2015-12-31)

- updated to work with release 6M62 of Inform.
- renamed the 'set testing actor' rule to 'set default testing actor' for clarity.


Section: Version 6 (2014-04-30)

- updated to work with the new release of Inform 7.
- added the 'analyze nounless' action.


Section: Version 5 (2013-10-26)

- added a way to disable tests without using the deprecated procedural rules.
- changed deprecated "change" phrases to "now".
- removed a duplicate test attacking rule from the test set.
- renamed the test clothing rule to test wearing rule. Older versions of I7 choked on the word "wearing" in the rule but it seems to work in the latest.


Section: Version 4 (2010-06-14)

- changed 'say test announcements for' to 'announce tests for' so that the extension would be compatibile with Inform build 6E59.


Section: Version 3 (2009-09-23)

- changed the hardcoded "[italic type]examining [the noun]: [roman type]" to a more flexible 'say test announcements for' phrase.
- changed the extension so that the table of analyzing actions is not for debug builds only, so that you can have continuations of that table in the game code and you don't have to delete them or have them in one "not for release"-chapter when a release version is compiled.


Section: Version 2 (2008-12-23)

- added the command TRY for testing a single verb with all items in the location (thanks to Taleslinger for the idea).

- added the command ANALYZE ALL for running all tests on every single item in the location (thanks to Emily Short for the inspiration).

- added the possibility to change the actor for the tests.

- changed the analyzing action's name to object-analyzing to avoid collisions with other code. It's likely that people might have an action called "analyzing" in their work.

- added a not-for-release chapter heading to example B, just because that's what's recommended in the documentation (thanks to the person in ifMUD whose name I didn't write down and have blissfully forgotten).


Section: Version 1 (2008-11-18)
- initial release



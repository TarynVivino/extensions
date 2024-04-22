"Computers" implements a basic computer set-up. Implemented computers have peripherals: such as a screen and keyboard by default, and others optionally. They may run software; several types of default software are provided. They may also have data ports of various sorts, though the behavior of these ports is minimally elaborated here.

By itself, "Computers" does not implement cords or batteries and does not worry about computer power supplies. However, if we include Power Supplies by Emily Short (which also requires Plugs and Sockets by Sean Turner), we will get power cords for our desktop computers and a combination of cords and batteries for laptops.

Chapter: Hardware

Section: The computer kind; screens and keyboards

A computer is implemented as a device that may be switched on and off. "Computers" supplies every computer with a screen (which can also be called "monitor" by the player) and a keyboard. The keyboard is required for the computer to understand typing; if one is absent, the player will not be able to enter typed commands.

When switched on, a computer plays a startup noise and displays the contents of its screen. We may change the startup noise so:

	The startup noise of the PC is "[The item described] [chime] cheerfully."

The contents of the computer's screen will depend on what software the computer is currently running. (See below.)

Section: Laptops and desktops; mice and trackpads

"Computer" has two subordinate kinds, "laptop" and "desktop computer". A laptop may be opened or closed (synonymous with switching it on and off, for simplicity) and has a trackpad. A desktop computer is by default fixed in place and has a mouse.

For non-standard configurations of computer, such as an ATM with a modified keyboard and no mouse/trackpad, we would fall back on the base "computer" kind and add the desired components by hand.

Trackpads and mice are both of the kind "selection device". If a computer does not incorporate any selection device, the player will not be able to click on things to select them on that computer. If we wished to implement a different type of console, we might alternatively make joysticks, touchpads, or trackballs as selection devices.

Section: Extension ports

"Computers" also has the concept of an "extension port", which is a generic kind suitable for implementing DVD or CD drive slots, USB ports, and any other realistic or futuristic reader for a data storage device; and the kind "data storage device", which is the only sort of item that may be placed into an extension port. An extension port may contain exactly one thing at a time.

So for instance we might write

	The CD slot is an extension port. It is part of the old PC.

	The CD-ROM is a data storage device.

...whereupon the CD-ROM may be placed in the CD slot, but nothing else will be permitted.

The extension assumes that the player who types

	INSERT STORAGE DEVICE INTO COMPUTER

really means to insert the storage device into the extension port that is part of the computer. Input will be redirected automatically if a given computer has only one extension port and the situation is unambiguous.

If we have a game in which multiple types of data storage devices exist and are to be placed in multiple types of extension ports, we may need to add subkinds of these two kinds, and restrict more thoroughly which storage devices may be put into which ports.

Furthermore, there is no default treatment of data storage devices or their effect on computers or computer software, as the possibilities are too diverse. We should decide on a per-game basis what happens when a given storage device is hooked up.

The examples show a very simple way to a storage device to extend the range of a search engine program.

Chapter: Software

Section: Software in general

A given computer may be running one or more pieces of software; whichever software is currently dominant receives the input sent by the keyboard, and is also visible when the player looks at the screen or the computer as a whole.

The appearance of the software on the screen is given by the software's description. Thus we might have

	The PC runs a password-lock program called rudimentary passcode. The description of rudimentary passcode is "[regarding the noun]A box on the screen [invite] [us] to type a password to proceed."

A computer can run several programs at once, in which case the program with the lowest "software priority" is the one that is considered to be working and receiving input at the moment. By default, most software has a software priority of five, while password-lock programs have software priority 1 (meaning they must be dealt with before other software becomes available). If it is intended that the user can change programs manually, we might handle this by changing software priorities during play to make the one in use uppermost; as in

	now the software priority of the email program is 1.

When the player uses a TYPE or CLICK ON command, the topic understood is passed on to the input handling rules. The input handling rules are an object-based rulebook and are keyed to the specific program currently dominant on the computer. One of the several input handling rules looks like this:
	
	An input handling rule for a multiple-choice program (called chosen software) (this is the pick a choice rule):
		if the topic understood is a topic listed in the options table of the chosen software:
			follow the effect entry;
			rule succeeds;
		otherwise:
			say "[out-of-bounds response of the chosen software][paragraph 	break]";
			rule fails.

...and consequently we can make new input handling rules for any new software we write, or to customize the behavior of the default software kinds.

Section: Default software kinds

Five types of software are provided by default:

(1) a password-lock program that renders the computer inoperable until the password is typed

(2) a search program that returns results on typed searches, as well as to standard syntax such as LOOK UP "whatever" IN SEARCH PROGRAM

(3) a multiple-choice program that allows the user to select options, and runs rules accordingly

(4) an enumerated multiple-choice program (the same kind of thing, but assigning a number to each choice instead of matching them with topic keywords)

(5) an email program capable of organizing incoming and outgoing messages, marking which messages are read, and reporting new arrivals.

Section: password-lock programs

To define a password-lock program, we may write something like:
	
	The PC runs a password-lock program called rudimentary passcode. The password of rudimentary passcode is "xyzzy".

Note that because of the way the z-machine handles typed input, the player's input will always be flattened to lower case before it is interpreted. Therefore passwords should always be in lower case.

We may also optionally define two other aspects of a password-lock program, namely the text displayed when the player's attempt fails, and that displayed when it succeeds. Thus:

	The rejection of rudimentary passcode is "'Password incorrect.'"
	The success of rudimentary passcode is "The password field vanishes."

Section: Multiple-Choice Programs

A multiple-choice program is one that presents the player with a series of choices to type or click on, and executes a rule whenever one is selected. This is suitable for setting up operating systems, dedicated special-purpose computers such as ATMs, or other interfaces that involve negotiating a series of menus. Items from a multiple-choice list may be selected by typing or by mouse or trackpad if one of these is available.

To set up a multiple-choice program, we must establish an options table like so:

	The operating system is a multiple-choice program. The options table of the operating system is the Table of GUI Options.

	Table of GUI Options
	topic	title	effect
	"microsoft/word" or "microsoft word"	"Microsoft Word"	open-Word rule
	"adobe illustrator" or "adobe/illustrator"	"Adobe Illustrator"	open-Illustrator rule

If we wish a multiple-choice program to function as an operating system allowing access to various other programs on the computer, we might use these effect rules to change the software priority of other programs.

A subkind of multiple-choice program is the enumerated multiple-choice program, for when we wish the player to make a selection by number. Here instead of providing a topic list, we provide an index column, which will contain numbers (but, as these will be chosen at runtime, we do not need to specify them ourselves). We may add lines to the table or remove them again if we wish to change the player's available options.

	The ATM operation program is an enumerated multiple-choice program. The options table of the ATM operation program is the Table of Transactions.

	Table of Transactions
	index	title	effect
	--	"Check balance"	balance-check rule
	--	"Quick cash"	quick-cash rule
	--	"Buy stamps"	stamp-purchase rule
	--	"Cancel"	cancellation rule

Both enumerated and regular multiple-choice programs have a response to print if the player attempts to type or select something that is not understood as an option. We may change this by altering the out of bounds response, like so:

	The out-of-bounds response of the ATM operation program is "Your selection, '[topic understood]', is not one of the available choices."

Section: Search engines

To define a search engine, we must provide a table of data, such as

	The PC runs a search engine called Goggle. The data table of Goggle is the Table of Goggle Data.

	Table of Goggle Data
	topic	title	data
	"food/cake/yellow" or "yellow cake"	"OnlineRecipes.org"	"A delicious recipe for yellow cake."
	"yellow balloon" or "yellow/balloon"	"PartyPlanning.com"	"How to order yellow balloons online."

By default, in keeping with the behavior of real search engines, this search engine will go through and match every possible topic on the list, reporting all hits, rather than matching only the first instance. This means that output can be very long if the individual descriptions are themselves long, so use with discretion.

If we wish, we can define a search engine that does not rely on the topic table but actually searches the data text for whatever string the player has typed in. This is more powerful, but slower. To turn this functionality on, we should include

	When play begins:
		now slow searching is true.
	
When slow searching is true, the search engine will ignore the topic column and instead look for the searched text in the data itself. There is an example using this behavior below.

Search engines have two pieces of text, the "no-records response" and "results-found response", as defined here:

	The no-records response of a search engine is usually "No records found.".
	The results-found response of a search engine is usually "Your search turns up the following results:".

...and as usual we may modify these to change the way search results are described.

Section: Email

Email is a program that allows the player to receive and read email from a list. To establish the email in an email program, we would write

	The message table of laptop email is Table of Laptop Messages.

	Table of Laptop Messages
	topic	message	arrival time	read	answered	description
	"memo"	"Memo"	9:00 AM	false	false	"Your boss would like to see you in his office right away."
	"SPAM"	"SPAM"	--	false	false	"Money for you from Nigeria!"
	with 10 blank rows.

Note that an arrival time is provided for "memo" but not for "SPAM". That is because memo is understood to have been delivered already, while SPAM has not. To deliver new email, we would write

	deliver "SPAM" to laptop email.

This would mark the spam message, which already exists in the Table of Laptop Messages, as available for the player to read. It would also set the arrival time.

If the player is in view of a switched on computer that is running this program, the arrival of the message will be reported at the moment when it happens. The text of this report is handled by the "new mail message" of the email program, like so:
	
	The new mail message of an email program is usually "You have new mail on [the random computer which is running the item described].".

To change this output, we would create a different new mail message for the email program in question.

Typing or clicking on one of the topic words will bring up what ever text we have put in the description field, which might be a brief summary or might be the full text of the email in question. READ email will also work.

REPLY TO email is implemented, but generally blocked by the "block replying to email" rule. This is because the behavior of replying to email is likely to vary quite a bit from game to game, depending on whether we want to allow the player some control over the email he composes and what other game-state changes result from sending that email.

If we wish to allow replies to email, we should first unlist the block replying to email rule, like so:

	The block replying to email rule is not listed in any rulebook.

At that point, default behavior of the action is to mark the email replied and to report simply "You reply." It is up to us to elaborate on this in some more interesting way.


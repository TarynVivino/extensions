
Chapter: Introduction

This extension is inspired by and heavily adapted from the Adventure Book extension by Edward Griffiths. It features the ability to switch freely between CYOA and interactive modes, has an easily modifiable parser, and better memory economy. If you are familiar with Adventure Book, you will notice a number of similarities. Pages are "pages", and the relations are familiar if named differently. There are also significant differences. Choices are no longer separate objects, but integrated as a part of the page. Rulebooks provide a more flexible and modular approach to altering the extension's default behavior.

Section: A Note About the Repeated Description Bug

Some people have reported duplicated room and page descriptions for a while. I've seen this myself, and I was aware of the problem, but because I am a lazy developer crushed by a demanding and poorly-paying day job, I just haven't had the chance to sit down and fix it until now. Now this is the patch. Rather, this is patch produced by lazily copy-pasting Vince Laviano's fix directly into the extension (thanks random forum guy!). Still, some of these are really beyond my paltry powers, so I'm going to go over three scenarios where you might encounter repeated text and their fixes.

Scenario 1: Moving the player, as in "now the player is in Hogwarts" will always print a room description, and in the case of CYOA mode will actually print the page description twice. This is hard-coded behavior, and as much as there should be a "Moving the Player to" activity, there isn't. The only way to prevent this is the use of the phrase "move the player to Hogwarts, without printing a room description". You could also use the "cyoa teleport to Hogwarts" phrase included in this extension.

Scenario 2: If you are getting repeated page descriptions in the beginning of the game, you are probably using "When play begins: switch to cyoa at p1." instead of the proper "Instead of looking for the first time: switch to cyoa at p1." Again, looking at the very beginning of a game is pretty much hardcoded behavior, and there's nothing I can do to prevent it (or really should). Alternatively, you can use the "without looking" phrase option to suppress any duplicated page description, as in "switch to cyoa at p1, without looking".

Scenario 3: Using a page-toggle rule to exit CYOA as opposed to simply labeling a page as an end-page will cause the room description to print twice. It is recommended you use the end-page property rather than a page-toggle rule, but if for some reason you need to use the page-toggle rules, you can use "switch from cyoa, without looking" as a temporary fix.

Section: Version History

	Version 7.1, 2023-04-01 updated for 10.1

	Version 7, June 21st, 2016
	-- Fixed a bug where passages were being printed twice (credit to Vince Laviano)
	-- Added options to remove looking when switching to and from CYOA modes.

	Verstion 6, December 11th, 2015
	-- Fixed a bug where page-toggle rules were firing twice for dead-end pages, and not for the previous page as intended. Page-output rules were not firing for dead-end pages at all.

	Version 5, November 4th, 2015
	-- Added adaptive text and responses in an attempt to follow Public Library guidelines.
	-- Fixed several problems with the examples.

	Version 4, October 6th, 2015
	-- Major update with significant new features.
	-- A choice can be an object, and there are now ways of handling choices which are objects.
	-- Objects can be manually inserted as choices.
	-- The choice selection response will now more accurately display what was listed as the choice.

	Version 3, August 19th, 2015
	-- Fixed a bug related to page-output rules not firing.
	-- Rewrote the choice-displaying functions
	-- Allowed authors to set choice order through the choice-priority functions.

	Version 2, February 12th, 2015
	-- Updated for compatibility to Flexible Windows version 15.
	-- Various typographical fixes (I wrote the previous documentation in a rush)

	Version 1, July 31st, 2014
	-- Initial Release
	
Section: Acknowledgements

Thanks to Hanon Ondricek, who help test and draft this document. He wrote the funny stuff.

Thanks to Edward Griffiths, who provided the model and direct inspiration for this extension.

Chapter: What is Hybrid CYOA

Hybrid CYOA is a CYOA menu-based system that can switch back to interactive modes. At the top level, it simply presents the player with a passage and a list of options.

	The murderer brandishes a wicked knife at you. What will you do?
	
	1) Fight back!
	2) Freeze!
	3) Run away!

The player can type one of the selected options. That option leads to more options.

	>1
	
	What weapon will you use?
	
	1) Fists.
	2) Sword.
	3) Grenade.

...and sometimes they won't.

	>3
	
	You toss the grenade and kill both yourself and the murderer.
	
	*** YOU DIED ***

Where Hybrid Choices gets very powerful is how it interacts with the normal parser mode we are all familiar with. Hybrid Choices has the ability to swap back and forth, allowing you to have sequences of CYOA punctuated by normal Interactive Fiction goodness.

	Where do you want to travel?
	
	1) London
	2) New York
	3) Sydney
	
	>3
	
	You take a plane to Sydney.
	
	You stand before the Sydney Opera House, north of you, and the Government House is to the south. Southwest is a pleasant promenade with shops, and southeast heads off into a beach.
	
	>

This is really only scratching the surface. There are detailed examples at the end of the document which demonstrate different things you can accomplish with Hybrid Choices. Have fun!

Chapter: Basic Usage

Section: Starting up CYOA

Hybrid Choices allows an author to seamlessly switch between the the Inform parser and a flexible choice-based adventure mode. You can do this by invoking this phrase:

	...switch to cyoa at (PAGE)...

...Where PAGE is where you want the player to start making choices.

If you want the player to start CYOA mode immediately on starting the game, simply drop in this code:

*:
	Instead of looking for the first time:
		switch to cyoa at YOURPAGEHERE.

Returning from CYOA mode is done via an "end-page" which will be explained later.

Section: Simple Choices

We can imagine a page as a passage in our favorite adventure books of yore. When we write a "page", this is like a passage in our story.

	The first junction is a page.
	"The tunnel goes left and right."
	
This is the simplest page possible. Presumably, it is the first page in our book.

Now we can add some choices.

	The left tunnel is a page.
	"You go left and find yourself in a long corridor."
	The cdesc is "Go left.". It is for the first junction.
	
	The right tunnel is a page.
	"You go right and find yourself in a large cave. A little stream runs through it."
	The cdesc is "Go right.". It is for the first junction.
	
Some notes here. The CDESC stands for "CHOICE DESCRIPTION", and it is what is displayed when this page is offered as a choice.

The second thing you'll notice is that the choice is "for the first junction". This indicates that his page is a choice for the first junction. This is short for "The first junction turns to this page".

Flexible CYOA handles multiple pages just fine.

	The easy choice is a page.
	"You make the easy choice."
	The cdesc is "Do the easy thing." It is for page1, page2, page3, page4...

Section: Flipping Pages

Flipped pages are pages we read through but don't "stop" on. We see the passage but then move onto a new page immediately, a very useful function for long passages.

	p1 is a page.
	"You keep going..."
	It flips to p2.
	
	p2 is a page.
	"...and going..."
	It flips to p3.
	
	p3 is a page.
	"...and going!"
	
Hybrid Choices will not bother printing choices for p1 or p2, because we've told I7 to print these pages but immediately skip past them. This comes with a risk. If Hybrid Choices detects that we've written an infinite loop, like this...

	p1 is a page.
	"You keep going..."
	It flips to p2.
	
	p2 is a page.
	"...and going..."
	It flips to p3.
	
	p3 is a page.
	"...and going..."
	It flips to p4.
	
	p4 is a page.
	"...and going..."
	It flips to P2.
	
...Then it will failsafe to the last page where choices were offered, in this case it would be the last page that turned to P1.

Section: Menus, One-Offs and Dead-Ends

Pages need not have any content. Somtimes they are useful for just presenting a series of options.

	The menu is a page.
	
Now we can refer back to this menu with our other choices.

	AskAboutPizza is a page.
	"'What about pizza?' you ask.
	
	Jenny frowns. 'No, I had some for lunch yesterday.'"
	The cdesc is "Ask about pizza." It is for the menu. It is a dead-end. It is one-off.

	AskAboutWine is a page.
	"'What about wine?' you ask.
	
	Jenny frowns. 'No, I have to drive home tonight.'"
	The cdesc is "Ask about wine." It is for the menu. It is a dead-end. It is one-off.

A page defined as a "dead-end" will return to the original page that sent it there, even through multiple flipped pages! Very useful for menus.

The second adjective you see is "one-off". This ensures that, once this choice is picked, it will never be displayed again.

Section: Page Control

Sometimes, even when a page turns to another, we might not want to offer it as a choice. Hybrid Choices offers a number of ways to control which choices are displayed based on previous choices. One way we can control this is through use of the "cancel" and "need" relations.

	P1 is a page.
	"There is a door. On the wall is a switch that says, 'FLIP TO DISABLE TRAP'."
	
	P2 is a page.
	"You flip the switch. Hmm... you feel imperceptibly safer."
	The cdesc is "Flip the switch." It is for P1. It is a dead end. It is one off.
	
	P3 is a page.
	"You travel through the door and are murdered by traps."
	The cdesc is "Saunter through the door." It is canceled by P2. It is for P1.
	
	P4 is a page.
	"You safely travel throug the door."
	The cdesc is "Saunter through the door." It is needed by P2. It is for P1.
	
When a page X "cancels" a page Y, it removes page Y from ever being considered as a choice if page X is visited. When a page X "needs" a page Y, page X will never be considered until page Y is visited. This works for multiple pages, but in a slightly different ways. All of a page's needed pages need to be visited before it becomes a viable choice. However, only one of a page's canceled pages need to be visited to cancel that page.

The second method is by "activating/deactivating" pages. A page is either "active" or "inactive". When it is "inactive", it will not be displayed as a choice. You can do this with a phrase.

	...activate PAGE...
	...deactivate PAGE...

This will toggle the page. You can even do this in groups. Say we have a game where pages are identifiable by color.

	After examining the anti-red:
		say "All that anti-red sears out your eyeballs.";
		deactivate red pages;
		activate ultra-green pages.
		
This is also useful for the page-toggle rulebook, which will be covered later.

Section: End-Page

An end-page, when read, will return the player to the normal parser interface.

	ChoicesAreDone is a page.
	"OK, you've finished doing all your choices. Go back to your typety-typety i-can-do-anything-but-disambiguate parser world and you'll find that rope has now been secured to both the tree AND the horse cart with minimal fuss."
	The cdesc is "Finish." It is an end-page.
	
The original parser will be fully active, and for all purposes it becomes a classic IF game. A location description will be printed, and the game will resume following the every turn rules.

Chapter: Advanced Topics

Hybrid Choices has four main rulebooks: choice-switch, page-switch, page-toggle and page-output.

Section:  Choice-Switch

The choice-switch rules dictate whether a page will be offered as a choice. This provides a much finer level of control than the methods of page control outlined above as you can pretty much dictate whatever you want.

	A choice-switch rule for the banana page:
		unless the player carries a banana:
			rule fails.
			
If the rule fails, the page is suppressed as a choice. If the rule succeeds, the choice is immediately displayed, even if another, later rule would have eliminated it as a choice.

	A choice-switch rule for the magic page:
		if the player spoke the magic words:
			rule succeeds.

Here, the magic page is always offered as long as the player spoke the words,  *even* if the page is inactive or canceled by an earlier page. This can be very useful.

Section: Page-Switch

It is possible at certain points to swap out the page you are currently looking at. This is the purpose of the page-switch. This rulebook switches out one page for another when called. It is useful when you have one choice that has many possibilities depending on the game state, or if you have an event that would stop the player immediately.

	The p1 is a page.
	"You are in front of the extra-dimensional door. There is but one thing to do..."
	
	The p2 is a page.
	The cdesc is "Open the door." It is for p1.

	A page-switch rule for p2:
		let X be a random number between 1 and 6;
		if X is 1:
			now the current page is InHell;
		else if X is 2:
			now the current page is InHeaven;
		else if X is 3:
			now the current page is SomewhereInMongolia;
		else if X is 4:
			now the current page is InTheVacuumOfSpace;
		else if X is 5:
			now the current page is AtYourParents;
		else if X is 6:
			now the current page is StormingNormandyBeach.

As you can see, the page-switch rule works by changing the "current page" at the very last minute. The "current page" is whatever page is being currently processed.

Section: Page-Toggle

The page-toggle is used specifically to interact with the model world. It is the bread-and-butter method to give inventory items, adjust the model world, change truth states, etc.

	A page-toggle rule for TakeTheBanana:
		now the player carries the banana.

You can also move the player by using the page-toggle rule.

	A page-toggle rule for ElevatorToThirdFloor:
		cyoa teleport to Third Floor.

CYOA teleport is used to prevent duplicated text, but is essentially identical to "now the player is in the third floor".

Section: Page-Output

Often, the description is not enough for truly complex pages. If you want something with really complicated prose, the page-output rule is where to put it.

	A page-output rule for ReallyBoringSpeech:
		say "[one of]'Read my lips, no new bad things.'[or]'I desire peace between humans and fish.'[or]'I am not a crook.'[at random]".

If there is also a description, that will also be printed after the page-output rules fire.

Section: Choice-Displaying

Normally, a cdesc is the same no matter where it is displayed. The choice-displaying activity determines what is printed when a page is displayed as a choice. This is usually the cdesc, but it can be anything else you want.

	Rule for choice-displaying the blending page:
		if the current page is red-blue:
			say "Purple.";
		else if the current page is yellow-blue:
			say "Green.";
		else if the current page is yellow-red:
			say "Orange."
			
This is useful if you want to simulate several choices that are really just one choice leading to the same page.

	Rule for choice-displaying GoToGarden:
		if the current page is InTheHall:
			say "Exit the house.";
		else if the current page is InTheDriveway:
			say "Take the path to the garden."

If you want multiple choice on the same page to lead to the same page, it's best to make those pages flip to the desired destination.

Section: Choice-Priority

As of Version 3, you can now influence choice order by setting choice-priorities. This is useful if you want options to leave menus on the very bottom rather than somewhere awkward like in the very middle.

When a choice is elected for selection, it is given a numerical value (by default '50') through the choice-priority rules. The lower the number, the higher it is displayed as a choice.

Let's say you always want violence to be the last option. We can pretty easily do that now.

	pkillthem is a page.
	The cdesc is "Kill them!"
	The description is "Violence is always the last option."
	
	Choice-priority for pkillthem:
		rule succeeds with result 200.
		
You can do the opposite as well, always putting a choice on top.

	phugthem is a page.
	The cdesc is "Hug them!"
	The description is "Shnuggles are always appropriate."
	
	Choice-priority for phugthem:
		rule succeeds with result 1.

Chapter: Interaction Between CYOA and Model World

Hybrid Choices opens the possibility to use the model world in your CYOA projects, and vice-versa. Here's how stuff interacts.

Section: In CYOA Mode...

Since Hybrid Choice is not always in CYOA mode, it is often helpful to know which mode we are currently in.

	...if in CYOA mode...
	
This returns true if we are in CYOA mode. Similarly,

	...if not in CYOA mode...

...returns true if we are playing interactively.

Section: Time

While Hybrid Choices does allow time to pass (hence making UNDO possible), it suppresses the every turn rulebook. This is generally because these rules are not appropriate in CYOA mode. If you don't like this behavior, you can disable it by unlisting the rule.

*:
	The prevent every turn events rule is not listed in the every turn rulebook.

Section: Moving the Player

You'll often find yourself moving the player around the model world during choice mode. This presents a minor problem, as the passage will print twice. In this case, Hybrid Choices uses a particular function to move the player.

	...cyoa teleport to A LOCATION...
	
This moves the player without "looking", thus solving the issue.

	A page toggle rule for GoingToSchool:
		cyoa teleport to school.

Section: CYOA Parser

Hybrid Choices allows for a pretty flexible parser. By default, it allows players to make a choice, use the various testing functions (not in final release, of course), basic commands like looking and taking inventory, and the system commands like save, quit, restore, etc. However, you might want to implement new commands in CYOA mode, for example, examining.

*:
	After reading a command when in cyoa mode (this is the accept examining in CYOA rule):
		if the player's command includes "x/examine", now the command accepted is true.

This will allow examining to happen in CYOA mode.

*:
	After reading a command when in cyoa mode (this is the accept examining in CYOA rule):
		if the player's command includes "xyzzy", now the command accepted is true.

This will allow the player to type in "XYZZY", so you can code some sort of action in response to it.

Unless you set the "command accepted" to true in your own parser rules, they will automatically be rejected in CYOA mode. By default, the error message that's printed is "That command isn't available in choice mode." but you can change it to whatever you want.

	The CYOA error message is "You did wrong, bub."

The reason a text variable is used rather than a response message is simple, sometimes inconsistent error messages can give a clue, say, when the player has to type a password in a certain room.

	> ABCCB
	
	That command isn't available in choice mode.
	
	> XYZZY
	
	That command isn't available in CYOA mode.

Use of a text variable ensures consistency in error messages, and avoids giving unintentional clues.

	Instead of xyzzying:
		if the player is not in the colossal cave:
			say "[cyoa error message][paragraph break]";
		else:
			say "Yeah the cute IF reference works."

Section: Turn To

If, by special circumstances, you want to go to a certain page through the use of an action while in choice mode, you'll want to use the "turn to A PAGE" phrase. This phrase causes Hybrid Choices to immediately turn to that page, but still respecting things like page flipping and such.

	Instead of xyzzying:
		if the player is not in the colossal cave:
			say "[cyoa error message][paragraph break]";
		else:
			turn to the victory page.
			
You do not want to use this outside of choice mode, IT WILL NOT WORK. If you want to go into choice mode from interactive mode, use the "switch to cyoa at A PAGE" instead.

Section: Items

Like Adventure Book, Hybrid Choices makes use of items. Unlike Adventure Book, however, inventory items are not special sorts of flags, they're actual things in the player's inventory and things around them. A key picked up in interactive mode can be used to open a door in choice mode, and vice versa.

	unlockdoor is a page.
	"You unlock the door with the bronze key."
	The cdesc is "Unlock the door." The required item is the bronze key.

The "required item" of any give page is the thing that's needed in the player's inventory to reveal it. A page can only have one required item at a time.

Similarly, the "canceling item" is an object that suppresses a page if the player is lugging it around.

	hitdoor is a page.
	"Without a key, you hit the door with futility."
	The cdesc is "Hit door." The canceling item is the bronze key.
	
Another way you can use items is through the "item-invoking" action. This action allows the player to type the name of a thing in interactive mode, for example, a key, and have that prompt a certain action. By default, item-invoking is disabled. You'll need to activate it by switching the "item-invoking disabled" truth state to false.

*:
	When play begins:
		now item-invoking disabled is false.

Now you'll need to supply the behaviors when you do item-invoking. By default, it just says "The thing can't be used here.", which isn't very exciting. There are a couple of applications for it, you can use it for inventory management, or you can use it as a way to interact with objects outside of the player's inventory.

This is a very quick example of a system which opens a menu whenever you item-invoke something.

*:
	A thing has an object called the item menu. The item menu is usually nothing.

	Check item-invoking something:
		if the item menu of the noun is not a page:
			say "[The noun] [are] not very interesting." instead.

	Carry out item-invoking something:
		turn to item menu of the noun.

	The block item-invoking rule is not listed in the report item-invoking rulebook.

Section: Note on Flexible Windows

If you include Flexible Windows by Jon Ingold, a little choice window is displayed at the bottom of the page. Hybrid Choices will not compile with Flexible Windows version 14 and below.

In any case, Hybrid Choices provides you some tools to add a choice window. If you don't use Flexible Windows butsome other interface extension you'll need to provide your own code for each of these three phrases.

	SET CHOICE-WINDOW- This opens the choice-window.
	UNSET CHOICE-WINDOW- This closes the choice-window.
	REFRESH CHOICES- This prints the choices to the choice-window.

Section: Debug mode

Finally, while testing, cyoa debug mode can be toggled on and off by typing "cyoa debug". This will print all the pages you passed.

Chapter: Advanced Topic - Object Choices

As of Version 4, there is no restriction on what object can be a choice. This makes Hybrid Choices very powerful in how it can manipulate the model world, and lifts a lot of prior limitations. In Hybrid Choices parlance, an "object choice" is a choice which is not a page.

You might be wonder -- what's the point of this? Why would I want objects to be pages? Well, assume you want to an action that brings up all interactive objects in one room as choices. For example, a "list visible objects" command that will let players open a menu of all visible objects that can be examined. Previously, you would need to make a page for each single object, then write page-toggle rules for each of them, and choice-switch rules in case they aren't visible. Object Choices automates what would otherwise be a laborious process.

This is all very powerful but comes with the caveat that Hybrid Choices doesn't assume how you want to manipulate object-choices, so some work is necessary to get the full benefit out of them. Once you do, you can use Hybrid Choices to construct action menus, fast travel, node-based conversation systems, or anything, really. "Colored Rooms" and "The Lineup" both present examples of how you could implement object choices.

Section: Presenting Objects as Choices

Object have to be manually inserted as choices using the POPULATE CHOICE LIST WITH phrase.

	populate choice list with visible people who are not the player.
	populate choice list with round balls.
	populate choice list with grandma.
	
These place these objects as a choices in the next menu, along with any other pages they might refer to. It's recommended you perform this function with the page-toggle rules.

	A page-toggle rule for #killallmartians:
		populate choice list with living martians.

These options are only valid once, so you need to repopulate them again if you want to use them again.

Objects, like pages, can be manipulated using the choice-priority and choice-display.

	Choice-priority for a Martian:
		rule succeeds with result 1.

	Choice-display a Martian (called the poolord):
		say "Kill [poolord]."

Section: Handling Objects

By default, if an object is chosen, nothing happens. You are simply booted out of cyoa mode. You need to teach Hybrid Choices how to handle object choices.

This is mostly done through the General Choose Object rules.

	General choose object rule for a martian (called N):
		say "You brutally murder the unarmed Martian. Now you feel both safe AND empowered.";
		now N is dead.

This implementation is good enough if your applications are limited. However, Hybrid Choices provides us a method of changing the rulebook to check objects. This rulebook is called the object-choice-handler. Changing the object-choice-handler changes which rulebook is consulted. The one restriction is that these must be object-based rulebooks.

	The murder rules are an object based rulebook.
	
	A page-toggle rule for #killallmartians:
		now the object-choice-handler are the murder rules;
		populate choice list with living martians.
	
	Murder a martian (called N):
		say "You brutally murder the unarmed Martian. Now you feel both safe AND empowered.";
		now N is dead.

One problem. After we've picked an object we are booted to interactive mode, and we might not want that. All we need do is designate a page to go to. We manually change the current page.

	Murder a martian (called N):
		say "You brutally murder the unarmed Martian. Now you feel both safe AND empowered.";
		now N is dead;
		now the current page is asafespace.
	
	asafespace is a page.
	"Finally. A safe space.".


Chapter: Advanced Topic - Memory Economy

Hybrid Choices uses more properties and relations than strictly necessary. Much of this is merely convenience, and larger projects might benefit if they comment out certain parts of the extension. It is recommended if you are running into memory issues to copy-paste the extension in to their source code without the folllowing sections-- "section d - page-dependent". This includes two various-to-various relations and is a major memory hog.

Chapter: Reference

Section: Action Reference

	choosing -- The action that is invoked when the player enters a choice.
	item-invoking -- The action that is invoked when the player types the name of an object in choice mode.
	toggling cyoa debug mode -- An action out of world which toggles CYOA debug mode on and off.

Section: Rulebook Reference

	choice-displaying activity -- An activity on objects which prints a particular choice.
	choice-priority rules -- An object based rulebook producing a number, the lower, the higher the choice is displayed.
	choice-switch rules -- A page based rulebook which determines whether a choice will be displayed.
	displaying available decisions activity -- Prints a list of available decisions
	general choose object rules -- An object based rulebook that tells Hybrid Choices how to handle objects if chosen instead of pages.
	page-output rules -- A page based rulebook that prints complex text when the page is displayed
	page-switch rules -- A page based rulebook which switches the current page if necessary.
	page-toggle rules -- A page based rulebook which manipulates the model the world.
	selecting activity -- goes through the internal machinery when a choice is made. This should probably not be messed with unless with great care.

Section: Variables Reference

	assigned index -- a number that's used internally. We recommend not fiddling with this.
	current page -- the page that's currently being processed.
	CYOA debug boolean -- a truth state that records whether in debug mode.
	CYOA error message -- a text that contains the error message that's printed when the parser fails.0
	CYOA mode -- a truth state that records whether the game is in CYOA mode.
	item-invoking disabled -- when true, disallows the item-invoking action.
	object-choice-handler -- an objects based rulebook variable, holding by default the general choose object rules, which decides which rulebook is consulted when an object is chosen.
	previous page -- the last page that offered the player a choice.

Section: Page Properties Reference

	(If you are having memory problems, going into the extension and commenting out properties you don't need is a good way to improve performance. There are more than are strictly necessary, but I wanted to be complete.)
	active, inactive -- assignable adjective, determines whether a page will be or not be displayed.
	canceling item -- object property, the page is never displayed while this is detected in inventory.
	cdesc -- text property, the text that's displayed while this is detected in inventory.
	cyoa teleport -- object property, when used, teleports the player into the specified object.
	destination page -- not assignable, the page which this goes to when it flips to another page.
	displayed boolean -- truth state property, set as "true" if the page has ever been displayed.
	end-page -- assignable adjective, ends CYOA mode.
	one-off -- assignable adjective, marks a page which is never displayed again once chosen.
	no-look (deprecated) -- assignable adjective, suppressed double prints when they occurred. Use CYOA teleport instead.
	required item -- object property, the page is only displayed as a choice if this is detected in the inventory.
	
Section: Phrase Reference

	ACTIVATE (A PAGE) -- switches the page to active.
	ACTIVATE (DESCRIPTION OF PAGES) -- switches the description of pages to active.
	ACTIVATE (LIST OF PAGES) -- switches a list of pages to active.
	CLEAR CHOICES -- clears all choices, in preperation for a new set. Best not used.
	CYOA TELEPORT TO (OBJECT) -- moves the player to the object without printing a room description.
	DEACTIVATE (A PAGE) -- switches the page to inactive.
	DEACTIVATE (DESCRIPTION OF PAGES) -- switches the description of pages to inactive.
	DEACTIVATE (LIST OF PAGES) -- switches a list of pages to inactive.
	EXECUTE PAGE TURNING -- this phrase move to a new current page, with respect to page-flipping, dead-ends, and various rules. Best not used.
	if IN CYOA DEBUG MODE -- returns true if in CYOA debug mode.
	if IN CYOA MODE -- returns true if in CYOA mode.
	if NOT IN CYOA MODE -- returns false if in CYOA mode.
	POPULATE CHOICE LIST WITH (object) -- manually inserts an object into a choice list.
	POPULATE CHOICE LIST WITH (description of objects) -- manually inserts all objects matching a description into a choice list.
	POPULATE CHOICE LISTS FOR (page) -- inserts all pages into the choice list that turn from the page.
	if READING (A PAGE) -- a more readable way of ask if the current page is that page.
	REFRESH CHOICES -- reprints all the choices in the choice-window.
	SET CHOICE-WINDOW -- opens the choice window, if using Flexible Windows.
	SWITCH FROM CYOA -- switches to interactive mode from choice mode.
	SWITCH TO CYOA AT (A PAGE) -- switches from interactive mode to cyoa mode at the specified page.
	TURN TO (A PAGE) -- makes this page the new current page and executes the page turning routine.
	UNSET CHOICE-WINDOW -- closes the choice window, if using Flexible Windows.


	Chapter - Set Up

	The current stamina is a number that varies. The current stamina is 20.
	The initial stamina is a number that varies. The initial stamina is 20.

	The skill is a number that varies. The skill is 10.

	The luck is a number that varies. The luck is 10.


	After looking for the first time:
		now the left hand status line is "Stamina: [current stamina]/[initial stamina] Skill: [skill] Luck: [luck]";
		now the right hand status line is "";
		switch to cyoa at p1.

	The sword is a thing. It is carried by the player.
	A meal is a kind of thing. The player is carrying 4 meals.

	The bronze key is a thing.

	Chapter - Temple of Fear

	The game world is a room.

	P1 is a page.
	"You have just slain the Troll of Bigness, and are ready to make your way into the Temple of Fear. It's just over the bridge to the north."

	P2 is a page.
	"[first time]You cross the bridge and find yourself in a huge forest. [only]The door to the Temple of Fear is north. There is a path through the forest to your left."
	The cdesc is "Cross the bridge." It is for p1.

	A page-toggle rule for p2:
		now the cdesc of p2 is "Head back to the Temple of Fear."

	p3 is a page.
	It is flipped to by p2.

	p4 is for p3.
	"You check the door, but it appears to have a lock or something. Damn."
	The cdesc is "Check the door.". It is a dead-end.

	A page-switch rule for p4:
		if the player is carrying the bronze key:
			now the current page is p12.

	p5 is for p3. It is one-off.
	"You travel through the forest and eventually encounter a troll."
	The cdesc is "Go to the forest.".

	A choice-switch rule for p5:
		if the player carries the bronze key:
			rule fails.

	p6 is for p5.
	"You slay the troll and lose 4 stamina in the process as it clubs you."
	The cdesc is "Kill the troll by stabbing it.".

	A page-toggle rule for p6:
		now the current stamina is current stamina - 4.

	p7 is for p5.
	"You outwit the troll and it dies from outwitting. You lose 1 luck because yes.".
	The cdesc is "Outwit the troll.".

	A page-toggle rule for p7:
		now the luck is luck - 1.

	p8 is for p5.
	"You flash some serious skills and the troll's head explodes, killing it. You lose 1 skill because you are so tired now.".
	The cdesc is "Intimidate it with mad skillz.".

	A page-toggle rule for p8:
		now the skill is skill - 1.

	p9 is a page.
	"OK, you've murdered the troll and now enter a clearing. There's a key here."
	It is flipped to by p6, p7, p8.

	p10 is for p9.
	"You take the key. Now you can enter the Temple of Fear."
	The cdesc is "Take key." It turns to p2.

	A page-toggle rule for p10:
		now the player carries the bronze key.

	p11 is for p9.
	"There's a totally unrelated trap you stumble onto and die."
	The cdesc is "Fall for trap.".

	A page-toggle rule for p11:
		end the story.
		
	p12 is a page.
	"You unlock the door and are greeted by a terrible temple full of mysteries, traps, and devious challenges."

	A page-toggle rule for p12:
		end the story saying "DLC required: Temple of Fear. Now only $10!"
		

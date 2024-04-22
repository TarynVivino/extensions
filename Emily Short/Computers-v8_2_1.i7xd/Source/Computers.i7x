Version 8.2.1 of Computers by Emily Short begins here.

"Computer hardware and software, including search engines and email programs. Version 3 adds handling for batteries and cords, if we include Power Sources by Emily Short (which itself depends on Plugs and Sockets by Sean Turner)."

[Version 8 updates for compatibility with the 6M62 port of Counterfeit Monkey. Changed out of bounds to out-of-bounds and password lock program to password-lock program. Removed deprecated features - Petter Sjölund]

[Version 7 updates for compatibility with adaptive responses.]

[Include Plurality by Emily Short.]

To chime is a verb. To seem is a verb. To display is a verb. To turn is a verb. To invite is a verb. To vanish is a verb. To beep is a verb. To reply is a verb. To appear is a verb.

Book 1 - Hardware

Chapter 1 - Computers in General

Section 1 - Devices

[All computers have screens and keyboards.]


A computer is a kind of device. Understand "computer" as a computer.
	A computer has some text called the startup noise. The startup noise of a computer is usually "[The item described] [chime] cheerfully."

A screen is a kind of thing. One screen is part of every computer. The description of a screen is usually "[The item described] [are] currently blank.". Understand "monitor" as a screen. [Screen information is overridden later.]

A keyboard is a kind of thing. One keyboard is part of every computer. The description of a keyboard is usually "The typical arrangement of keys."
	The specification of a keyboard is "Part of every computer by default. The player can only use the TYPE (something) ON action when a keyboard is part of the computer in question."

A selection device is a kind of thing. 
	The specification of a selection device is "A generic kind from on both trackpads and mice will depend. The player may only use the CLICK ON action when a selection device is part of the computer in question."

An extension port is a kind of container.
	The specification of an extension port is "A generic kind suitable for implementing DVD or CD drive slots, USB ports, and any other realistic or futuristic reader for a data storage device."
	The carrying capacity of an extension port is 1.

A data storage device is a kind of thing.
	The specification of an extension port is "A generic kind suitable for implementing DVD or CDs, flash drives, etc."

Setting action variables for an actor inserting a data storage device into a computer when the second noun incorporates exactly one extension port (called target port) (this is the guess a sensible port rule):
	now the second noun is the target port.
	
Instead of an actor inserting something which is not a data storage device into an extension port (this is the restrict extension port usage rule):
	if the actor is not the player:
		rule fails;
	say "[The noun] [are] not a suitable device for reading with [the second noun]."

Section 2 - Startup Behavior

Understand "boot [a computer]" as switching on. Understand "boot [something]" as switching on.

Understand "reboot [a computer]" as rebooting. Understand "reboot [something]" as rebooting. Understand "restart [a computer]" as rebooting. Understand "restart [something]" as rebooting.

Rebooting is an action applying to one thing.

Check rebooting something which is not a computer (this is the can only reboot computers rule):
	say "[The noun] [are] not rebootable." (A) instead.

Carry out rebooting something (this is the standard rebooting rule):
	try switching off the noun;
	if the noun is switched off:
		try switching on the noun.

Report switching on a computer (this is the computers make a noise on starting rule):
	say "[The startup noise of the noun][paragraph break]" (A);
	let target screen be a random screen that is part of the noun;
	try examining the target screen instead.

After examining a switched on computer (this is the report software when examining a functioning computer rule):
	let target screen be a random screen that is part of the noun;
	try examining the target screen.

Section 3 - Screen Appearance
 

Instead of examining a screen which is part of a switched on computer (called the chosen computer) (this is the view software when looking at a screen rule):
	if the chosen computer is a closed laptop:
		say "[The noun] [are] closed." (A) instead;
	if the controlling program of the chosen computer is not software:
		say "[The noun] [are] displaying a generic system error." (B) instead;
	try examining the controlling program of the chosen computer.

Carry out switching off a computer (this is the screen fades after shutdown rule):
	let chosen screen be a random screen which is part of the noun;
	repeat with item running through things which are part of the chosen screen:
		now the item is nowhere.   

Chapter 2 - Laptops

A laptop is a kind of computer. A laptop can be open or closed. A laptop can be openable. A laptop is usually closed and openable. Understand "computer" or "computers" as a laptop.

A trackpad is a kind of selection device. A trackpad is part of every laptop.

Instead of touching a trackpad (this is the correct insufficient trackpad information rule):
	say "Try CLICK ON (some option) WITH [the noun], or just CLICK ON (option), to make a selection." (A)

Definition: a thing is a concealed component:
	if it is a keyboard and it is part of a closed laptop:
		yes;
	if it is a screen and it is part of closed laptop:
		yes;
	if it is a trackpad and it is part of closed laptop:
		yes;
	no.

Instead of doing something when the noun is a concealed component (this is the inability to act on parts of a closed laptop rule):
	let N be the holder of the noun;
	say "[The N] [are] closed at the moment." (A)

Instead of doing something when the second noun is a concealed component (this is the inability to act on secondary parts of a closed laptop rule):
	let N be the holder of the second noun;
	say "[The N] [are] closed at the moment." (A)

Before switching on a closed laptop (this is the laptops run open rule):
	say "(opening and starting up [the noun])[command clarification break]" (A);
	silently try opening the noun;
	if the noun is closed:
		stop the action.

Before switching off an open laptop (this is the laptops store closed rule):
	say "(closing and shutting down [the noun])[command clarification break]" (A);
	silently try closing the noun;
	if the noun is open:
		stop the action.

[And because we want to keep the closing and opening in sync with one another:]

Understand "close [laptop]" as switching off.
Understand "open [laptop]" as switching on.

Chapter 3 - Desktop Computers

A desktop computer is a kind of computer. 
	A desktop computer is usually fixed in place.
	The description of a desktop computer is usually "[regarding the noun][They] [have] a dull beige exterior and [seem] to be trying to avoid attracting attention."

A mouse is a kind of selection device. A mouse is part of every desktop computer. The description of a mouse is usually "Just the ordinary wired variety."

Chapter 4 - Power Supplies (for use with Power Sources by Emily Short)

[We include plugs to go with computers, and both plugs and batteries for laptops -- which also have a failure message arranged.]

A power cord is a kind of PS-plug. 

A power cord is part of every desktop computer. 

A power cord is part of every laptop. A laptop battery compartment is a kind of battery compartment. A laptop battery compartment is part of every laptop. Every laptop battery compartment contains a rechargeable battery.

Setting action variables for an actor unplugging a power cord which is part of something (called the parent computer) (this is the divert unplugging power cords to their parent computers rule):
	now the noun is the parent computer.

Rule for warning about the failure of a laptop (called the machine) (this is the default describe laptop battery failure rule):
	if a random battery compartment which is part of the machine contains a battery (called the power source):
		if the charge of the power source is 2:
			say "[The machine] briefly [display] the low-battery indicator."

The divert opening actions to the battery compartment rule is not listed in any rulebook.
The divert closing actions to the battery compartment rule is not listed in any rulebook.

Setting action variables for an actor opening a device  (this is the new divert opening actions to the battery compartment rule):
	if the noun is not a laptop:
		now the noun is a random battery compartment which is part of the noun. 

Setting action variables for an actor closing a device  (this is the new divert closing actions to the battery compartment rule):
	if the noun is not a laptop:
		now the noun is a random battery compartment which is part of the noun.


Book 2 - Software

Chapter 1 - Defining Software

Some software is a kind of thing. Understand "software" or "desktop" as software. Some software is part of every computer.

Running relates one computer to various softwares. The verb to run (it runs, they run, it ran, it is run, it is running) implies the running relation.

Software has a number called software priority. The software priority of software is usually 5.

Definition: software is fierce if its software priority is 2 or less. 

Chapter 2 - Software Types

Section 1 - Search Engines 

A search engine is a kind of software. Understand "search box" or "search" or "search engine" as a search engine.
	The description of a search engine is usually "A search box awaits your search terms."
	A search engine has some text called the no-records response. The no-records response of a search engine is usually "No records found.".
	A search engine has some text called the results-found response. The results-found response of a search engine is usually "[Our] search [turn] up the following results:".
	A search engine has a table-name called the data table.

Understand "look up [text] on/in [something]" as consulting it about (with nouns reversed).

Understand "search for [text]" as text-searching when the player can see a switched on computer which is running a search engine. Text-searching is an action applying to one topic.

Carry out text-searching the topic understood (this is the divert searching to input reply rule):
	if the player can see a switched on computer which is running a search engine (called the software chosen):
		abide by the input handling rules for the software chosen.  

Check someone text-searching (this is the block others searching for text rule):
	stop the action.

Setting action variables for consulting something which is part of a computer (called target) about the topic understood (this is the consult no peripherals rule):
	if the controlling program of the target is software:
		now the noun is the controlling program of the target. [Converts LOOK UP BALLOON ON KEYBOARD to LOOK UP BALLOON ON GOOGLE]

Setting action variables for consulting a computer about the topic understood (this is the consult only software rule):
	if the controlling program of the noun is software:
		now the noun is the controlling program of the noun. [Converts LOOK UP BALLOON ON COMPUTER to LOOK UP BALLOON ON GOOGLE]
		
Slow searching is a truth state that varies. Slow searching is false.

Report consulting a search engine about the topic understood when slow searching is true (this is the slow list search hits rule):
	let result count be 0;
	repeat through data table of the noun:
		let N be "[topic understood]";
		if data entry matches the text N:
			let result count be result count + 1;
			if result count is 1:
				say "[results-found response of the noun][paragraph break]" (A);
			say "[bold type][title entry][roman type]: [data entry][paragraph break]" (B);
	if the result count is 0:
		say "[no-records response of the noun][paragraph break]" (C);
	rule succeeds.

Report consulting a search engine about the topic understood when slow searching is false (this is the list search hits rule):
	let result count be 0;
	repeat through data table of the noun:
		if topic understood matches the topic entry:
			let result count be result count + 1;
			if result count is 1:
				say "[results-found response of the noun][paragraph break]" (A);
			say "[bold type][title entry][roman type]: [data entry][paragraph break]" (B);
	if the result count is 0:
		say "[no-records response of the noun][paragraph break]" (C);
	rule succeeds.

Table of Sample Data
topic	title	data
"food/cake/yellow" or "yellow cake"	"OnlineRecipes.org"	"A delicious recipe for yellow cake."	

Section 2 - Password Locks

A password-lock program is a kind of software. The software priority of a password-lock program is usually 1.
	The description of a password-lock program is usually "[regarding the noun]A box on the screen [invite] [us] to type a password to proceed.".
	A password-lock program has some indexed text called the password.
	A password-lock program has some text called the rejection. The rejection of a password-lock program is usually "'Password incorrect.'"
	A password-lock program has some text called the success. The success of a password-lock program is usually "[regarding the noun]The password field [vanish]."

Rewarding successful answering of something is an activity.

Rule for rewarding successful answering of a password-lock program (called chosen software) (this is the default password resolution rule):
	say "[success of the chosen software][paragraph break]" (A); 
	let chosen computer be a random computer which is running the chosen software;
	let the target screen be a random screen which is part of the chosen computer;
	now the chosen software is not run by the chosen computer;
	try examining the target screen.
	
Definition: a computer is protected if it runs a password-lock program.
Definition: a computer is unprotected if it is not protected.

Section 3 - Multiple Choice Programs

[A multiple-choice program allows the user to pick among several options: as with the search engine, the topic 

An options table for a multiple-choice program should have the form

Table of GUI Options
topic	title	effect
"microsoft/word" or "microsoft word"	"Microsoft Word"	open-Word rule
"adobe illustrator" or "adobe/illustrator"	"Adobe Illustrator"	open-Illustrator rule

where the index will be filled in with numbers as appropriate, the title will label each numbered action, and the effect will be executed when the number is selected.]

A multiple-choice program is a kind of software. 
	A multiple-choice program has a table-name called the options table.
	A multiple-choice program has some text called the out-of-bounds response. The out-of-bounds response is usually "[Our] selection, '[topic understood]', is not one of the available choices."

The description of a multiple-choice program is usually "[options-list of the item described]".

The large set is a plural-named thing.

To say options-list of (chosen program - a multiple-choice program):
	let the option count be the number of filled rows in the options table of the chosen program;
	let the referent be the chosen program;
	if the option count is greater than 1:
		let the referent be the large set;
	say "[regarding the referent]The following option[s] [are] visible on the screen:[paragraph break]";
	repeat through the options table of the chosen program:
		say "[title entry][line break]";
	say "[run paragraph on]".

Section 4 - Enumerated Multiple Choice Programs

[A simplified subset of the above, where options are automatically numbered for the player, who can select by number rather than by 

An options table for an enumerated multiple-choice program should have the form

Table of Deeds
index	title	effect
--	"RESTORE ANIMAL-CREATION LIMITS"	bin-messing-up rule
--	"REMOVE ANIMAL-CREATION LIMITS"	bin-opening rule
--	"QUIT"	bin-closing rule

where the index will be filled in with numbers as appropriate, the title will label each numbered action, and the effect will be executed when the number is selected.]

An enumerated multiple-choice program is a kind of multiple-choice program.
	The specification of an enumerated multiple-choice program is "Uses the options table and automatically numbers options rather than letting the player choose keywords to select."
	The out-of-bounds response is usually "[The item described] [beep]: [our] selection [regarding the noun][are] not one of the available choices. Try, for instance, SELECT 1."

To say options-list of (chosen program - an enumerated multiple-choice program):
	let the option count be the number of filled rows in the options table of the chosen program;
	let the referent be the chosen program;
	if the option count is greater than 1:
		let the referent be the large set;
	say "[regarding the referent]The following option[s] [are] visible on the screen:[paragraph break]";
	let N be 1;
	repeat through the options table of the chosen program:
		now the index entry is N;
		increase N by 1;
		say "[index entry]: [title entry][line break]";
	say "[run paragraph on]". 

Table of Sample Deeds
index	title	effect 
a number	some text	a rule

Section 5 - Email Programs

An email program is a kind of software.
	An email program has a table-name called the message table.
	An email program has some text called the new mail message. The new mail message of an email program is usually "[We] [have] new mail on [the random computer which is running the item described].".
	The description of an email program is usually "[inbox of the item described]".

To say inbox of (chosen email - an email program):
	if the number of filled rows in the message table of the chosen email is 0:
		say "[Our] email program [regarding the chosen email][are] on screen, but [regarding the large set]no messages [are] available.";
	otherwise:
		say "[regarding the large set]The following messages [are] available for [us] to read or reply to:[line break]";
		repeat through the message table of the chosen email:
			if there is an arrival time entry:
				say "[line break]";
				if the read entry is false:
					say "[bold type]";
				say "[arrival time entry]: ";
				say "[message entry]";
				if answered entry is true:
					say "(R)";
				say "[roman type]"; 

Table of Messages
topic	message	arrival time	read	answered	description
"SPAM"	"SPAM"	9:00 AM	false	false	"Money for you from Nigeria!"

To deliver (chosen message - text) to (chosen program - an email program):
	repeat through the message table of the chosen program:
		if message entry is chosen message: 
			now the arrival time entry is the time of day; 
			if the player can see the chosen program:
				say "[new mail message of the chosen program][paragraph break]";

Understand "read [text]" as email-reading when the player can see a switched on unprotected computer which is running an email program. Email-reading is an action applying to one topic.

Carry out email-reading the topic understood (this is the divert email reading to input reply rule):
	if the player can see a switched on unprotected computer which is running an email program (called the chosen software): 
		abide by the input handling rules for the chosen software.  

Check someone email-reading (this is the block others reading email rule):
	stop the action.

Understand "reply to [text]" or "answer [text]" as email-replying when the player can see a computer which is running an email program. Email-replying is an action applying to one topic.

Check email-replying (this is the block replying to email rule):
	say "[We] [can't] think of any good response." (A) instead.

Check someone email-replying (this is the block others replying to email rule):
	stop the action.

Check email-replying (this is the refuse to reply to nonexistent messages rule):
	repeat with chosen software running through visible email programs:
		if the topic understood is a topic listed in the message table of the chosen software:
			if there is an arrival time entry: 
				make no decision;
	say "[regarding the noun]No such message [are] available." (B) instead.

Carry out email-replying (this is the mark messages replied rule):
	repeat with chosen software running through visible email programs:
		if the topic understood is a topic listed in the message table of the chosen software:
			if there is an arrival time entry: 
				now the answered entry is true;
				rule succeeds.

Report email-replying (this is the standard report replying to email rule):
	say "[We] [reply]."

Chapter 3 - Which Program Receives Input?

To decide what object is the controlling program of (chosen computer - a computer):
	let the chosen screen be a random screen that is part of the chosen computer;
	repeat with item running through software which is part of chosen screen:
		now item is nowhere; 
	if the chosen computer runs no software:
		decide on nothing;
	otherwise:
		let the chosen program be the fiercest software run by the chosen computer;
		now the chosen program is part of the chosen screen;
		decide on the chosen program. 
		

Chapter 4 - Input Methods

Section 1 - The Typing Action

Understand "type [text] into/on/in [a keyboard]" as typing it on. Understand "type [text] on/into/in [something]" as typing it on. Typing it on is an action applying to one topic and one thing.


Understand "input [text] into/on/in [a keyboard]" as typing it on. Understand "input [text] on/into/in [something]" as typing it on.  

The typing it on action has an object called the computer in question.
The typing it on action has an object called the software in question (matched as "controlling").

Understand "enter [text] into/on/in [a keyboard]" as typing it on. Understand "enter [text] into/on/in [something]" as typing it on. Understand "enter [text]" or "push [text]" as typing it on.

Understand "type [text]" as typing it on.

Understand the command "key" as "type".




Rule for supplying a missing second noun while typing the topic understood on (this is the guess a keyboard while typing rule):
	if the player can touch a keyboard (called target):
		now the second noun is the target;
	otherwise:
		say "You'll have to specify what you want to type on." (A) instead.


Setting action variables for an actor typing the topic understood on something which is not a keyboard (this is the adjust to correct keyboard rule):
	if the second noun is a computer:
		let the relevant keyboard be a random keyboard which is part of the second noun;
		now the second noun is the relevant keyboard;
	otherwise if the second noun is something which is part of a computer (called the relevant computer):
		let the relevant keyboard be a random keyboard which is part of the relevant computer;
		now the second noun is the relevant keyboard;

Setting action variables for an actor typing the topic understood on something (this is the find correct software rule):
	if the second noun is keyboard:
		now the computer in question is a random computer which incorporates the second noun;
		now the software in question is the controlling program of the computer in question. [This kicks the logic back up to chapter 3.]

Check an actor typing  the topic understood on something which is not a keyboard (this is the reject typing on non-keyboards rule):
	if the actor is the player:
		say "[The second noun] [are] not a keyboard." (A) instead;
	rule fails.

Check an actor typing  the topic understood on a keyboard which is part of a switched off computer (called the relevant computer) (this is the reject typing on switched off computers rule):
	if the actor is the player:
		say "[The relevant computer] [are] currently switched off." (A);
	rule fails. 

Check an actor typing the topic understood on a keyboard controlling nothing (this is the claim a system error in the absence of software rule):
	if the actor is the player:
		say "[The computer in question] [appear] to be suffering a system error and [have] no working software available to interpret your command." (A);
	rule fails.

Carry out an actor typing the topic understood on a keyboard which is part of a computer (this is the default typing rule):
	abide by the input handling rules for the software in question.


Understand "type on [keyboard]" as contentlessly typing. Understand "type on [something]" as contentlessly typing. Understand "type" as contentlessly typing.

Contentlessly typing is an action applying to one thing.

Rule for supplying a missing noun while contentlessly typing (this is the guess a keyboard while contentlessly typing rule):
	if the player can touch a keyboard (called target):
		now the noun is the target;
	otherwise:
		say "You'll have to specify what you want to type." (A) instead.

Check contentlessly typing (this is the check whether typing nothing rule):
	say "You'll have to specify what you want to type."  (A)instead.


Section 2 - Selection with a Selection Device	

Understand "click on [text] with [a selection device]" or "select [text] with [a selection device]" or "pick [text] with [a selection device]" or "click [text] with [a selection device]" or "choose [text] with [a selection device]" or "push [text] with [a selection device]" as selecting it with. 

Understand "click on [text] with [something]" or "select [text] with [something]" or "pick [text] with [something]" or "click [text] with [something]" or "choose [text] with [something]" or "push [text] with [something]"  as selecting it with.  Selecting it with is an action applying to a topic and one thing.

Understand "click [text]" or "select [text]" or "click on [text]" or "pick [text]" or "choose [text]" or "push [text]"  as selecting it with. 

Rule for supplying a missing second noun while selecting the topic understood with (this is the guess a selection device while selecting rule):
	if the player can touch a selection device (called target):
		now the second noun is the target;
	otherwise:
		say "You'll have to specify what you want to click with." (A) instead.

The selecting it with action has an object called the selected computer in question.
The selecting it with action has an object called the selected software in question (matched as "controlling").

Setting action variables for an actor selecting the topic understood with something which is not a selection device (this is the adjust to correct selection device rule):
	if the second noun is a computer:
		let the relevant selection device be a random selection device which is part of the second noun;
		now the second noun is the relevant selection device;
	otherwise if the second noun is something which is part of a computer (called the relevant computer):
		let the relevant selection device be a random selection device which is part of the relevant computer;
		now the second noun is the relevant selection device;

Setting action variables for an actor selecting the topic understood with something (this is the find correct selection device software rule):
	if the second noun is a selection device:
		now the selected computer in question is a random computer which incorporates the second noun;
		now the selected software in question is the controlling program of the selected computer in question. [This kicks the logic back up to chapter 3.]

Check an actor selecting the topic understood with something when the second noun is not a selection device (this is the click only with mice rule):
	if the actor is the player:
		say "[The second noun] [are] not a selection tool." (A) instead;
	rule fails.

Check an actor selecting the topic understood with a selection device which is part of a switched off computer (called the relevant computer) (this is the reject mousing on switched off computers rule):
	if the actor is the player:
		say "[The relevant computer] [are] currently switched off." (A);
	rule fails. 

Check an actor selecting the topic understood with a selection device controlling nothing (this is the claim a system error in the absence of selection device software rule):
	if the actor is the player:
		say "[The computer in question] [appear] to be suffering a system error and [have] no working software available to interpret your command." (A);
	rule fails.

Carry out an actor selecting the topic understood with a selection device which is part of a computer (this is the default mousing rule):
	abide by the input handling rules for the selected software in question.

Section 3 - Input Handling

Input handling rules are an object-based rulebook.

An input handling rule for a password-lock program (called chosen software) (this is the check for correct passwords rule):  
	let N be "[the topic understood]"; 
	if N is the password of the chosen software:
		carry out the rewarding successful answering activity with the chosen software;
		rule succeeds;
	otherwise:
		say "[rejection of the chosen software][paragraph break]" (A);
		rule fails.

An input handling rule for an enumerated multiple-choice program (called chosen software) (this is the pick a number rule): 
	let N be "[the topic understood]";
	replace the regular expression "(.*)(\d+)(.*)" in N with "\2";
	repeat through the options table of the chosen software: 
		let numero be "[index entry]";
		if N is numero:
			follow the effect entry;
			rule succeeds; 
	say "[out-of-bounds response of the chosen software][paragraph break]" (A);
	try examining the chosen software.

An input handling rule for a multiple-choice program (called chosen software) (this is the pick a choice rule):
	if the topic understood is a topic listed in the options table of the chosen software:
		follow the effect entry;
		rule succeeds;
	otherwise:
		say "[out-of-bounds response of the chosen software][paragraph break]" (A);
		rule fails. 

An input handling rule for a search engine (called chosen software) (this is the consult software rule):
	try consulting the chosen software about the topic understood instead.

An input handling rule for an email program (called chosen software) (this is the read email rule): 
	if the topic understood is a topic listed in the message table of the chosen software:
		if there is an arrival time entry:
			say "[description entry][paragraph break]" (A);
			now the read entry is true;
			rule succeeds;
	say "[regarding the noun]No such message [are] available.";
	rule fails.

Computers ends here.

Version 1.0.220525 of Universal Opening by Peter Orme begins here.

Chapter 1 - Universal opening commands - Not for release

Section - universal opening all doors and things

universal door opening is an action out of world applying to nothing.
understand "openalldoors" as universal door opening

carry out universal door opening (this is the universal door opening rule):
	repeat with chosen door running through every door:
		if the chosen door is closed:
			say "[The chosen door] - opening.";
			now the chosen door is open;
		otherwise:
			say "[The chosen door] - already open.";
	say "Now every door in the world should be open.";


universal thing opening is an action out of world applying to nothing. 
Understand "openallthings" as universal thing opening.

carry out universal thing opening (this is the universal thing opening rule):
	repeat with chosen item running through every openable thing which is not a door:
		if the chosen item is closed:
			say "[The chosen item] - opening.";
			now the chosen item is open;
		otherwise:
			say "[The chosen item] - already open.";
	say "Now everything (except doors) in the world should be open.";

universal everything opening is an action out of world applying to nothing. Understand "openall" as universal everything opening;

carry out universal everything opening (this is the universal everything opening rule):
	try universal thing opening;
	try universal door opening;

Section - universal opening of single things

universal-opening is an action out of world applying to one thing.

understand "openall [any thing]" as universal-opening.

carry out universal-opening an object (called chosen item)  (this is the universal opening something specific rule):
	if the chosen item is openable:
		if the chosen item is closed:
			now the chosen item is open;
			say "Opening [the chosen item].";
		otherwise:
			say "[The chosen item] is already open.";
	otherwise:
		say "[The chosen item] cannot be opened.";

Universal Opening ends here.

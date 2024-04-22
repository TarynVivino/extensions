Version 2.0.1 of Introductions by Emily Short begins here.

"Introductions provides an introductory paragraph about objects in a room description the first time the player looks in that location. It also allows the author to add segue text that will appear between one description and the next."

Section 1 - Introductions for objects

A thing can be as-yet-unknown or introduced. A thing is usually as-yet-unknown.
A thing has some text called the introduction. The introduction of a thing is usually "".

Definition: a thing is introduceable if it is as-yet-unknown and its introduction is not "" and it is visible.
	
To introduce (special-target - an object):
	now the special-target is introduced;
	say "[introduction of the special-target]".

Rule for writing a paragraph about an introduceable thing (called special-target) (this is the introduce unknowns rule):
	now the special-target is mentioned;
	introduce the special-target; 
	now the special-target is holding-paragraph-break.

A thing can be holding-paragraph-break or paragraph-complete.
	
After writing a paragraph about something (called original-target) which segue-suggests an introduceable thing (called special-target) (this is the connect related paragraphs rule): 
	segue from original-target to special-target;
	if the special-target is not introduced, 
		carry out the writing a paragraph about activity with the special-target;
	otherwise say fake-paragraph-break;
	now the original-target is paragraph-complete;
	now the special-target is paragraph-complete.

After writing a paragraph about something (called special-target) which is holding-paragraph-break: 
	now the special-target is paragraph-complete;
	say fake-paragraph-break.

fake-paragraph-break is some text that varies. fake-paragraph-break is "[line break]".
	
segue-suggesting relates various things to various things. The verb to segue-suggest (it segue-suggests, they segue-suggest, it segue-suggested, it is segue-suggested, it is segue-suggesting) implies the segue-suggesting relation.

When play begins (this is the initialize segues rule):
	repeat through the Table of Segues:
		now first entry segue-suggests second entry.

To segue from (original item - a thing) to (next item - a thing):
	repeat through Table of Segues:
		if original item is the first entry:
			if the next item is the second entry:
				say " [segue entry]";
				blank out the whole row;
				rule succeeds.

To say override intro/introduction of/for (N - a thing):
	now N is mentioned;
	now N is introduced.
	
Table of Segues
first (a thing)	second (a thing)	segue (text)
--	--	--


Section 2 - Room Introductions

A room has some text called the introduction. The introduction of a room is usually "".
Definition: a room is introduceable if it is as-yet-unknown and its introduction is not "".

A room can be as-yet-unknown or introduced. A room is usually as-yet-unknown.

The first time looking rule is listed last in the carry out looking rules.

This is the first time looking rule: 
	if location is introduceable:
		introduce the location;
		say paragraph break.

Introductions ends here.

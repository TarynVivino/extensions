Version 9.0.1 of Complex Listing by Emily Short begins here.

"Complex Listing provides more sophisticated listing options: the ability to impose special ordering instructions on a list, and also the ability to change the delimiters of the list to produce different styles and effects."

[This version adds responses to its single rule, slightly updates the examples, and provides a new implementation of "order list by length" that takes into account that indexed text is now the same as regular text.]

Use authorial modesty.

Table of Scored Listing
output	assigned score
an object	a number
with 30 blank rows.
 
To empty out (selected table - a table-name):
	repeat through selected table
	begin;
		blank out the whole row;
	end repeat. 
		
An object can be marked for special listing or unmarked for special listing. An object is usually unmarked for special listing.
	
To prepare a/the/-- list of (selection - description of objects):
	now every thing is unmarked for special listing;
	now every direction is unmarked for special listing;
	now every room is unmarked for special listing;
	now every region is unmarked for special listing;
	repeat with item running through members of the selection:
		now the item is marked for special listing;
	register things marked for listing.
 
To register the/-- things marked for listing:
	empty out the Table of Scored Listing;
	repeat with item running through directions which are marked for special listing:
		choose a blank row in the Table of Scored Listing;
		now output entry is the item; 
		now item is unmarked for special listing; 
	repeat with item running through rooms which are marked for special listing:
		choose a blank row in the Table of Scored Listing;
		now output entry is the item; 
		now item is unmarked for special listing; 
	repeat with item running through things which are marked for special listing:
		choose a blank row in the Table of Scored Listing;
		now output entry is the item; 
		now item is unmarked for special listing.

Articulation style is a kind of value. The articulation styles are bare, definite and indefinite. The current articulation style is an articulation style that varies.

To say is-are the prepared list:
	now current articulation style is definite;
	say tabled verb;
	say prepared list.

To say is-are a prepared list:
	now current articulation style is indefinite;
	say tabled verb;
	say prepared list.

To say is-are prepared list:
	now current articulation style is bare;
	say tabled verb;
	say prepared list.

To say tabled verb:
	if the number of filled rows in the Table of Scored listing is greater than 1, say "are ";
	otherwise say "is ";

To say the prepared list:
	now current articulation style is definite;
	say prepared list.
	
To say a prepared list:
	now current articulation style is indefinite;
	say prepared list. 

To say prepared list:
	if the number of filled rows in the Table of Scored Listing is 0:
		say "nothing";
		rule fails;
	dump list;
	now current articulation style is bare.

To say prepared list delimited in (chosen style - a list style) style:
	now current articulation style is indefinite;
	now current list style is the chosen style;
	say prepared list.

To say a prepared list delimited in (chosen style - a list style) style:
	now current articulation style is indefinite;
	now current list style is the chosen style;
	say prepared list.

To say the prepared list delimited in (chosen style - a list style) style:
	now current articulation style is definite;
	now current list style is the chosen style;
	say prepared list.

To say is-are prepared list delimited in (chosen style - a list style) style:
	now current articulation style is indefinite;
	now current list style is the chosen style;
	say tabled verb;
	say prepared list.

To say is-are a prepared list delimited in (chosen style - a list style) style:
	now current articulation style is indefinite;
	now current list style is the chosen style;
	say tabled verb;
	say prepared list.

To say is-are the prepared list delimited in (chosen style - a list style) style:
	now current articulation style is definite;
	now current list style is the chosen style;
	say tabled verb;
	say prepared list.
	
To dump list:
	carry out the list arranging activity;
	say list of the Table of Scored Listing;
	now current list style is sequential;
	empty out Table of Scored Listing.
	
List arranging is an activity.

Rule for list arranging: 
	sort Table of Scored Listing in assigned score order.

To invert scored list:
	sort Table of Scored Listing in reverse assigned score order.
	
First delimiter is text that varies. Second delimiter is text that varies. Alternate second delimiter is text that varies. First delimiter is ", ". Second delimiter is ", and ". Alternate second delimiter is " and ".

List style is a kind of value. The list styles are defined by the Table of List Style Assignments.

Current list style is a list style that varies. 

Table of List Style Assignments
list style	first delimiter	second delimiter	alternate second delimiter	indefinite name phrase	definite name phrase
sequential	", "	"[if the serial comma option is active],[end if] and "	" and "	"[a current listed object]"	"[the current listed object]"
disjunctive	", "	"[if the serial comma option is active],[end if] or "	" or "	"[a current listed object]"	"[the current listed object]"
semi-colon	"; "	"; "	" and "	"[a current listed object]"	"[the current listed object]"
comma	", "	", "	" and "	"[a current listed object]"	"[the current listed object]"
null	" "	" "	" and "	"[current listed object]"	"[current listed object]"
hyperconnective	" and "	" and "	" and "	"[a current listed object]"	"[the current listed object]"
fragmentary	". "	". "	". "	"[A current listed object]"	"[The current listed object]" 
enumerated	"; "	"; "	"; "	"([current enumeration]) [a current listed object]"	"([current enumeration]) [the current listed object]"

To decide what number is the current enumeration:
	let N be 1 + current listing total;
	decrease N by current listing index;
	decide on N.

To order list by length:
	repeat through Table of Scored Listing:
		let name be the printed name of the output entry;
		let count be the number of characters in name;
		now assigned score entry is count.

Current listing total is a number that varies. Current listing index is a number that varies. Current listed object is an object that varies.

To say a/the/-- list of (selected table - a table-name): 
	now current listing total is the number of filled rows in the selected table;
	now current listing index is current listing total;
	repeat through selected table:
		now current listed object is output entry;
		let wording be "";
		if the current articulation style is definite:
			let wording be the definite name phrase corresponding to a list style of the current list style in the Table of List Style Assignments;
		otherwise:
			let wording be the indefinite name phrase corresponding to a list style of the current list style in the Table of List Style Assignments;
		if the current listed object is a direction:
			say "[current listed object]";
		otherwise if the current articulation style is bare:
			say "[current listed object]";
		otherwise:
			say "[wording]";
		decrease current listing index by 1;
		carry out the delimiting a list activity.

Delimiting a list is an activity.

Rule for delimiting a list (this is the standard delimiting rule):
	choose row with list style of current list style in the Table of List Style Assignments;
	if current listing index is 1:
		if current listing total > 2, say "[second delimiter entry]" (A);
		otherwise say "[alternate second delimiter entry]" (B);
	otherwise:
		if current listing index > 0, say "[first delimiter entry]" (C).

Complex Listing ends here.

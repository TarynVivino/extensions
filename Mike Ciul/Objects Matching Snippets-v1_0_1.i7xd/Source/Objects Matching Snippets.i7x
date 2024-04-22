Version 1.0.1 of Objects Matching Snippets by Mike Ciul begins here.

Section - The Item to Match

The item to match is a object that varies.
Definition: A thing is matchable if it is the item to match.
Definition: An room is matchable if it is the item to match.
Definition: A direction is matchable if it is the item to match.
Definition: A region is matchable if it is the item to match.

Section - Snippet-matching

Does the object match is a snippet based rulebook. The does the object match rulebook has outcomes it does (success) and it does not (failure).

Does the object match a snippet (called S):
	if the item to match is a thing and S matches "[any matchable thing]", it does;
	if the item to match is a room and S matches "[any matchable room]", it does;
	if the item to match is a direction and S matches "[any matchable direction]", it does;
	if the item to match is a region and S matches "[any matchable region]", it does;
	it does not.

To decide whether (candidate - an object) matches (S - a snippet):
	Now the item to match is candidate;
	follow the does the object match rules for S;
	decide on whether or not the outcome of the rulebook is the it does outcome;
	
Snippet-matching relates an object (called candidate) to a snippet (called S) when candidate matches S. The verb to be identified with implies the snippet-matching relation.

Section - Snippet-inclusion

Does the object's name appear in is a snippet based rulebook. The does the object's name appear in rulebook has outcomes it does (success) and it does not (failure).

Does the object's name appear in a snippet (called S):
	if the item to match is a thing and S includes "[any matchable thing]", it does;
	if the item to match is a room and S includes "[any matchable room]", it does;
	if the item to match is a direction and S includes "[any matchable direction]", it does;
	if the item to match is a region and S includes "[any matchable region]", it does;
	it does not.

To decide whether the name of (candidate - an object) appears in (S - a snippet):
	Now the item to match is candidate;
	follow the does the object's name appear in rules for S;
	decide on whether or not the outcome of the rulebook is the it does outcome;
	
Snippet-inclusion relates an object (called candidate) to a snippet (called S) when the name of candidate appears in S. The verb to be named in implies the snippet-inclusion relation.

Section - Did the Player Choose

did the player choose is an object based rulebook.
The did the player choose rules have outcomes it is very likely, it is likely, it is possible, it is unlikely, it is very unlikely.

To decide which number is the/-- match score for (item - an object):
	follow the did the player choose rules for item;
	if the outcome of the rulebook is:
		-- the it is very likely outcome: decide on 4;
		-- the it is likely outcome: decide on 3;
		-- the it is possible outcome: decide on 2;
		-- the it is unlikely outcome: decide on 1;
		-- the it is very unlikely outcome: decide on 0;
	decide on 2;

The best match score is a number that varies.

Definition: A thing is likeliest if the match score for it is the best match score;
Definition: A room is likeliest if the match score for it is the best match score;
Definition: A direction is likeliest if the match score for it is the best match score;
Definition: A region is likeliest if the match score for it is the best match score;

Section - Choosing the Most Likely Object

To decide whether nothing matched:
	decide on whether or not the best match score is -1;

To decide whether something matched:
	decide on whether or not the best match score is at least 0;

To decide which object is the/-- most likely (O - description of objects):
	Let the already matched item be nothing;
	Now the best match score is -1;
	Repeat with the candidate running through the list of O:
		Let the current match score be the match score for the candidate;
		If the current match score is less than the best match score, next;
		If the current match score is the best match score:
			now the already matched item is nothing;
			next;
		Now the already matched item is the candidate;
		Now the best match score is the current match score;
	Decide on the already matched item.

Section - Testing Commands - Not for Release

match-checking is an action applying to one topic. Understand "objmatch [text]" as match-checking.

Report match-checking:
	showme the list of things identified with the topic understood;
	showme the list of rooms identified with the topic understood;
	showme the list of directions identified with the topic understood;
	showme the list of regions identified with the topic understood;

Objects Matching Snippets ends here.

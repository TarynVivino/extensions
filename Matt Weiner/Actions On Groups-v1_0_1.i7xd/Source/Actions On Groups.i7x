Version 1.0.1 of Actions on Groups by Matt Weiner begins here.

"Allows us to make certain actions apply to an entire player-specified group all at once, rather than applying serially to each member of the group."

Section 1 - The Multiple Actions Flag

Multiple actions already taken is a truth state that varies. [Will be used to block the action on groups from running for every object in the multiple object list after the first, and also for blocking the ordinary processing of the action.]

An action-processing rule when multiple actions already taken is true (this is the multiple actions preempt ordinary actions rule):
	stop the action.		

Every turn (this is the reset multiple actions flag rule): 
	now multiple actions already taken is false.

The multiple actions preempt ordinary actions rule is listed after the check for group action rule in the action-processing rulebook. [This stops the ordinary action from running when a group action has been performed.]

Section 2 - The Action On Groups Rulebook

Action on groups is a rulebook. Action on groups has default success. 

An action-processing rule when the current action is groupable action and the multiple object list is not empty and multiple actions already taken is false (this is the check for group action rule):
	follow the action on groups rules for the action name part of the current action;
	if rule succeeded or rule failed: [but not if there is no outcome, which will happen if no action on groups rule runs or the rules that run make no decision]
		now multiple actions already taken is true.

The check for group action rule is listed before the announce items from multiple object lists rule in the action-processing rulebook. [Could list it "first" but I want to leave open the possibility of another extension putting another rule first--all we need is to guarantee that it winds up before the announce items rule.]

The announce items from multiple object lists rule does nothing when multiple actions already taken is true. [So the ordinary processing of the actions doesn't print the names of everything in the multiple object list.] 

Section 3 - Group-Only Action

[If an action is group-only, then an attempt to carry it out with a multiple object list that is not one of the designated groups will fail, rather than serially executing the action for each object in the list.]

Last action on groups rule when the current action is group-only action (this is the can't use undesignated groups rule):
	say "Sorry, you can't do that with all those things at once." (A);
	rule fails. 
	
[Note that if you define other action on groups rules for group-only actions in the main source code, they will wind up after this one. So be careful!]

Section 4 - New Phrases

[so we can use the standard syntax: An action on groups for [action] when dealing with [list]:]

To decide whether dealing with (list one - a list of objects):
	let list two be the multiple object list;
	repeat with tester running through list one:
		if tester is not listed in list two:
			no;
	repeat with tester running through list two:
		if tester is not listed in list one:
			no;
	yes.

[An action on groups for [action] when dealing with [description]; this will fire whenever *any* object we're dealing with matches the description]

To decide whether dealing with (OS - description of objects):
	repeat with item running through the list of OS:
		if item is listed in the multiple object list, yes;
	no.

[An action on groups for [action] when dealing only with [description]: this will fire whenever *every* object we're dealing with matches the description. And there has to be at least one, or the action on groups rule never gets called.]

To decide whether dealing only with (OS - description of objects):
	repeat with item running through the multiple object list:
		unless item matches OS, no;
	yes.

[In case we want to redirect an action to a single action, so we have to clear the multiple object list.]

To clear the multiple object list:
	alter the multiple object list to {}.	
	
[But if we want to redirect to a new multiple action, a bit more preparation is needed. This phrase is particularly designed for use in Action on Groups rules, when we might want to change the multiple object list and then pass through to ordinary action processing.]

To prepare to act on/with (new list - list of objects), as nouns or as second nouns:
	alter the multiple object list to new list;
	let item be entry 1 in new list;
	if as second nouns:
		now the second noun is item;
	otherwise: [the "as the nouns" option doesn't do anything, but it's included for symmetry]
		now the noun is item;
	now the current item from the multiple object list is item.	

Section 5 - Serial And Fix (for use without Serial And Fix by Andrew Plotkin)

[This just is Andrew Plotkin's code that sometimes circulates under the name Serial And Fix. It allows comprehension of things like "PUT GLASS, VASE, AND PITCHER ON TABLE" rather than requiring "PUT GLASS, VASE AND PITCHER ON TABLE." Strictly speaking it's not necessary for this extension, and is useful even without this extension, but I figure that people using this extension are particularly likely to want to be able to understand the serial and.]

Include (- 
[ SquashSerialAnd
	ix jx lastwd wd addr len changedany;
	
	for (ix=1 : ix<= num_words : ix++) {
		wd = WordFrom(ix, parse);
		
		if (lastwd == comma_word && wd == AND1__WD) {
			addr = WordAddress(ix);
			len = WordLength(ix);
			for (jx=0 : jx<len : jx++) {
				addr->jx = ' ';
			}
			
			changedany++;
		}
		lastwd = wd;
	}
	
	return changedany;
];
-).

To squash serial ands:
	(- if (SquashSerialAnd()) { 
		VM_Tokenise(buffer,parse);
		num_words = WordCount();
		players_command = 100 + WordCount();
	}; -)

After reading a command:
	squash serial ands.

Section 6 - A Null Action

[we need to define an action that is groupable action and group-only action, so the Inform compiler will recognize those as kinds of action.]

Null acting is an action applying to one thing.
Null acting is groupable action.
Null acting is group-only action.

Actions on Groups ends here.

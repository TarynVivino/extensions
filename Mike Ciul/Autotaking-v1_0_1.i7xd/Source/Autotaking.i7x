Version 1.0.1 of Autotaking by Mike Ciul begins here.

"Implicit taking of noun or second noun that may be invoked by (or used as) a check rule."

Section - Sequential Action Option

Use sequential action translates as (- Constant SEQUENTIAL_ACTION; -).

Section - Autotaking Nouns Rules

This is the noun autotaking rule:
	if sequential action option is active:
		if the player is the person asked:
			try taking the noun;
		otherwise:
			try the person asked trying taking the noun;
	otherwise:
		if the player is the person asked:
			say "(first taking [the noun])";
			silently try taking the noun;
		otherwise:
			try the person asked trying taking the noun.
	
This is the second noun autotaking rule:
	if sequential action option is active:
		if the player is the person asked:
			try taking the second noun;
		otherwise:
			try the person asked trying taking the second noun;
	otherwise:
		if the player is the person asked:
			say "(first taking [the second noun])";
			silently try taking the second noun;
		otherwise:
			try the person asked trying taking the second noun.

Section - Must Hold Nouns Rules	

This is the must hold the noun rule:
	if the person asked does not have the noun, follow the noun autotaking rule;
	if the person asked does not have the noun, stop the action; 
	make no decision.

This is the must hold the second noun rule:
	if the person asked does not have the second noun, follow the second noun autotaking rule;
	if the person asked does not have the second noun, stop the action;
	make no decision.

Autotaking ends here.

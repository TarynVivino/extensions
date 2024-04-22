Version 1.0.1 of Flexible Action Requirements by Mike Ciul begins here.

"Overrides carrying requirements for specific actions, and provides more nuanced carrying and touchability requirements when needed."

Volume - Flexible Kinds of Action

Waiting is flexible about carrying the noun.
Waiting is flexible about carrying the second noun.
Waiting is flexible about touching the noun.
Waiting is flexible about touching the second noun.

Part - Involved and Must Be Used

To decide whether (item - a thing) must be used:
	Decide on whether or not the current action involves the item.

Definition: An object is involved if it must be used.

To decide whether (O - a description of objects) must be used:
	unless the O that must be used is nothing, yes;
	no.

To decide which object is the (O - a description of objects) that must be used:
	if the noun matches O, decide on the noun;
	if the second noun matches O, decide on the second noun;
	decide on nothing.

Volume - Carrying Requirements

Part - Determining Carrying Requirements

Chapter - Only Available When Carried and Must Be Carried

Definition: an object (called item) is only available when carried:
	Follow the custom carrying requirements for the item;
	If the outcome of the rulebook is the it must be carried outcome, yes;
	no.
	
To decide whether (item - a thing) must be carried:
	If item is not involved, no;
	Decide on whether or not item is only available when carried.

Chapter - Custom Carrying Requirements Rules

The custom carrying requirements is an object-based rulebook. The custom carrying requirements rules have outcomes it must be carried (failure) and it may be merely visible (success).

Custom carrying requirements for the noun (this is the basic carrying requirements for the noun rule):
	If flexible about carrying the noun, make no decision;
	If the action requires a carried noun, it must be carried.
	
Custom carrying requirements for the second noun (this is the basic carrying requirements for the second noun rule):
	If flexible about carrying the second noun, make no decision;
	If the action requires a carried second noun, it must be carried.
			
Part - Enforcing Carrying Requirements

Chapter - The Flexible Carrying Requirements Rule

Section - Definition

An action-processing rule (this is the flexible carrying requirements rule):
	If the noun is not held by the person asked and the noun is only available when carried:
		Carry out the implicitly taking activity with the noun;
		If the noun is not carried, stop the action;
	If the second noun is not held by the person asked and the second noun is only available when carried:
		Carry out the implicitly taking activity with the second noun;
		If the second noun is not carried, stop the action.

The flexible carrying requirements rule is listed instead of the carrying requirements rule in the action-processing rules.

Chapter - Implicit Taking

For implicitly taking something (called the item):
	Do an implicit take with the item;
	
To do an implicit take with (O - an object):
	(- ImplicitTake({O}); -)
		
Volume - Touchability Requirements

Part - Determining Touchability

Chapter - Only Available When Touchable and Must Be Touched

Definition: an object (called item) is only available when touchable:
	Follow the custom touchability requirements for the item;
	If the outcome of the rulebook is the it must be touchable outcome, yes;
	no.

To decide whether (item - a thing) must be touched:
	If item is not involved, no;
	Decide on whether or not item is only available when touchable.

To decide whether (O - a description of objects) must be touched:
	[This is not only convenient, but it's faster than looping over all things to find something that is "required to be touched"]
	unless the O that must be touched is nothing, yes;
	no.

To decide which object is the (O - a description of objects) that must be touched:
	if the noun matches O and the noun is only available when touchable, decide on the noun;
	if the second noun matches O and the second noun is only available when touchable, decide on the second noun;
	decide on nothing.

Definition: a thing is required to be touched if it must be touched.

Chapter - Custom Touchability Requirements Rules
	
The custom touchability requirements is an object-based rulebook. The custom touchability requirements rules have outcomes it must be touchable (failure) and it may be merely visible (success).

Custom touchability requirements for the noun (this is the basic touchability requirements for the noun rule):
	If flexible about touching the noun, make no decision;
	If the action requires a touchable noun, it must be touchable.
	
Custom touchability requirements for the second noun (this is the basic touchability requirements for the second noun rule):
	If flexible about touching the second noun, make no decision;
	If the action requires a touchable second noun, it must be touchable.

Flexible Action Requirements ends here.

Version 5.2.2 of Far away by Jon Ingold begins here.

"Creates an adjective for far-off items which cannot be touched."

[ Updated to work with the Inform 6M62 port of Counterfeit Monkey. Removed deprecated features - Petter Sjölund ]

Use far away extension translates as (- Constant FARAWAY; -).  
Use far away extension.

Section - The basic definition

A thing can be near or distant. A thing is usually near.

Definition: a thing is far-off if it is distant or it is enclosed by something distant.

Section - The Access Flag

[ This is needed to stop the rules being considered every time the parser considers what's in scope. It should force the rules to only be run once, although it might be the case that if a command *succeeds* and then a visible item call is made, the rules get run again. That might need some more thought! ]

Access-flag is a number that varies. 
Access-flag is 0.

A before rule:
       if the action requires a touchable noun, now access-flag is 1;
       if the action requires a touchable second noun, now access-flag
is 1;

A turn sequence rule: now access-flag is 0.

Section - Accessibility rule

[ This uses the accessibility rule-book, so distance checking comes after checking the scope but before looking for barriers. So if the roses are inside a transparent distant greenhouse, they'll also be too far away. ]

The check distance rule is listed before the access through barriers rule in the accessibility rulebook.

Accessibility rule (this is the check distance rule): 
	if the action requires a touchable noun: 
		if the noun is far-off and we can't get at the noun, rule fails;
	if the action requires a touchable second noun: 
		if the second noun is far-off and we can't get at the second noun, rule fails.

Section - Reporting Errors

[ 

Since the rules will get called for all visibility checks, we make sure we only print anything if we are "reporting errors". It's possible the rulebook should never be called if we're not reporting errors!

]


To decide if reporting errors: if the person asked is the player and access-flag is 1, yes; no.

Section - distant stuff rulebook

distant stuff is an object-based rulebook. 

The far-off item is a thing that varies.

To decide if we can't get at (n - a thing):
[ This runs the rulebook. Means we can consider noun and second noun neatly in the accessibility rule above. ]
	now the far-off item is n;
	follow the distant stuff rules for the far-off item;
	if rule failed:
		decide yes;
		now access-flag is 0;
	decide no.

The last distant stuff rule for a thing (called the item) when the person asked is not the player (this is the fail other people rule): 
	rule fails.

The last distant stuff rule when reporting errors (this is the can't touch rule):
	say far-off message, paragraph break;
	rule fails.

Section - Messages

The far-off message is a text that varies. The far-off message is "[The far-off item] [are] out of reach."



Far away ends here.

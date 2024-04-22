Version 2 of Push Pull Turn by Brent Worthington begins here.

"Provides a framework for pushing, pulling and turning."

The can't push what's fixed in place rule is not listed in the check pushing rulebook.
The can't turn what's fixed in place rule is not listed in the check turning rulebook.
The can't pull what's fixed in place rule is not listed in the check pulling rulebook.
The can't push scenery rule is not listed in the check pushing rulebook.
The can't turn scenery rule is not listed in the check turning rulebook.
The can't pull scenery rule is not listed in the check pulling rulebook.
The can't push people rule is not listed in the check pushing rulebook.
The can't turn people rule is not listed in the check turning rulebook.
The can't pull people rule is not listed in the check pulling rulebook.
The report pushing rule is not listed in the report pushing rulebook.
The report turning rule is not listed in the report turning rulebook.
The report pulling rule is not listed in the report pulling rulebook.

The thing is either pushable or unpushable. The thing is usually unpushable.
The thing is either turnable or unturnable. The thing is usually unturnable.
The thing is either pullable or unpullable. The thing is usually unpullable.

Does the player mean pushing something (this is the prefer pushing pushables rule):
if the noun is pushable begin;
it is very likely;
otherwise;
it is very unlikely;
end if.

Does the player mean turning something (this is the prefer turning turnables rule):
if the noun is turnable begin;
it is very likely;
otherwise;
it is very unlikely;
end if.

Does the player mean pulling something (this is the prefer pulling pullables rule):
if the noun is pullable begin;
it is very likely;
otherwise;
it is very unlikely;
end if.

Check pushing something unpushable (this is the can't push unpushables rule): say "[We] [cannot] push [the noun]." (A) instead.

Check turning something unturnable (this is the can't turn unturnables rule): say "[We] [cannot] turn [the noun]." (A) instead.

Check pulling something unpullable (this is the can't pull unpullables rule): say "[We] [cannot] pull [the noun]." (A) instead.

Push Pull Turn ends here.

---- DOCUMENTATION ----

This extension provides a framework for pushing, pulling and turning. It introduces the quality of being "pushable" or "unpushable", "pullable" or "unpullable", and "turnable" or "unturnable". You can declare any object as pushable, turnable or pullable, and then attach intended behaviour to the object (without having to use 'instead' rules). The game should behave gracefully if someone tries to push, pull or turn something that can't be moved in that way.

In the following example, Cart Jam, we can see new rules attached to shopping trolleys, which can be pushed, pulled or turned in order to solve a simple puzzle.

Example:** Cart Jam - Pulling, Pushing, Turning in action

	*:"Cart Jam"

	Include Push Pull Turn by Brent Worthington.

	Supermarket Aisle is a room. "There narrow supermarket aisle has been littered with discarded trolley carts that need to be pulled and twisted free, then pushed safely out of the way."

	A cart is a kind of thing. A cart is usually pushable, pullable and turnable. The red trolley is a cart in the Supermarket Aisle. The green trolley is a cart in the Supermarket Aisle. The yellow trolley is a cart in the Supermarket Aisle.

	The description of a cart is usually "[if the noun is not jammed and the noun is not twisted]The cart has now been freed.[else if the noun is jammed]The cart is jammed.[else]The cart is twisted around, blocking the narrow aisle.[end if]"

	A cart can be jammed. A cart is usually jammed. A cart can be twisted. The yellow trolley is twisted.

	Before taking a cart:
		say "You can move the cart around, pushing, pulling or turning, but it's too heavy to lift up." instead.

	Check pushing a cart (called the target):
		if the target is jammed:
			say "The [target] is jammed in with another trolley." instead;
		if the target is twisted:
			say "The [target] is turned the wrong way." instead;
		if there is a twisted cart (called the blocker) in the Supermarket Aisle:
			say "The [blocker] is in the way." instead;

	Carry out pushing a cart:
		now the noun is off-stage;
		say "You shunt the trolley down the aisle, safely away from the current tangle.";
		if no carts are in the supermarket aisle:
			say paragraph break;
			say "You did it! You cleared the aisle of all the trolleys!";
			end the story finally.

	Check pulling a cart (called the target):
		if the target is twisted:
			say "The [target] is currently turned the wrong way in the aisle to pull." instead;
		if the target is not jammed:
			say "The [target] has already been pulled clear." instead.

	Carry out pulling a cart (called the target):
		now the target is not jammed;
		say "You pull [the target] clear. [run paragraph on]";
		if two carts are jammed:
			say "There are still two carts jammed.";
		else:
			now every cart is not jammed;
			say "The jam has been cleared.";

	Carry out turning a cart (called the trolley):
		if the trolley is jammed:
			say "It's too jammed in with the other trolleys to turn." instead;
		else if the trolley is twisted:
			say "You turn the trolley around, unblocking the aisle.";
			now the trolley is not twisted;
		else:
			now the trolley is twisted;
			say "You turn the trolley around, blocking the aisle."

	The shelves are scenery in the supermarket aisle.

	The initial appearance of a cart is usually "The [item described] is [if the item described is twisted and the item described is jammed]jammed with another trolley, and twisted to one side, blocking the aisle[else if the item described is twisted]twisted, blocking the aisle[else if the item described is jammed]jammed with another trolley[else]sitting neatly in the aisle[end if]."

	Test me with "Push shelves / pull shelves / turn shelves / pull yellow / push yellow / push red / turn red / pull green / pull red / turn yellow / push red / push green / push yellow"

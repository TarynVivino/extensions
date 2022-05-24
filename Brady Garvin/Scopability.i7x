Version 1/210620 of Scopability by Brady Garvin begins here.

"The ability to toggle objects' scopability; the parser does not acknowledge the existence of unscopable objects, even if they are explicitly added to scope."

[ per https://intfiction.org/t/friends-of-i7-extension-testing/51284/14, fixed a compilation error by changing a ';' -> '.' ]

Chapter "Scopability"

An object can be scopable or unscopable.
An object is usually scopable.
An unscopable thing is usually scenery.

Chapter "Parser Changes to Honor Scopability"

Include (-
	[ DoScopeAction item;
! BEGIN CHANGE FOR SCOPABILITY
		if (~~GetEitherOrProperty(item, (+ scopable +))) {
			return;
		}
! END CHANGE FOR SCOPABILITY
#Ifdef DEBUG;
		if (parser_trace >= 6) {
			print "[DSA on ", (the) item, " with reason = ", scope_reason,
				" p1 = ", parser_one, " p2 = ", parser_two, "]^";
		}
#Endif;
		@push parser_one;
		@push scope_reason;
		switch (scope_reason) {
		TESTSCOPE_REASON:
			if (item == parser_one) {
				parser_two = 1;
			}
		LOOPOVERSCOPE_REASON:
			if (parser_one ofclass Routine) {
				indirect(parser_one, item);
			}
		PARSING_REASON, TALKING_REASON:
			MatchTextAgainstObject(item);
		}
		@pull scope_reason;
		@pull parser_one;
	];
-) instead of "DoScopeAction" in "Parser.i6t".

Scopability ends here.

---- DOCUMENTATION ----

When Scopability is included, every object can be either scopable or unscopable.
Most are scopable, which means that they are subject to Inform's usual scope
rules.  But unscopable objects are never acknowledged by the parser, even if we
try to explicitly add them to scope, which is useful for modeling objects that
are present, but that the player character cannot see.

Objects declared as initially unscopable are scenery unless we state otherwise;
non-scenery usually appears in room descriptions, which would contradict the
supposed invisibility.  However, scopable and scenery status are toggled
independently thereafter, so revealing an object usually means changing both
properties.

Example: * The Visitor - An object that is present but unrevealed.

	*: "The Visitor"

	Include Scopability by Brady Garvin.

	Cavern is a room.
	The rocky debris is scenery.
	The alien artifact is an unscopable thing in the cavern.
	"It's embedded in the rock!"

	Every turn when the alien artifact is in the location:
		say "There's a faint humming coming from above."

	Instead of listening when the alien artifact is in the location:
		say "Hmmmm hmmmm hmmmm.  Hm hm hm hm.  Hmmmm hm hm.  Hm.  Hm hmmmm.  Hm hmmmm hm."

	Instead of jumping when the alien artifact is in the location and the alien artifact is not scopable:
		say "The jolt shakes [rocky debris] loose from the ceiling, revealing [an alien artifact]!";
		now the rocky debris is in the location;
		now the alien artifact is scopable;
		now the alien artifact is not scenery.

	Test me with "z / listen / x artifact / jump / x artifact".

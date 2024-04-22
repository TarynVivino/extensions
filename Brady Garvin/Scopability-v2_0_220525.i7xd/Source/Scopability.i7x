Version 2.0.220525 of Scopability by Brady Garvin begins here.

"The ability to toggle objects' scopability; the parser does not acknowledge the existence of unscopable objects, even if they are explicitly added to scope."

Section - Scopable property high level

An object can be scopable or unscopable.
An object is usually scopable.

Section - Scopable property low level

Include (- Attribute scopable; -)

The scopable property translates into Inter as "scopable".

Section - Unscopable things usually scenery

An unscopable thing is usually scenery.

Section - Parser changes to honor scopable property

[ DoScopeAction is located in Parser.i6t in the CommandParserKit. ]
[ This is the bottom level thing which acts when something is being put in scope, so cancelling out here
  makes sure that the item is never treated as in scope, for any purpose ]
[ As of this writing, DoScopeAction contains the truly ancient piece of code "indirect(parser_one, item)",
	but although this is accepted by Inform 7 in a Kit, this isn't accepted in an Inform 6 inclusion by Inform 7.
	This code is equivalent to parser_one(item) -- Thanks to Andrew Plotkin for figuring this out. ]

Include (-
[ DoScopeAction item;

	if (item hasnt scopable) return; ! This line added by Scopability

	#Ifdef DEBUG;
	if (parser_trace >= 6)
		print "[DSA on ", (the) item, " with reason = ", scope_reason,
			" p1 = ", parser_one, " p2 = ", parser_two, "]^";
	#Endif; ! DEBUG

	@push parser_one; @push scope_reason;

	switch(scope_reason) {
		TESTSCOPE_REASON: if (item == parser_one) parser_two = 1;
		LOOPOVERSCOPE_REASON: if (parser_one ofclass Routine) parser_one(item);
		PARSING_REASON, TALKING_REASON: MatchTextAgainstObject(item);
		}

	@pull scope_reason; @pull parser_one;
];
-) replacing "DoScopeAction"

Scopability ends here.

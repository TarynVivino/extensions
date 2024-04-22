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

Changelog:
	Version 2: Updated for Inform 10.1 by Nathanael Nerode.  Thanks to Andrew Plotkin and Zed Lopez for deciphering black magic in the parser code.
	Version 1/210620: per https://intfiction.org/t/friends-of-i7-extension-testing/51284/14, fixed a compilation error by changing a ';' -> '.' (modified by Zed Lopez)
	Version 1: Brady Garvin committed to Friends of I7 repo on Dec 28, 2013 with the note "Added my scopability code, per a forum request."


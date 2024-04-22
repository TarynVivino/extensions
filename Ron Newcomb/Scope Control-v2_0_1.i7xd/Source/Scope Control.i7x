Version 2.0.1 of Scope Control by Ron Newcomb begins here.

"Allows us to ask why the Deciding the Scope For Something activity is running, so we can modify the scope only when we absolutely need to.  Highly useful for giving NPCs commands over telephones or while in darkness, creating 'can hear' relations, or modifying how Inform parses the command line."

To decide if parsing the/a/an/some/any/-- nouns: (- (scope_reason == 0) -).
To decide if parsing for/-- persuasion: (- (scope_reason == 1) -).
To decide if looping over scope: (- (scope_reason == 5) -).
To decide if testing scope: (- (scope_reason == 6) -).

Section - really only useful for testing scope control - not for release - unindexed 

The reason for deciding scope is a number that varies.
The reason for deciding scope variable translates into I6 as "scope_reason".

To say the/-- reason for deciding scope:
	if the reason for deciding scope is:
		-- 0: say "parsing nouns";
		-- 1: say "parsing for persuasion";
		-- 5: say "looping over scope";
		-- 6: say "testing scope";
		-- otherwise: say "other".

Scope Control ends here.


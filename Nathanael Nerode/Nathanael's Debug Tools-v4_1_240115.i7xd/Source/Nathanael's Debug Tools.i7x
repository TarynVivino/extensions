Version 4.1.240115 of Nathanael's Debug Tools by Nathanael Nerode begins here.

"Miscellaneous stuff I like to have built in when debugging and programming, but would never want to relase."

Section - Quit Faster

[Speed up the debug cycle by not asking for confirmation before quitting.]

Include (-
[ QUIT_THE_GAME_R;
  if (actor ~= player) rfalse;
    quit;
];
-) replacing "QUIT_THE_GAME_R".

Section - Startup Debugging

Use startup rules tracing translates as a configuration flag.

[ See RulesOnSub in Tests.i6t for reference ]
To turn rules tracing on:
	(- debug_rules = 1; -)

This is the trace rules at startup rule:
	if the startup rules tracing option is active:
		turn rules tracing on;

[ We want to let the game initialize memory, start the virtual machine, and seed the RNG before tracing starts.]
The trace rules at startup rule is listed after the initial whitespace rule in the after starting the virtual machine rules.
The trace rules at startup rule is listed before the update chronological records rule in the after starting the virtual machine rules.

[ The first rule which will actually trace is the "start in the correct scenes" rule.
This is because NI doesn't instrument the earlier startup rules with the debug code, at least in 6M62.
We might be able to fix this now that Inform v10 is open-source; I'm not sure.]

[ The untraceable rules in Standard Rules are:
		initialize memory
		virtual machine startup
		seed random number generator
		update chronological records
		declare everything initially unmentioned -- the one we might want to trace
		position player in model world
]


Nathanael's Debug Tools ends here.

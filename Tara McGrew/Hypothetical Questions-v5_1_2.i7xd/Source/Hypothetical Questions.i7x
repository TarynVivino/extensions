Version 5.1.2 of Hypothetical Questions (for Glulx only) by Tara McGrew begins here.

"Allows us to test the consequences of a phrase or action without permanently changing the game state."

"Updated for 10.2 by Zed Lopez"


[To hypothetically (ph - a phrase) and consider (R - a rule): (- switch (Hypo_Start({phrase options})) { 1: do {ph} } until (1); Hypo_Middle({R}); 2: Hypo_End(); } if (0) { -).]

To hypothetically (ph - a phrase) and consider (R - a rule): (- switch (Hypo_Start({phrase options})) { 1: do { {ph} } until (1); Hypo_Middle({R}); 2: Hypo_End(); } -).

To say the/-- hypothetical output: (- Hypo_Capture_Print(); -).

Use hypothetical output length of at least 256 translates as the configuration value HYPO_CAPTURE_BYTES.

Include (-
Constant HYPO_RESULT_WORDS = 2;
! hypo_result-->0 = rule success flag
! hypo_result-->1 = rule result
Array hypo_result --> HYPO_RESULT_WORDS;

Array hypo_capture -> HYPO_CAPTURE_BYTES_CFGV;
Global hypo_capture_len;
Global hypo_capture_previous;

! returns 1 when entering the hypothetical universe, 2 when returning to reality, 0 if entering failed in the first place
[ Hypo_Start flags  rv seed strtbl iosys iorock;
	do { @random 0 seed; } until (seed ~= 0);
	@getstringtbl strtbl;
	@getiosys iosys iorock;

	@saveundo rv;

	@setrandom seed;
	@setstringtbl strtbl;
	@setiosys iosys iorock;

	switch (rv) {
		0: Hypo_Capture_Start(); return 1; ! saveundo succeeded
		1: print "[This game requires an interpreter with undo support.]^"; return 0; ! saveundo failed
		-1: return 2; ! restoreundo
	}
];

! consider a rule, protect its result, and restore the state saved by Hypo_Start
[ Hypo_Middle rule  a b save_sp x;
	Hypo_Capture_End();
	save_sp = say__p; say__p = 0;
	FollowRulebook(rule);
	if (say__p == false) { say__p = save_sp; };
	hypo_result-->0 = RulebookOutcome();
	if (hypo_result-->0 == RS_FAILS or RS_SUCCEEDS) {
		hypo_result-->1 = ResultOfRule();
    }
    x = (HYPO_RESULT_WORDS * WORDSIZE);
	@protect hypo_result x;
! never returns if successful
	@restoreundo rule;	
	print "[What happened to my undo state? --hypo]^";
];

! load the rule result from Hypo_Middle back onto the rulebook stack

[ Hypo_End x;
  if ((hypo_result-->0) == RS_FAILS) RulebookFails(1, hypo_result-->1);
  else if ((hypo_result-->0) == RS_SUCCEEDS) RulebookSucceeds(1, hypo_result-->1);
  else RuleHasNoOutcome();
];

! start capturing output
[ Hypo_Capture_Start;
	! use a Glk memory stream
	hypo_capture_previous = glk_stream_get_current();
	glk_stream_set_current(glk_stream_open_memory(hypo_capture, HYPO_CAPTURE_BYTES_CFGV, filemode_Write, 0));
];

! stop capturing output
[ Hypo_Capture_End  f;
	glk_stream_close(glk_stream_get_current(), gg_arguments);
	hypo_capture_len = gg_arguments-->1;
	glk_stream_set_current(hypo_capture_previous);
	hypo_capture_previous = 0;
];

! print the capture buffer
[ Hypo_Capture_Print  i;
	for (i=0: i<hypo_capture_len: i++)
		print (char) hypo_capture->i;
];
-).

Hypothetical Questions ends here.

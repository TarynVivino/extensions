Version 7.1.230729 of Undo Output Control by Nathanael Nerode begins here.

"Provides hooks into UNDO processing, including multiple ways to suspend UNDO temporarily, to place limitations on UNDO (such as allowing only one UNDO in a row), to undo the current turn from code, and to control when the game state is saved. Using the latter, we can effectively control which turn UNDO returns us to.  Also allows the story to edit a blank command before analyzing it.  Updated to Inform 10.1."

"based on the extension by Erik Temple; 
integrates Empty Command Handling by Daniel Stelzer based on code by Matt Weiner"

Volume - High Level Stuff

Section - Rulebooks

The before undoing an action rules are a rulebook. 
The report undoing an action rules are a rulebook.
The after undoing an action rules are a rulebook. 

The before prevented undo rules are a rulebook.
The report prevented undo rules are a rulebook.
The after prevented undo rules are a rulebook.

The before interpreter-undo-incapacity rules are a rulebook.
The after interpreter-undo-incapacity rules are a rulebook.
The report interpreter-undo-incapacity rules are a rulebook.

The before interpreter undo failure rules are a rulebook.
The report interpreter undo failure rules are a rulebook.
The after interpreter undo failure rules are a rulebook.

The before nothing to be undone failure rules are a rulebook.
The report nothing to be undone failure rules are a rulebook.
The after nothing to be undone failure rules are a rulebook.

The default report undoing an action rule is listed last in the report undoing an action rules.
This is the default report undoing an action rule:
	rule fails.

The default report prevented undo rule is listed last in the report prevented undo rules.
This is the default report prevented undo rule:
	rule fails.

The default report interpreter-undo-incapacity rule is listed last in the report interpreter-undo-incapacity rules.
This is the default report interpreter-undo-incapacity rule:
	rule fails.

The default report interpreter undo failure rule is listed last in the report interpreter undo failure rules.
This is the default report interpreter undo failure rule:
	rule fails.

The default report nothing to be undone failure rule is listed last in the report nothing to be undone failure rules.
This is the default report nothing to be undone failure rule:
	rule fails.

Section - Control over saving undo state

Save undo state is a truth state that varies. Save undo state is usually true.

To disable saving of/-- undo state: now save undo state is false.
To enable saving of/-- undo state: now save undo state is true.

Section - Invoking Undo

to undo the current turn:
	(- Perform_Undo(); -).

Section - Empty Command Handling

Repairing an empty command is an activity.

Section - Undo Suspension

Temporary undo suspension is a truth state that varies. Temporary undo suspension is usually false.

To suspend undo: now temporary undo suspension is true.
To reinstate undo: now temporary undo suspension is false.

To decide whether undo is suspended: decide on temporary undo suspension.

The report attempt to undo-while-disabled rules are a rulebook.

The last report attempt to undo-while-disabled rule (this is the undoing is disabled rule):
	say "That action cannot be undone." (A);
	rule succeeds;

Volume - Low Level Stuff

Part - PerformUndo

Section - Patches to PerformUndo

[ This replaces code from WorldModelKit from State.i6t ]

Include (-
[ Perform_Undo;
	if (CommandParserKit`UNDO_PREVENTION_CFGF) {
		if ( FollowRulebook( (+ report prevented undo rules +) ) && RulebookFailed()) {
			IMMEDIATELY_UNDO_RM('A'); new_line;
		}
		return;
	}
	if (IterationsOfTurnSequence == 0) {
		FollowRulebook ( (+ before nothing to be undone failure rules +) );
		if ( FollowRulebook( (+ report nothing to be undone failure rules +) ) && RulebookFailed()) {
			IMMEDIATELY_UNDO_RM('B'); new_line;
		}
		FollowRulebook ( (+ after nothing to be undone failure rules +) );
		return; 
	}
	if (undo_flag == 0) { 
		FollowRulebook ( (+ before interpreter-undo-incapacity rules +) );
		if ( FollowRulebook( (+ report interpreter-undo-incapacity rules +) ) && RulebookFailed()) {
			IMMEDIATELY_UNDO_RM('C'); new_line;
		}
		FollowRulebook ( (+ after interpreter-undo-incapacity rules +) );
		return; 
	}
	if (undo_flag == 1) { 
		! Undo failed because the interpreter did not save a game when it was supposed to.
		! This happens rarely under Z-Machine but may be thrown by a Glulx interpreter which can't save.
		! For clarity of error message, this should be treated as an interpreter incapacity, not interpreter failure.
		FollowRulebook ( (+ before interpreter-undo-incapacity rules +) );
		if ( FollowRulebook( (+ report interpreter-undo-incapacity rules +) ) && RulebookFailed()) {
			IMMEDIATELY_UNDO_RM('D'); new_line;
		}
		FollowRulebook ( (+ after interpreter-undo-incapacity rules +) );
		return; 
	}
	if ( (+ temporary undo suspension +) ) {
		FollowRulebook ( (+ report attempt to undo-while-disabled rules +) );
		return;
	}
	if (VM_Undo() == 0) {
		! Undo failed because the interpreter failed to restore, probably because the undo limit was exceeded.
		FollowRulebook ( (+ before interpreter undo failure rules +) );
		if ( FollowRulebook( (+ report interpreter undo failure rules +) ) && RulebookFailed()) {
			IMMEDIATELY_UNDO_RM('F'); new_line;
		}
		FollowRulebook ( (+ after interpreter undo failure rules +) );
	}
];
-) replacing "Perform_Undo".

Part - Keyboard (for use without Unified Glulx Input by Andrew Plotkin)

Section - Patches to Keyboard

[ This replaces a routine in CommandParserKit in Parser.i6t ]
[ Most of this should be identical, just the Undo bits should change ]

Include (-
[ Keyboard  a_buffer a_table  nw i w w2 x1 x2;
	sline1 = score; sline2 = turns;

	while (true) {
		! Save the start of the buffer, in case "oops" needs to restore it
		#Iftrue CHARSIZE == 1;
		for (i=0 : i<64 : i++) oops_workspace->i = a_buffer->i;
		#Ifnot;
		for (i=0 : i<64 : i++) oops_workspace-->i = a_buffer-->i;
		#Endif;

		! In case of an array entry corruption that shouldn't happen, but would be
		! disastrous if it did:
		#Iftrue CHARSIZE == 1;
		a_buffer->0 = INPUT_BUFFER_LEN;
		a_table->0 = 15;  ! Allow to split input into this many words
		#Endif; ! TARGET_

		! Print the prompt, and read in the words and dictionary addresses
		PrintPrompt();
		KeyboardPrimitive(a_buffer, a_table, DrawStatusLine);

		! Set nw to the number of words
		#Iftrue CHARSIZE == 1;
		nw = a_table->1;
		#Ifnot;
		nw = a_table-->0;
		#Endif;

		! If the line was blank, ask the game to fill it in.  If it doesn't, get a fresh line
		if (nw == 0) {
			x2 = false; ! repurposing local variable as a flag
			BeginActivity( (+ repairing an empty command +) );
			if ( ForActivity( (+ repairing an empty command +) ) == false) {
				@push etype; etype = BLANKLINE_PE;
				players_command = 100;
				BeginActivity(PRINTING_A_PARSER_ERROR_ACT);
				if (ForActivity(PRINTING_A_PARSER_ERROR_ACT) == false) {
					PARSER_ERROR_INTERNAL_RM('X', noun); new_line;
				}
				EndActivity(PRINTING_A_PARSER_ERROR_ACT);
				@pull etype;
				x2 = true;
			}
			EndActivity( (+ repairing an empty command +) );
			if (x2) continue; ! if the activity wasn't handled, get new command
		}

		! Unless the opening word was OOPS or UNDO, return
		! Conveniently, a_table-->1 is the first word on both the Z-machine and Glulx

		w = a_table-->1;
		if (w == OOPS1__WD or OOPS2__WD or OOPS3__WD) {
			if (oops_from == 0) { PARSER_COMMAND_INTERNAL_RM('A'); new_line; continue; }
			if (nw == 1) { PARSER_COMMAND_INTERNAL_RM('B'); new_line; continue; }
			if (nw > 2) { PARSER_COMMAND_INTERNAL_RM('C'); new_line; continue; }

			! So now we know: there was a previous mistake, and the player has
			! attempted to correct a single word of it.

			#Iftrue CHARSIZE == 1;
			for (i=0 : i<INPUT_BUFFER_LEN : i++) buffer2->i = a_buffer->i;
			x1 = a_table->9;  ! Start of word following "oops"
			x2 = a_table->8;  ! Length of word following "oops"
			#Ifnot;
			for (i=0 : i<INPUT_BUFFER_LEN : i++) buffer2-->i = a_buffer-->i;
			x1 = a_table-->6; ! Start of word following "oops"
			x2 = a_table-->5; ! Length of word following "oops"
			#Endif;

			! Repair the buffer to the text that was in it before the "oops"
			! was typed:
			#Iftrue CHARSIZE == 1;
			for (i=0 : i<64 : i++) a_buffer->i = oops_workspace->i;
			#Ifnot;
			for (i=0 : i<64 : i++) a_buffer-->i = oops_workspace-->i;
			#Endif;
			VM_Tokenise(a_buffer,a_table);

			! Work out the position in the buffer of the word to be corrected:
			#Iftrue CHARSIZE == 1;
			w = a_table->(4*oops_from + 1); ! Start of word to go
			w2 = a_table->(4*oops_from);    ! Length of word to go
			#Ifnot;
			w = a_table-->(3*oops_from);      ! Start of word to go
			w2 = a_table-->(3*oops_from - 1); ! Length of word to go
			#Endif;

			! Write spaces over the word to be corrected:
			#Iftrue CHARSIZE == 1;
			for (i=0 : i<w2 : i++) a_buffer->(i+w) = ' ';
			#Ifnot;
			for (i=0 : i<w2 : i++) a_buffer-->(i+w) = ' ';
			#Endif;

			if (w2 < x2) {
				! If the replacement is longer than the original, move up...
				#Iftrue CHARSIZE == 1;
				for (i=INPUT_BUFFER_LEN-1 : i>=w+x2 : i-- ) ! Note: don't close Include
					a_buffer->i = a_buffer->(i-x2+w2);
				#Ifnot;
				for (i=INPUT_BUFFER_LEN-1 : i>=w+x2 : i-- ) ! Note: don't close Include
					a_buffer-->i = a_buffer-->(i-x2+w2);
				#Endif;

				! ...increasing buffer size accordingly.
				#Iftrue CHARSIZE == 1;
				a_buffer->1 = (a_buffer->1) + (x2-w2);
				#Ifnot;
				a_buffer-->0 = (a_buffer-->0) + (x2-w2);
				#Endif;
			}

			! Write the correction in:
			#Iftrue CHARSIZE == 1;
			for (i=0 : i<x2 : i++) a_buffer->(i+w) = buffer2->(i+x1);
			#Ifnot;
			for (i=0 : i<x2 : i++) a_buffer-->(i+w) = buffer2-->(i+x1);
			#Endif;

			VM_Tokenise(a_buffer, a_table);
			#Iftrue CHARSIZE == 1;
			nw = a_table->1;
			#Ifnot;
			nw = a_table-->0;
			#Endif;

			return nw;
		}

		! Undo handling

		if ((w == UNDO1__WD or UNDO2__WD or UNDO3__WD) && (nw==1)) {
			if (FollowRulebook( (+ before undoing an action rules +) ) && RulebookFailed() ) { continue; }
			Perform_Undo();
			continue; ! if undo failed, get a new command
		}
		if ( (+ temporary undo suspension +) ) { return nw; }
		if ( (+ save undo state +) ) {
			i = VM_Save_Undo();
		}
		else { i = -2 };

		if (CommandParserKit`UNDO_PREVENTION_CFGF) undo_flag = 0;
		else undo_flag = 2;
		if (i == -1) undo_flag = 0; ! Undo not available
		if (i == 0) undo_flag = 1; ! Undo not available temporarily
		if (i == 2) {
			! We just came back from Undo.  Print some stuff, then get a new command.
			DealWithUndo();
			continue;
		}
		return nw;
	}
];

-) replacing "Keyboard".

Section - Replace DealWithUndo

Include (-
[ DealWithUndo;
  VM_RestoreWindowColours();
  if ( FollowRulebook( (+ report undoing an action rules +) ) && RulebookFailed())
  {
    VM_Style(SUBHEADER_VMSTY);
    SL_Location(); print "^";
    VM_Style(NORMAL_VMSTY);
    IMMEDIATELY_UNDO_RM('E'); new_line;
	}
	FollowRulebook( (+ after undoing an action rules +) );
];
-) replacing "DealWithUndo".

Part - ParserInput (for use with Unified Glulx Input by Andrew Plotkin)

Chapter - Patching ParserInput

Section - Patched ParserInput (in place of Section - ParserInput in Unified Glulx Input by Andrew Plotkin)

Include (-
! ParserInput: block and await acceptable input. Returns an event in a_event; tokenized line data will be in a_buffer and a_table.
! This is a wrapper around AwaitInput which adds "OOPS" and "UNDO" support -- features appropriate for the main parser input loop. It also permits the game to customize what kinds of input are accepted for that loop.
! This is called from Parser Letter A (primary command input) and NounDomain (disambig inputs).
! (Context-specific questions, such as YesOrNo and the end-game question, do not use this wrapper. They call AwaitInput directly.)
! In this function, unlike in AwaitInput, a_buffer and a_table are both mandatory. They may be either buffer/table (primary context) or buffer2/table2 (disambiguation context).
[ ParserInput  incontext a_event a_buffer a_table    evtyp nw i w w2 x1 x2 undoable;
	! Repeat loop until an acceptable input arrives.
	while (true) {
		! Save the start of the buffer, in case "oops" needs to restore it
		Memcpy(oops_workspace, a_buffer, 64);
		
		! Set up the input requests. (Normally just line input, but the game can customize this.)
		FollowRulebook((+ setting up input rules +), incontext, true);
		
		undoable = (+ setting-up-input-undoability-flag +);
		
		! The input deed itself.
		AwaitInput(incontext, a_event, a_buffer, a_table);
		! We have an input event now, but it could be any type. If it's line input, it's been tokenized.
		
		evtyp = a_event-->0;
		nw = 0;
		
		if (evtyp == evtype_LineInput) {
			! Set nw to the number of words
			nw = a_table-->0;
		}
		
		#ifndef PASS_BLANK_INPUT_LINES;
		! If the line was blank, get a fresh line.
		if (evtyp == evtype_LineInput && nw == 0) {
			! The old Keyboard routine cleared players_command here (to 100). I'm not sure why. If we're on buffer2/table2, the players_command snippet doesn't apply at all.
			EmptyInputParserError();
			continue;
		}
		#endif; ! PASS_BLANK_INPUT_LINES;
		
		! If this is line input, fetch the opening word.
		w = 0;
		if (evtyp == evtype_LineInput && nw > 0) {
			w = a_table-->1;
		}
		
		! Oops handling
		
		if (w == OOPS1__WD or OOPS2__WD or OOPS3_WD ) {
			if (oops_from == 0) { PARSER_COMMAND_INTERNAL_RM('A'); new_line; continue; }
			if (nw == 1) { PARSER_COMMAND_INTERNAL_RM('B'); new_line; continue; }
			if (nw > 2) { PARSER_COMMAND_INTERNAL_RM('C'); new_line; continue; }
		
			! So now we know: there was a previous mistake, and the player has
			! attempted to correct a single word of it.
		
			for (i=0 : i<INPUT_BUFFER_LEN : i++) buffer2->i = a_buffer->i;
			x1 = a_table-->6; ! Start of word following "oops"
			x2 = a_table-->5; ! Length of word following "oops"
		
			! Repair the buffer to the text that was in it before the "oops"
			! was typed:
			Memcpy(a_buffer, oops_workspace, 64);
			VM_Tokenise(a_buffer,a_table);
		
			! Work out the position in the buffer of the word to be corrected:
			w = a_table-->(3*oops_from);      ! Start of word to go
			w2 = a_table-->(3*oops_from - 1); ! Length of word to go
		
			! Write spaces over the word to be corrected:
			for (i=0 : i<w2 : i++) a_buffer->(i+w) = ' ';
		
			if (w2 < x2) {
				! If the replacement is longer than the original, move up...
				for ( i=INPUT_BUFFER_LEN-1 : i>=w+x2 : i-- )
					a_buffer->i = a_buffer->(i-x2+w2);
		
				! ...increasing buffer size accordingly.
				a_buffer-->0 = (a_buffer-->0) + (x2-w2);
			}
		
			! Write the correction in:
			for (i=0 : i<x2 : i++) a_buffer->(i+w) = buffer2->(i+x1);
		
			VM_Tokenise(a_buffer, a_table);
			nw = a_table-->0;
		
			return;
		}
		! Undo handling -- check whether we got an undo command, and then save a new undo point. But we only do these if the setting-up-input rules said this is an undoable input.
		if (undoable) {
			InputRDataInit( (+ checking undo input rules +), a_event, a_buffer, a_table);
			FollowRulebook((+ checking undo input rules +), incontext, true);
			InputRDataFinal();
			if (RulebookSucceeded()) {
				if (FollowRulebook( (+ before undoing an action rules +) ) && RulebookFailed())
					{ continue; }
				Perform_Undo();
				continue;
			}
			if ( (+ temporary undo suspension +) ) { return; }

			if ( (+ save undo state +) ) {
				i = VM_Save_Undo();
			}
			else { i = -2; }			

			if (KIT_CONFIGURATION_BITMAP & PREVENT_UNDO_TCBIT) undo_flag = 0;
			else undo_flag = 2;

			if (i == -1) undo_flag = 0;
			if (i == 0) undo_flag = 1;
			if (i == 2) {
				VM_RestoreWindowColours();
				if ( FollowRulebook( (+ report undoing an action rules +) ) && RulebookFailed())
				{  
					VM_Style(SUBHEADER_VMSTY);
					SL_Location(); print "^";
					! print (name) location, "^";
					VM_Style(NORMAL_VMSTY);
					IMMEDIATELY_UNDO_RM('E'); new_line;
				}
				FollowRulebook( (+ after undoing an action rules +) );
				continue;
			}
		}
		
		! Neither OOPS nor UNDO; we're done.
		return;
	}
];
-) replacing "ParserInput".


Undo Output Control ends here.


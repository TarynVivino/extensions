
Section 3 - I6T Hacking

[ We add a global variable that lets us disable the clarification flow. Otherwise, if we try to match an ambiguous object and the player answers the resulting question, we'll get a parser crash. ]

[ We expose this to Inform 7 in case someone wants to disable clarification at another time. ]
Disable clarification is a truth state that varies.
The disable clarification variable translates into I6 as "disable_clarification".

Include (-

Global matched_object;
Global disable_clarification;

-).

[ I got the inspiration/confidence to just flip out and replace a section of I6T to make minor changes from Subcommands by Daniel Stelzer. (https://github.com/i7/extensions/blob/master/Daniel%20Stelzer/Subcommands.i7x)

The only changes from Inform 7 build 10.1 are passing disable_clarification to the two calls to NounDomain. ]

Include (-
[ ParseToken__ given_ttype given_tdata token_n token
	l o i j k and_parity single_object desc_wn many_flag
	token_allows_multiple prev_indef_wanted;

@h Parse Token Letter A.
Analyse token; handle all not involving object lists, break down others.

=
	token_filter = 0;
	parser_inflection = name;

	switch (given_ttype) {
	ELEMENTARY_TT:
		switch (given_tdata) {
		SPECIAL_TOKEN:
			l = TryNumber(wn);
			special_word = NextWord();
			#Ifdef DEBUG;
			if (l ~= -1000)
				if (parser_trace >= 3) print "  [Read special as the number ", l, "]^";
			#Endif; ! DEBUG
			if (l == -1000) {
				#Ifdef DEBUG;
				if (parser_trace >= 3) print "  [Read special word at word number ", wn, "]^";
				#Endif; ! DEBUG
				l = special_word;
			}
			parsed_number = l;
			return GPR_NUMBER;

		NUMBER_TOKEN:
			l=TryNumber(wn++ );
			if (l == -1000) {
				etype = NUMBER_PE;
				return GPR_FAIL;
			}
			#Ifdef DEBUG;
			if (parser_trace>=3) print "  [Read number as ", l, "]^";
			#Endif; ! DEBUG
			parsed_number = l;
			return GPR_NUMBER;

		CREATURE_TOKEN:
			if (action_to_be == ##Answer or ##Ask or ##AskFor or ##Tell)
				scope_reason = TALKING_REASON;

		TOPIC_TOKEN:
			consult_from = wn;
			if ((line_ttype-->(token_n+1) ~= PREPOSITION_TT) &&
			(line_token-->(token_n+1) ~= ENDIT_TOKEN)) {
				RunTimeProblem(RTP_TEXTTOKENTOOHARD);
				return GPR_PREPOSITION;
			}
			do {
				o = NextWordStopped();
			} until (o == -1 || PrepositionChain(o, token_n+1) ~= -1);
			wn--;
			consult_words = wn-consult_from;
			if (consult_words == 0) return GPR_FAIL;
			if (action_to_be == ##Ask or ##Answer or ##Tell) {
				o = wn; wn = consult_from; parsed_number = NextWord();
				wn = o; return 1;
			}
			if (o==-1 && (line_ttype-->(token_n+1) == PREPOSITION_TT))
				return GPR_FAIL;    ! don't infer if required preposition is absent
			return GPR_PREPOSITION;
		}

	PREPOSITION_TT:
		#Ifdef DEBUG;
		if (parser_trace>=5) print "  [Preposition token]^";
		#Endif; ! DEBUG
		! Is it an unnecessary alternative preposition, when a previous choice
		! has already been matched?
		if ((token->0) & $10) return GPR_PREPOSITION;

		! If we've run out of the player's input, but still have parameters to
		! specify, we go into "infer" mode, remembering where we are and the
		! preposition we are inferring...

		if (wn > num_words) {
			if (inferfrom==0 && parameters<params_wanted) {
				inferfrom = pcount; inferword = token;
				pattern-->pcount = REPARSE_CODE + VM_DictionaryAddressToNumber(given_tdata);
			}

			! If we are not inferring, then the line is wrong...

			if (inferfrom == 0) return -1;

			! If not, then the line is right but we mark in the preposition...

			pattern-->pcount = REPARSE_CODE + VM_DictionaryAddressToNumber(given_tdata);
			return GPR_PREPOSITION;
		}

		o = NextWord();

		pattern-->pcount = REPARSE_CODE + VM_DictionaryAddressToNumber(o);

		! Whereas, if the player has typed something here, see if it is the
		! required preposition... if it's wrong, the line must be wrong,
		! but if it's right, the token is passed (jump to finish this token).

		if (o == given_tdata) return GPR_PREPOSITION;
		if (PrepositionChain(o, token_n) ~= -1) return GPR_PREPOSITION;
		return -1;

	GPR_TT:
		l = given_tdata();
		#Ifdef DEBUG;
		if (parser_trace >= 3) print "  [Outside parsing routine returned ", l, "]^";
		#Endif; ! DEBUG
		return l;

	SCOPE_TT:
		scope_token = given_tdata;
		scope_stage = 1;
		#Ifdef DEBUG;
		if (parser_trace >= 3) print "  [Scope routine called at stage 1]^";
		#Endif; ! DEBUG
		l = scope_token();
		#Ifdef DEBUG;
		if (parser_trace >= 3) print "  [Scope routine returned multiple-flag of ", l, "]^";
		#Endif; ! DEBUG
		if (l == 1) given_tdata = MULTI_TOKEN; else given_tdata = NOUN_TOKEN;

	ATTR_FILTER_TT:
		token_filter = 1 + given_tdata;
		given_tdata = NOUN_TOKEN;

	ROUTINE_FILTER_TT:
		token_filter = given_tdata;
		given_tdata = NOUN_TOKEN;

	} ! end of switch(given_ttype)

	token = given_tdata;

@h Parse Token Letter B.
Begin parsing an object list.

=
	! There are now three possible ways we can be here:
	!     parsing an elementary token other than "special" or "number";
	!     parsing a scope token;
	!     parsing a noun-filter token (either by routine or attribute).
	!
	! In each case, token holds the type of elementary parse to
	! perform in matching one or more objects, and
	! token_filter is 0 (default), an attribute + 1 for an attribute filter
	! or a routine address for a routine filter.

	token_allows_multiple = false;
	if (token == MULTI_TOKEN or MULTIHELD_TOKEN or MULTIEXCEPT_TOKEN or MULTIINSIDE_TOKEN)
		token_allows_multiple = true;

	many_flag = false; and_parity = true; dont_infer = false; dont_infer_pronoun = false;

@h Parse Token Letter C.
Parse descriptors (articles, pronouns, etc.) in the list.

=
	! We expect to find a list of objects next in what the player's typed.

.ObjectList;

	#Ifdef DEBUG;
	if (parser_trace >= 3) print "  [Object list from word ", wn, "]^";
	#Endif; ! DEBUG

	! Take an advance look at the next word: if it's "it" or "them", and these
	! are unset, set the appropriate error number and give up on the line
	! (if not, these are still parsed in the usual way - it is not assumed
	! that they still refer to something in scope)

	o = NextWord(); wn--;

	pronoun_word = NULL; pronoun_obj = NULL;
	l = PronounValue(o);
	if (l ~= 0) {
		pronoun_word = o; pronoun_obj = l;
		if (l == NULL) {
			! Don't assume this is a use of an unset pronoun until the
			! descriptors have been checked, because it might be an
			! article (or some such) instead

			for (l=1 : l<=LanguageDescriptors-->0 : l=l+4)
				if (o == LanguageDescriptors-->l) jump AssumeDescriptor;
			pronoun__word = pronoun_word; pronoun__obj = pronoun_obj;
			etype = VAGUE_PE;
			if (parser_trace >= 3) print "  [Stop: unset pronoun]^";
			return GPR_FAIL;
		}
	}

.AssumeDescriptor;

	if (o == ME1__WD or ME2__WD or ME3__WD) { pronoun_word = o; pronoun_obj = player; }

	allow_plurals = true; desc_wn = wn;

.TryAgain;

	! First, we parse any descriptive words (like "the", "five" or "every"):
	l = Descriptors(token_allows_multiple);
	if (l ~= 0) { etype = l; return 0; }

.TryAgain2;

@h Parse Token Letter D.
Parse an object name.

=
	! This is an actual specified object, and is therefore where a typing error
	! is most likely to occur, so we set:

	oops_from = wn;

	! So, two cases.  Case 1: token not equal to "held" (so, no implicit takes)
	! but we may well be dealing with multiple objects

	! In either case below we use NounDomain, giving it the token number as
	! context, and two places to look: among the actor's possessions, and in the
	! present location.  (Note that the order depends on which is likeliest.)

	if (token ~= HELD_TOKEN) {
		i = multiple_object-->0;
		#Ifdef DEBUG;
		if (parser_trace >= 3) print "  [Calling NounDomain on location and actor]^";
		#Endif; ! DEBUG
		l = NounDomain(actors_location, actor, token, disable_clarification);
		if (l == REPARSE_CODE) return l;                  ! Reparse after Q&A
		if (indef_wanted == INDEF_ALL_WANTED && l == 0 && number_matched == 0)
			l = 1;  ! ReviseMulti if TAKE ALL FROM empty container

		if (token_allows_multiple && ~~multiflag) {
			if (best_etype==MULTI_PE) best_etype=STUCK_PE;
			multiflag = true;
		}
		if (l == 0) {
			if (indef_possambig) {
				ResetDescriptors();
				wn = desc_wn;
				jump TryAgain2;
			}
			if (etype == MULTI_PE && multiflag) etype = STUCK_PE;
			etype=CantSee();
			jump FailToken;
		} ! Choose best error

		#Ifdef DEBUG;
		if (parser_trace >= 3) {
			if (l > 1) print "  [ND returned ", (the) l, "]^";
			else {
				print "  [ND appended to the multiple object list:^";
				k = multiple_object-->0;
				for (j=i+1 : j<=k : j++ )
					print "  Entry ", j, ": ", (The) multiple_object-->j,
						" (", multiple_object-->j, ")^";
				print "  List now has size ", k, "]^";
			}
		}
		#Endif; ! DEBUG

		if (l == 1) {
			if (~~many_flag) many_flag = true;
			else {                                ! Merge with earlier ones
				k = multiple_object-->0;            ! (with either parity)
				multiple_object-->0 = i;
				for (j=i+1 : j<=k : j++ ) {
					if (and_parity) MultiAdd(multiple_object-->j);
					else            MultiSub(multiple_object-->j);
				}
				#Ifdef DEBUG;
				if (parser_trace >= 3)
					print "  [Merging ", k-i, " new objects to the ", i, " old ones]^";
				#Endif; ! DEBUG
			}
		}
		else {
			! A single object was indeed found

			if (match_length == 0 && indef_possambig) {
				! So the answer had to be inferred from no textual data,
				! and we know that there was an ambiguity in the descriptor
				! stage (such as a word which could be a pronoun being
				! parsed as an article or possessive).  It's worth having
				! another go.

				ResetDescriptors();
				wn = desc_wn;
				jump TryAgain2;
			}

			if ((token == CREATURE_TOKEN) && (CreatureTest(l) == 0)) {
				etype = ANIMA_PE;
				jump FailToken;
			} !  Animation is required

			if (~~many_flag) single_object = l;
			else {
				if (and_parity) MultiAdd(l); else MultiSub(l);
				#Ifdef DEBUG;
				if (parser_trace >= 3) print "  [Combining ", (the) l, " with list]^";
				#Endif; ! DEBUG
			}
		}
	}

	else {

	! Case 2: token is "held" (which fortunately can't take multiple objects)
	! and may generate an implicit take

		l = NounDomain(actor,actors_location,token,disable_clarification); ! Same as above...
		if (l == REPARSE_CODE) return l;
		if (l == 0) {
			if (indef_possambig) {
				ResetDescriptors();
				wn = desc_wn;
				jump TryAgain2;
			}
			etype = CantSee(); jump FailToken;            ! Choose best error
		}

		! ...until it produces something not held by the actor.  Then an implicit
		! take must be tried.  If this is already happening anyway, things are too
		! confused and we have to give up (but saving the oops marker so as to get
		! it on the right word afterwards).
		! The point of this last rule is that a sequence like
		!
		!     > read newspaper
		!     (taking the newspaper first)
		!     The dwarf unexpectedly prevents you from taking the newspaper!
		!
		! should not be allowed to go into an infinite repeat - read becomes
		! take then read, but take has no effect, so read becomes take then read...
		! Anyway for now all we do is record the number of the object to take.

		o = parent(l);
		if (o ~= actor) {
			#Ifdef DEBUG;
			if (parser_trace >= 3) print "  [Allowing object ", (the) l, " for now]^";
			#Endif; ! DEBUG
		}
		single_object = l;
	} ! end of if (token ~= HELD_TOKEN) else

	! The following moves the word marker to just past the named object...

!	if (match_from ~= oops_from) print match_from, " vs ", oops_from, "^";

!    wn = oops_from + match_length;
	wn = match_from + match_length;

@h Parse Token Letter E.
Parse connectives (AND, BUT, etc.) and go back to (C).

=
	! Object(s) specified now: is that the end of the list, or have we reached
	! "and", "but" and so on?  If so, create a multiple-object list if we
	! haven't already (and are allowed to).

.NextInList;

	o = NextWord();

	if (o == AND1__WD or AND2__WD or AND3__WD or BUT1__WD or BUT2__WD or BUT3__WD or comma_word) {

		#Ifdef DEBUG;
		if (parser_trace >= 3) print "  [Read connective '", (address) o, "']^";
		#Endif; ! DEBUG

		if (~~token_allows_multiple) {
			if (multiflag) jump PassToken; ! give UPTO_PE error
			etype=MULTI_PE;
			jump FailToken;
		}

		if (o == BUT1__WD or BUT2__WD or BUT3__WD) and_parity = 1-and_parity;

		if (~~many_flag) {
			multiple_object-->0 = 1;
			multiple_object-->1 = single_object;
			many_flag = true;
			#Ifdef DEBUG;
			if (parser_trace >= 3) print "  [Making new list from ", (the) single_object, "]^";
			#Endif; ! DEBUG
		}
		dont_infer = true; dont_infer_pronoun = false; inferfrom=0; ! Don't print (inferences)
		jump ObjectList; ! And back around
	}

	wn--;   ! Word marker back to first not-understood word

@h Parse Token Letter F.
Return the conclusion of parsing an object list.

=
	! Happy or unhappy endings:

.PassToken;
	if (many_flag) {
		single_object = GPR_MULTIPLE;
		multi_context = token;
	}
	else {
		if (indef_mode == 1 && indef_type & PLURAL_BIT ~= 0) {
			if (token == MULTIEXCEPT_TOKEN or MULTIINSIDE_TOKEN) multi_context = token;
			if (indef_wanted < INDEF_ALL_WANTED && indef_wanted > 1) {
				multi_had = 1; multi_wanted = indef_wanted;
				#Ifdef DEBUG;
				if (parser_trace >= 4) print "Too few found at letter F^";
				#Endif; ! DEBUG
			jump FailToken;
			}
		}
	}
	return single_object;

.FailToken;

	! If we were only guessing about it being a plural, try again but only
	! allowing singulars (so that words like "six" are not swallowed up as
	! Descriptors)

	if (allow_plurals && indef_guess_p == 1) {
		#Ifdef DEBUG;
		if (parser_trace >= 4) print "   [Retrying singulars after failure ", etype, "]^";
		#Endif;
		prev_indef_wanted = indef_wanted;
		allow_plurals = false;
		wn = desc_wn;
		jump TryAgain;
	}

	if ((indef_wanted > 0 || prev_indef_wanted > 0) && (~~multiflag)) etype = MULTI_PE;

	return GPR_FAIL;

]; ! end of ParseToken__
-) replacing "ParseToken__";

Object Matching ends here.

---- DOCUMENTATION ----

This extension provides support for getting the matched object when matching a snippet against a pattern and for disabling clarification when a command or snippet is ambiguous.

Disambiguation Override by Mike Ciul provides similar functionality with more options, however, it doesn't seem compatible with recent Inform 7.

Chapter 1 - Object Matching

This extension provides one main construct. You can use "if (snippet) object-matches (topic)" in the same way as you use the standard Inform "if (snippet) matches (topic)". The difference is that, if the condition is true, the following code can refer to "the matched object". For example,

	if S object-matches "[any thing]":
		say "You sense that that is in [the location of the matched object]."

This is mainly useful for making overly-clever error messages without affecting the parsing of normal commands; for non-error situations you're probably better off using normal understand-based parsing.

Chapter 2 - Disabling Clarification

This extension internally disables clarification while object-matching both because it doesn't make sense and also because it doesn't work and crashes the interpreter. If the snippet matches more than one thing equally well, Inform will pick one arbitrarily instead of asking for clarification.

If you want to disable clarification in some other situation, you can do so with:
	
	Now disable clarification is true.

Note that this will last until you do "now disable clarification is false".

Section 1 - Known Issues

Something in the current multiple object list won't match as a "[thing]" or similar.


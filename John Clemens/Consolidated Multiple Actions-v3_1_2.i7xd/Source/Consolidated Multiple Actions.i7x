Version 3.1.2 of Consolidated Multiple Actions (for Glulx only) by John Clemens begins here.

"An extension to consolidate action reports when performing an action on multiple objects, such as with 'take all'. Requires Hypothetical Questions by Jesse McGrew."

Include Hypothetical Questions by Tara McGrew.

Use strict action consolidation checking translates as a configuration flag.
Use consolidated multiple actions debugging translates as the configuration flag CMA_DEBUG_FLAG_CFGF.

Consolidated multiple actions is a rulebook.

Include (-
[ GENERATE_ACTION_R i;
	if (EarlyInTurnSequence == false) rfalse; ! Prevent use outside top level
	EarlyInTurnSequence = false;

	action = parser_results-->ACTION_PRES;
	act_requester = nothing; if (actor ~= player) act_requester = player;

	inp1 = 0; inp2 = 0; multiflag = false;
	if (parser_results-->NO_INPS_PRES >= 1) {
		inp1 = parser_results-->INP1_PRES; if (inp1 == 0) multiflag = true;
	}
	if (parser_results-->NO_INPS_PRES >= 2) {
		inp2 = parser_results-->INP2_PRES; if (inp2 == 0) multiflag = true;
	}

	if (inp1 == 1) noun = nothing; else noun = inp1;
	if (inp2 == 1) second = nothing; else second = inp2;

	if (multiflag) {
		if (multiple_object-->0 == 0) {
			if (actor == player) { GENERATE_ACTION_RM('B'); new_line; }
			return;
		}
		if (toomany_flag) {
			toomany_flag = false;
			if (actor == player) { GENERATE_ACTION_RM('A'); }
		}
		i = multiple_object-->0;
		FollowRulebook(MULTIPLE_ACTION_PROCESSING_RB);
		if ((multiple_object-->0 == 1) && (i > 1)) {
			multiflag = false;
			if (inp1 == 0) noun = multiple_object-->1;
			if ((inp2 == 0) && (parser_results-->NO_INPS_PRES >= 2))
				second = multiple_object-->1;
		}
		if (multiple_object-->0 == 0) rfalse;
	}

	if (multiflag) {
!print "multiflag still true, generating multiple actions^";
print "following CMA^";
    FollowRulebook( (+ consolidated multiple actions rules +));
print "back from CMA^";
		if (multiple_object-->0 > 0) GenerateMultipleActions();
		multiflag = false;
	} else BeginAction(action, noun, second);

	if ((actor ~= player) || (act_requester)) action = ##Wait;
	actor = player; act_requester = 0;

	if (meta) { RulebookSucceeds(); rtrue; }
	rfalse;
];
-) replacing "GENERATE_ACTION_R"


[ GenerateMultipleActions initial_location k item;
	initial_location = location;
	for (k=1: k<=multiple_object-->0: k++) {
		item = multiple_object-->k;
		RunParagraphOn();
		if (inp1 == 0) { inp1 = item; BeginAction(action, item, second, item); inp1 = 0; }
		else { inp2 = item; BeginAction(action, noun, item, item); inp2 = 0; }
		if (deadflag) return;
		if (location ~= initial_location) {
			if (player == actor) { ACTION_PROCESSING_INTERNAL_RM('J'); new_line; }
			return;
		}
	}
];

A consolidated multiple actions rule (this is the consolidate multiple actions rule):
	truncate the consolidated objects list to 0 entries;
	truncate the noteworthy objects list to 0 entries;
	carry out the modifying the multiple object list activity;
	let L be the multiple object list;
	let F be a list of objects;
	repeat with x running through L:
		now the noun is x;
		issue CMA debugging message "noun is [x].";        
		hypothetically test the proposed action and consider the action consolidation results rulebook;
		if the outcome of the rulebook is:
			-- standard outcome: add x to the consolidated objects list;
				issue CMA debugging message "standard";
				silently try the current action;
			-- noteworthy outcome: add x to the noteworthy objects list;
				issue CMA debugging message "noteworthy";
			-- failed outcome: add x to F;
				issue CMA debugging message "failed";
		issue CMA debugging message "none of the above?";                
	add the noteworthy objects list to F;
	alter the multiple object list to F;
	if the number of entries of the consolidated objects list is greater than 0:
		carry out the reporting consolidated actions activity;
		if a paragraph break is pending, say conditional paragraph break;
	now the number of multiple actions so far this turn is 0.

The consolidated objects list is a list of objects that varies.
The noteworthy objects list is a list of objects that varies.

The action_success_flag is a truth state variable.
The hypothetical_test_flag is a truth state variable.
The noteworthy_consolidation_flag is a truth state variable.

To indicate noteworthy consolidation: now the noteworthy_consolidation_flag is true.

[We need the following because even though an NPC's action may fail, the asking action can succeed]
First unsuccessful attempt by someone doing something when the hypothetical_test_flag is true (this is the catch failure of actions by others rule): now the action_success_flag is false.

Action consolidation results rules is a rulebook.
The action consolidation results rulebook has outcomes standard, failed, and noteworthy.

Last action consolidation results rule (this is the standard action consolidation results rule):
	if the noteworthy_consolidation_flag is true, noteworthy;
	if the action_success_flag is true:
		let H be "[the hypothetical output]";
		unless the strict action consolidation checking option is active:
			replace the regular expression "\[bracket](<^\[bracket]\[close bracket]>)*\[close bracket]" in H with "";
			replace the regular expression "\((<^\(\)>)*\)" in H with "";
		if H exactly matches the regular expression "\s*", standard;
		noteworthy;
	failed.

Section 2a - cma rule utility functions - unindexed

To test the proposed action:
	now the noteworthy_consolidation_flag is false;
	now the action_success_flag is true;
	now the hypothetical_test_flag is true;
	silently try the current action;
	unless the rule succeeded, now the action_success_flag is false;
	now the hypothetical_test_flag is false.

To issue CMA debugging message (T - text): (- CMADebug({T}); -).

Include (-
[ CMADebug ro;
	#ifdef CMA_DEBUG_FLAG_CFGF;
!	if ((trace_actions) && (FindAction(-1))) {
		print "[testing consolidation for "; 
		DB_Action(actor,act_requester,action,noun,second);
print " - ";
if (latest_rule_result-->0 == RS_SUCCEEDS) print "success";
else if (latest_rule_result-->0 == RS_FAILS) print "failure";
else print "no outcome^";
ClearParagraphing();
!	}
	#endif;
	rtrue;
];
-).

Section 3 -Reporting consolidated actions

Reporting consolidated actions is an activity.

Last for reporting consolidated actions rule when taking (this is the standard consolidated report taking rule): say "You pick up [consolidated objects]."
Last for reporting consolidated actions rule when asking someone to try taking (this is the standard consolidated report taking by others rule): say "[The person asked] picks up [consolidated objects]."

Last for reporting consolidated actions rule when dropping (this is the standard consolidated report dropping rule): say "You put down [consolidated objects]."
Last for reporting consolidated actions rule when asking someone to try dropping (this is the standard consolidated report dropping by others rule): say "[The person asked] puts down [consolidated objects]."

Last for reporting consolidated actions rule when removing from (this is the standard consolidated report removing from rule): say "You pick up [consolidated objects]."
Last for reporting consolidated actions rule when asking someone to try removing from (this is the standard consolidated report removing from by others rule): say "[The person asked] picks up [consolidated objects]."

Last for reporting consolidated actions rule when putting on (this is the standard consolidated report putting on rule): say "You put [consolidated objects] on [the second noun]."
Last for reporting consolidated actions rule when asking someone to try putting on (this is the standard consolidated report putting on by others rule): say "[The person asked] puts [consolidated objects] on [the second noun]."

Last for reporting consolidated actions rule when inserting into (this is the standard consolidated report inserting into rule): say "You put [consolidated objects] into [the second noun]."
Last for reporting consolidated actions rule when asking someone to try inserting into (this is the standard consolidated report inserting into by others rule): say "[The person asked] puts [consolidated objects] into [the second noun]."

Section 4 - Printing consolidated objects

[We make this into an activity so that we can write use it in other conditions, such as name printing.]

To say consolidated objects: carry out the printing consolidated objects activity.

Printing consolidated objects is an activity.

[We use the list-writer to print the consolidated objects list so that multiple objects of a kind are grouped together, and to allow the grouping together activity to be used. The complication is that we want to try to keep the order of the printed list the same as the order in which the actions occurred (as much as possible) and be somewhat efficient, so we add a new list-writing function.]

Last for printing consolidated objects rule (this is the grouped listing of consolidated objects rule): say the grouped consolidated objects list.

To say the grouped (L - a list of objects):
	list the elements of L, as a sentence, using the definite article.

To say The grouped (L - a list of objects):
	list the elements of L, as a sentence, using the definite article, with capitalized first article.
[ reportedly "The grouped" doesn't work properly on PPC, but I (ZL) don't think it matters at this late date ]

To say The capitalized grouped (L - a list of objects): 
	list the elements of L, as a sentence, using the definite article, with capitalized first article.

[
Include (-
[ LT_Compare lt1 lt2;
	if (lt1 == lt2) return 0;
	if (lt1 == 0) lt1 = EMPTY_TEXT_VALUE;
	if (lt2 == 0) lt2 = EMPTY_TEXT_VALUE;
!print "^lt1: ";
!Glulx_PrintAnything(lt1);
!if (TEXT_TY_IsSubstituted(lt1) == false) print " un";
!print "substituted.";
!print "^lt2: ";
!Glulx_PrintAnything(lt2);
!if (TEXT_TY_IsSubstituted(lt2) == false) print " un";
!print "substituted.";
!print "", (lt1-->1)-(lt2-->1);
!print "^";

	if (TEXT_TY_IsSubstituted(lt1) == false) {
		if (TEXT_TY_IsSubstituted(lt2) == false) return (lt1-->1)-(lt2-->1);
		return -1;
	}
	if (TEXT_TY_IsSubstituted(lt2) == false) {
		return -1;
	}
print "blkvaluecompare^";
	return BlkValueCompare(lt1, lt2);
];
-) replacing "LT_Compare".
]


To list the elements of (L - a list of objects), with newlines, indented, giving inventory information, as a sentence, including contents, including all contents, tersely, giving brief inventory information, using the definite article, listing marked items only, prefacing with is/are, not listing concealed items, suppressing all articles, with extra indentation and/or with capitalized first article:(- WriteGroupedList({-by-reference:L}, {phrase options}); -). 

Include (-
[ WriteGroupedList list xstyle 
	i obj first length; 

	if ((list==0) || (BlkValueWeakKind(list) ~= LIST_OF_TY)) return; 
	length = BlkValueRead(list, LIST_LENGTH_F); 

	if (length == 0) print "nothing";
	else { 
		@push MarkedObjectArray; @push MarkedObjectLength; 
		MarkedObjectArray = RequisitionStack(length); 
		MarkedObjectLength = length; 
		if (MarkedObjectArray == 0) return IssueRTP("ListWriterRanOutOfMemory");
		
		for (i=0:i<length :i++ ) { 
			obj = BlkValueRead(list, i+LIST_ITEM_BASE); 
			if (first == nothing) first = obj;
			MarkedObjectArray-->i = obj; 
		}

		WriteListFrom(first, xstyle, 0, false, MarkedListIterator); 
		FreeStack(MarkedObjectArray); 
		@pull MarkedObjectLength; @pull MarkedObjectArray; 
	} 
];
-).

Section 5 - Announcing multiple occurrences

[We spin this off into an activity to make it easier to vary.]

The number of multiple actions so far this turn is a number variable. [This can be tested in an announcing rule to vary the announcement for successive actions.]

The new announce items from multiple object lists rule is listed instead of the announce items from multiple object lists rule in the action-processing rules.

This is the new announce items from multiple object lists rule:
	if the current item from the multiple object list is not nothing, carry out the announcing a multiple occurrence activity with the current item from the multiple object list.

Announcing a multiple occurrence of something is an activity.

The last for announcing a multiple occurrence rule for something (called the object in question) (this is the standard multiple object announcement rule): if the object in question is not listed in the noteworthy objects list, say "[object in question]: [run paragraph on]".

First before announcing a multiple occurrence rule (this is the keep track of number of actions so far rule): increase the number of multiple actions so far this turn by 1.

Section 6 - Recognizing "them" as a list in input

[We don't want to interfere with the normal use of "them" to refer to a plural-named thing, so we go through the usual pronouns mechanism with a placeholder object.]

The stored consolidated objects is a list of objects that varies.
	
After printing consolidated objects (this is the update the pronoun them to consolidated objects rule): set pronouns from the consolidated objects list.
	
After reading a command when them refers to a list (this is the replace them by stored consolidated objects rule):
	let N be the substituted form of "[ the player's command ]";
	let Y be the substituted form of "[stored consolidated objects]";
	replace the regular expression "\bthem\b" in N with "[Y]";
	change the text of the player's command to N.

To set pronouns from (L - a list of objects):
	[We should be careful not to run this on a list which contains only a single object which is repeated multiple times, but the lists produced from the multiple objects list are okay.]
	if the number of entries of L is 1, set pronouns from entry 1 of L;
	if the number of entries of L is at least 2:
		now stored consolidated objects is L;
		set pronouns from the pronoun_them_placeholder.

To decide if them refers to a list: (- TestThemPlaceholder() -).

Section modifying the multiple object list

The multi-object list is a list of objects variable.
Modifying the multiple object list is an activity.

First before modifying the multiple object list: now the multi-object list is the multiple object list; 

Last after modifying the multiple object list: alter the multiple object list to the multi-object list.

Section 6a - them utility functions - unindexed

The pronoun_them_placeholder is a privately-named plural-named proper-named thing.
Rule for printing the name of the pronoun_them_placeholder: say the grouped stored consolidated objects.

Include (- [ TestThemPlaceholder ; return (LanguagePronouns-->12 == (+pronoun_them_placeholder+)); ]; -).
[This needs to be reworked to localize more easily.]


Consolidated Multiple Actions ends here.


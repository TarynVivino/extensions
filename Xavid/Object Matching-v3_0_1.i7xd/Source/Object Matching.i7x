Version 3.0.1 of Object Matching by Xavid begins here.

"Support for getting the matched object when matching a snippet against a pattern and for disabling clarification when a command or snippet is ambiguous."

"Updated for 11.0 by Zed Lopez"

Use authorial modesty.

Section 1 - Getting an object out of a matched snippet

Include (-
Global matched_object;
-)

The matched object is an object that varies.
The matched object variable translates into I6 as "matched_object".

To decide if (S - a snippet) object-matches (T - a topic): (- SnippetMatchesObject({S}, {T}) -)

Include (-

[ SnippetMatchesObject snippet topic_gpr rv ;
	! Without this, SnippetMatchesObject sometimes causes a spurious newline to get printed, for example if the text starts with something that matches something dynamically. (E.g., Understand "fire/smoke" as something flaming.)
	RunParagraphOn();
	matched_object=nothing;
	wn=1;
	if (topic_gpr == 0) rfalse;
	if (metaclass(topic_gpr) == Routine) {
        @push dont_ask_for_clarification;
        @push etype;
		dont_ask_for_clarification = true;
		rv = (topic_gpr)(snippet/100, snippet%100);
        @pull etype;
        @pull dont_ask_for_clarification;
		matched_object = rv;
		if (rv ~= GPR_FAIL) rtrue;
		rfalse;
	}
	IssueRTP("MatchedAgainstNonTopic");
	rfalse;
];

-).

Section 2 - Getting an object out of a nounlike snippet

[ This version doesn't take a topic, so it's less flexible, but it works even in error or multi-object cases where the above does not. ]

To decide if (S - a snippet) matches a noun: (- SnippetIsNoun({S}) -)

Include (-

[ SnippetIsNoun snippet rv;
    @push wn;
    @push num_words;
	wn = snippet / 100;
	num_words = (snippet % 100) + wn - 1;
	rv = NounDomain(actors_location, actor, NOUN_TOKEN, true);
    @pull num_words;
    @pull wn;
	if (rv == REPARSE_CODE || rv == 0 || rv == 1) rfalse;
	matched_object = rv;
	rtrue;
];

-).

deactivate clarification is a truth state that varies.
The deactivate clarification variable translates into I6 as "dont_ask_for_clarification".

Object Matching ends here.

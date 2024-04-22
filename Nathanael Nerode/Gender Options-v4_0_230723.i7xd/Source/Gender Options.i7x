Version 4.0.230723 of Gender Options by Nathanael Nerode begins here.

"More broad-minded English language gender/number model where male, female, and neuter are three separate true-false properties.  Allows for objects to respond to any specified combination of HE, SHE, IT, and THEY.  As fast as the Standard Rules.  Tested with Inform v10.1.0."

[We replace very, very specific bits of the standard rules. This is based on Inform v10.1.0]

Include Standard Rules by Graham Nelson.

Volume - Enhanced Gender and Number Model

[Make male, female, and neuter independent.]

Chapter - Replace Standard Rules Elements Always

Section 11 - People and things with gender (in place of Section 11 - People in Standard Rules by Graham Nelson)

[These must overrride all other definitions.]
A thing can be neuter.  A thing is usually neuter.
A thing can be male.  A thing is usually not male.
A thing can be female.  A thing is usually not female.

[Ambiguously plural is defined in Basic Inform.  It isn't fully implemented, however.  It allows for "ambiguously plural" nouns like "a pair of shoes".  We need this line but it's in Basic Inform.i7x so we don't need it here:]
[An object can be ambiguously plural.]

[Beginning of text from original Section 11.]

The specification of person is "Despite the name, not necessarily
a human being, but anything animate enough to envisage having a
conversation with, or bartering with."

A person has a number called carrying capacity.
The carrying capacity of a person is usually 100.

[Standard Rules says "A person is always transparent", which is an unnecessary restriction on the story writer.]
A person can be transparent.  A person is usually transparent.

The yourself is an undescribed person. The yourself is proper-named.

The yourself is privately-named.
Understand "your former self" or "my former self" or "former self" or "former" as yourself when the player is not yourself.

The yourself object translates into Inter as "selfobj".

Section SR2.3.11A - Assumptions about people

[This section is separated out in case someone wants to replace it.  Sadly, Section is the smallest heading, so we can't embed this into the existing structure]

A person is usually not neuter.

A person is usually female.
A person is usually male.
[* This is less weird than it appears.  If you make a generic, unnamed person, the player can refer to said person as "him" or "her", interchangably.]

Section 12 - Animals, men and women revised (in place of Section 12 - Animals, men and women in Standard Rules by Graham Nelson)

The plural of man is men. The plural of woman is women.

A man is a kind of person.
The specification of man is "Represents a man or boy."
A man is usually male.
A man is usually not female.
A man is usually not neuter.

A woman is a kind of person.
The specification of woman is "Represents a woman or girl."
A woman is usually female.
A woman is usually not male.
A woman is usually not neuter.

An animal is a kind of person.
An animal is usually not male.
An animal is usually not female.
An animal is usually neuter.
[By default, refer to an animal as "it".]

The specification of animal is "Represents an animal, or at any rate a
non-human living creature reasonably large and possible to interact with: a
giant Venus fly-trap might qualify, but not a patch of lichen."

Section SR2.3.12A  - Inform 6 equivalent for male

[This saves a property since Inform 6 already has an unused male property.  This is actually only *required* for compatibility with Original Parser, which uses the term 'linguistically male' for what has to be the same property.  Several other properties must also have Inter translations but the ones in Standard Rules will do fine for our purposes.]
The male property translates into Inter as "male".

Chapter - Yourself Description - Standard

Section SR2.3.11B - Yourself Description 

[ this is (for use without Neutral Standard Responses by Nathanael Nerode) ]

The description of yourself is usually "As good-looking as ever."

Chapter - Yourself Description (for use with Neutral Standard Responses by Nathanael Nerode)

[We do it this way so that we can handle other extensions which interfere with the same text in the same way.  Which is likely.]

Section SR2.3.11B - Deleted Yourself Description (in place of Section SR2.3.11B - Yourself Description in Gender Options by Nathanael Nerode)

[ We don't need to give a description, because Neutral Standard Responses does. ]
[ In Inform version 6M62 (9.3) and earlier, there must be something, not a comment, in every section or bug 0001841 causes a compiler crash.  This is the smallest possible dummy we can create, occupying between 1 bit and 1 byte.  this is unnecessary in Inform v10.]
[ dummy_variable_1234567890 is a truth state that varies. ]

Volume - Parser Modifications for Pronoun Handling

[Make pronouns behave properly.]

Part - Universal Fix

Chapter - Fix Pronoun Bitmask Table

[Aw heck.  After all that work below it turns out there's a conceptual error in the bitmask table --
it thinks all inanimate objects are neuter.  Drop down to I6 and fix it.  There may be a cleaner
method, but this is the least invasive, unbelievably.]

Include (-

! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====
! Gender Options replacement for Language.i6t: Pronouns (from EnglishLanguageKit)
! ==== ==== ==== ==== ==== ==== ==== ==== ==== ====

Array LanguagePronouns table

  ! word        possible GNAs                   connected
  !             to follow:                      to:
  !             a     i
  !             s  p  s  p
  !             mfnmfnmfnmfn

    'it'      $$001000001000                    NULL
    'him'     $$100000100000                    NULL
    'her'     $$010000010000                    NULL
    'them'    $$000111000111                    NULL;

-) replacing "LanguagePronouns".

Part - Core i6 Parser Fix (for use without Original Parser by Ron Newcomb)

Chapter - Revisions Not Made

[Oddly, it turns out we don't need to alter the Gender section of the parser, which defines GetGender and GetGNAOfObject.

We could and should remove GetGender, which will give bad info.  It is dead code.

GetGNAOfObject is used in four places: two in ListWriter.i6t, and one each in Printing.i6t and Parser.i6t.

ListWriter applies GetGNAOfObject mod 3 to track prior_named_list_gender, but prior_named_list_gender is a write-only variable (dead code).

Printing uses GetGNAOfObject, then applies LanguageGNAsToArticles, which strips out the gender and gives only the plural status.
This is used only to match articles (the / an / some), so it checks only for pluralname, not for ambigpluralname, which is correct.
(An ambiguous plural name like 'pair of shoes' should have a 'the'/'an'.)

ListWriter applies (GetGNAOfObject mod 6 / 3) in PNToVP, which is called by the autogenerated verb conjugation code.  It's only checking for plurals, again.  This could be patched.
There is a suggestion to patch it to allow for "singular they".  "The shadowy figure lurks; they look angry."

Parser only uses GetGNAOfObject in 'best guess', which is a 1 point disambiguator and not very important.
It does unfortunately check gender, using the old method.
We could fix it by replacing the ENTIRE ScoreMatchL section of the parser, but it's not worth the sheer level of invasiveness.

To work with foreign languages which have gendered plurals, it would be necessary to:
(a) use GetGNABitfield in Parser
(b) rewrite GetGNAOfObject to check the preferred printing genders for the other calls.

Summary: new code should not use GetGender or GetGNAOfObject, but we don't need to edit the old code.
]

Chapter - Pronoun Handling Revised

[The change to PronounNotice should actually work for all languages and new pronouns;
but a new language or new pronouns would require a different GetGNABitfield implementation. ]

Section - SetProunoun bugfix

[ SetPronoun is obsolete but we fix its runtime error number anyway, since it should be fixed ]

Include (-
[ SetPronoun dword value x;
    for (x=1 : x<=LanguagePronouns-->0 : x=x+3)
        if (LanguagePronouns-->x == dword) {
            LanguagePronouns-->(x+2) = value; return;
        }
    RunTimeError(12);
];
-) replacing "SetPronoun".

Section - GetGNABitfield

[This is the primary logic change, allowing male, female, and neuter to be three separate bits, properly.]

[This is harder than it should be because the (+ +) notation completely stopped working in Inform 10.
Thankfully, we have named I6/Inter attributes for everything (from Definitions.i6t in the BasicInformKit).
Some of the Inter translations are specified in Standard Rules; "male" is specified earlier in this file.]

Include (-
[ GetGNABitfield obj g gn;
	! First calculate three-bit gender field
	g = 0;
	if ( obj has neuter ) {
		g = g + 1;	! bit position 0
		}
	if ( obj has female ) {
		g = g + 2;	! bit position 1
		}
	if ( obj has male ) {
		g = g + 4;	! bit position 2
		}
	gn = 0;
	if ( obj has ambigpluralname  ) {
		gn = g * 9;	 ! plural in low significant digits, plus singular shifted three to the left
	} else if ( obj has pluralname ) {
		gn = gn + g;	! plural is in low significant digits
	} else {	! obj is singular-named
		gn = gn + g * 8;	! singular is shifted 3 to the left
	}
	if ( obj has animate ) {
		return gn * 64;	! shift 6 to the left for animate objects
		}
	return gn;	! shift 0
];
-)

Section - PronounNotice

[Replace GetGNAOfObject call with GetGNABitfield call.  This is the main hook.]
[ This replaces a routine in CommandParserKit in Parser.i6t.]

Include (-
[ PronounNotice obj x bm;
    if (obj == player) return;

    bm = GetGNABitfield(obj);  ! This is the change made by Gender Options by Nathanael Nerode.

    for (x=1 : x<=LanguagePronouns-->0 : x=x+3)
        if (bm & (LanguagePronouns-->(x+1)) ~= 0)
            LanguagePronouns-->(x+2) = obj;
];
-) replacing "PronounNotice".

Section - Unset pronouns from

[Per default, if you are changing the gender of characters, it doesn't change any pronoun referents already set.  So if "him" is referring to Ned, and Ned stops being male, "him" will continue to refer to Ned until the player looks at another male character.  Under some circumstances, this satisfies "principle of least surprise" -- but under others it doesn't.  If you want to make sure that Ned is no longer referred to as him, "unset pronouns from Ned". ]

Include (-
[ PronounUnNotice obj x bm;
    if (obj == player) return;

    bm = GetGNABitfield(obj);
    for (x=1 : x < (LanguagePronouns-->0 - 2) : x=x+3)
        if ((bm & (LanguagePronouns-->(x+1)) == 0) && (LanguagePronouns-->(x+2) == obj))
            LanguagePronouns-->(x+2) = NULL;
];
-)

to unset pronouns from (O - an object):
	(- PronounUnNotice({O}); -)


Part - Original Parser Fix (for use with Original Parser by Ron Newcomb)

Chapter - Pronoun Handling Revised ( in place of Chapter - Pronoun Handling in Original Parser by Ron Newcomb )

[Most of this is the same as in the original.  However, "To decide which word usage is the gender-animation usages for " is *completely* different.]

[To reset vague words with (obj - an object) (this is ResetVagueWords): set pronouns from the obj.]

To change (pronoun - an understood word) to (obj - an object) (this is SetPronoun):
	if the pronoun is listed as one of the pronouns in the language's pronoun list:
		now chosen antecedent element is obj;
		stop;
	issue the 14th run-time message "** Library error 14 (0,0) **[line break]** (unexplained) **[line break]".

[ Returns 'nothing' if the inputted word isn't one of the four pronouns.  Returns the 'used-up object' (NULL) if it's an unset pronoun. ]
To decide which object is what (pronoun - an understood word) stands for (this is PronounValue):
	if the pronoun is listed as one of the pronouns in the language's pronoun list:
		decide on the antecedent element.

[We're handling the gender rules differently from standard Inform and differently from Ron's extension.

The key is that an object can have multiple gender matches and multiple singular/plural matches, and they're all handled correctly.

In Original Parser, the GNA/ grammatical case should be a separate type from the word usage, but it isn't.  Yet. 

This is a super-tedious way of dealing with the translation between I7 and I6 without fighting too much with I7's type system.  It cannot possibly be efficient.

The acronyms stand for:
"Animate" or "Inanimate"
"Singular" or "Plural"
"Male", "Female", or "Neuter"
]
To decide what word usage is
	the empty bitfield:	(- $$000000000000 -).
To decide what word usage is 
	_a_s_m: (- $$100000000000 -).
To decide what word usage is
	_a_s_f: (- $$010000000000 -).
To decide what word usage is
	_a_s_n: (- $$001000000000 -).
To decide what word usage is 
	_a_p_m: (- $$000100000000 -).
To decide what word usage is 
	_a_p_f: (- $$000010000000 -).
To decide what word usage is 
	_a_p_n: (- $$000001000000 -).
To decide what word usage is 
	_i_s_m:	(- $$000000100000 -).
To decide what word usage is 
	_i_s_f:	(- $$000000010000 -).
To decide what word usage is 
	_i_s_n: (- $$000000001000 -).
To decide what word usage is 
	_i_p_m: (- $$000000000100 -).
To decide what word usage is 
	_i_p_f: (- $$000000000010 -).
To decide what word usage is 
	_i_p_n:	(- $$000000000001 -).

[This pulls up the matching pronoun types for an object.

It has been modified to account for ambiguously plural objects and multi-gendered things and people.

Note: the animate-handling is wrong; it makes it hard to call a ship "her".]
	
To decide which word usage is the gender-animation usages for (obj - object):
	Let GNAbits be a word usage;
	Let GNAbits be the empty bitfield;
	Let animated be a truth state;
	if obj is a person:
		now animated is true;
	otherwise:
		now animated is false;
	if animated is true:
		if obj is singular-named or obj is ambiguously plural:
			if obj is male, include _a_s_m in GNAbits;
			if obj is female, include _a_s_f in GNAbits;
			if obj is neuter, include _a_s_n in GNAbits;
		if obj is plural-named or obj is ambiguously plural:
			if obj is male, include _a_p_m in GNAbits;
			if obj is female, include _a_p_f in GNAbits;
			if obj is neuter, include _a_p_n in GNAbits;
	otherwise:
		if obj is singular-named or obj is ambiguously plural:
			if obj is male, include _i_s_m in GNAbits;
			if obj is female, include _i_s_f in GNAbits;
			if obj is neuter, include _i_s_n in GNAbits;
		if obj is plural-named or obj is ambiguously plural:
			if obj is male, include _i_p_m in GNAbits;
			if obj is female, include _i_p_f in GNAbits;
			if obj is neuter, include _i_p_n in GNAbits;
	decide on GNAbits.
	
[This will correctly match if you give it a combination of multiple pronoun options.  Test this with androgynes and ambiguously plural nouns.]

[This eliminates the use of GetGNAOfObject in the parser, but unfortunately it's still used in an exported capacity by Language.i6t.]

To set pronouns from (obj - an object) (this is PronounNotice):
	if the obj is the player, stop;  [ even in 3rd person, the player wouldn't refer to his avatar as him/her. ]
	repeat through all three columns of the language's pronoun list:
		if the gender-animation element includes any of the gender-animation usages for the obj:
			now chosen antecedent element is obj.

Chapter - English Pronoun Names For I7

[This allows statements like "now 'he' is Alan".  Poorly tested.]

To decide what understood word is 'he': (- 'he' -).
To decide what understood word is 'she': (- 'she' -).
To decide what understood word is 'it': (- 'it' -).
To decide what understood word is 'them': (- 'them' -).

Volume - English Language (for use with English Language by Graham Nelson)

[It proved necessary to replace practically the entire extension. Modal verbs and contractions and Grammatical definitions are unchanged.]

Section 1 - Preferred Gender

Prefer neuter gender is a truth state that varies.
Prefer neuter gender is usually true.
The preferred animate gender is a grammatical gender which varies.
The preferred animate gender is usually masculine gender.  [Matches old-fashioned English.]

To decide which grammatical gender is the printing gender for (o - an object):
	[not male or female, always use "it"]
	if o is not male and o is not female:
		decide on neuter gender;
	[neuter and prefer neuter gender, always use "it"]
	if o is neuter and prefer neuter gender is true:
		decide on neuter gender;
	[female and male, use preferred animate gender]
	if o is female and o is male:
		decide on preferred animate gender;
	[classic male; and non-neuter or male overrrides neuter]
	if o is male:
		decide on masculine gender;
	[classic female; and non-neuter or female overrrides neuter]
	if o is female:
		decide on feminine gender.

Section 2 - Viewpoint pronouns (in place of Section 2 - Saying pronouns in English Language by Graham Nelson)

To say we:
	now the prior named object is the player;
	if the story viewpoint is:
		-- first person singular: say "I";
		-- second person singular: say "you";
		-- third person singular:
			if printing gender for the player is:
				-- the masculine gender: say "he";
				-- the feminine gender: say "she";
				-- the neuter gender: say "it";
		-- first person plural: say "we";
		-- second person plural: say "you";
		-- third person plural: say "they";

To say us:
	now the prior named object is the player;
	if the story viewpoint is:
		-- first person singular: say "me";
		-- second person singular: say "you";
		-- third person singular:
			if printing gender for the player is:
				-- the masculine gender: say "him";
				-- the feminine gender: say "her";
				-- the neuter gender: say "it";
		-- first person plural: say "us";
		-- second person plural: say "you";
		-- third person plural: say "them";

To say ours:
	now the prior named object is the player;
	if the story viewpoint is:
		-- first person singular: say "mine";
		-- second person singular: say "yours";
		-- third person singular:
			if printing gender for the player is:
				-- the masculine gender: say "his";
				-- the feminine gender: say "hers";
				-- the neuter gender: say "its";
		-- first person plural: say "ours";
		-- second person plural: say "yours";
		-- third person plural: say "theirs";

To say ourselves:
	now the prior named object is the player;
	if the story viewpoint is:
		-- first person singular: say "myself";
		-- second person singular: say "yourself";
		-- third person singular:
			if printing gender for the player is:
				-- the masculine gender: say "himself";
				-- the feminine gender: say "herself";
				-- the neuter gender: say "itself";
		-- first person plural: say "ourselves";
		-- second person plural: say "yourselves";
		-- third person plural: say "themselves";

To say our:
	now the prior named object is the player;
	if the story viewpoint is:
		-- first person singular: say "my";
		-- second person singular: say "your";
		-- third person singular:
			if printing gender for the player is:
				-- the masculine gender: say "his";
				-- the feminine gender: say "her";
				-- the neuter gender: say "its";
		-- first person plural: say "our";
		-- second person plural: say "your";
		-- third person plural: say "their";

To say We:
	now the prior named object is the player;
	if the story viewpoint is:
		-- first person singular: say "I";
		-- second person singular: say "You";
		-- third person singular:
			if printing gender for the player is:
				-- the masculine gender: say "He";
				-- the feminine gender: say "She";
				-- the neuter gender: say "It";
		-- first person plural: say "We";
		-- second person plural: say "You";
		-- third person plural: say "They";

To say Us:
	now the prior named object is the player;
	if the story viewpoint is:
		-- first person singular: say "Me";
		-- second person singular: say "You";
		-- third person singular:
			if printing gender for the player is:
				-- the masculine gender: say "Him";
				-- the feminine gender: say "Her";
				-- the neuter gender: say "It";
		-- first person plural: say "Us";
		-- second person plural: say "You";
		-- third person plural: say "Them";

To say Ours:
	now the prior named object is the player;
	if the story viewpoint is:
		-- first person singular: say "Mine";
		-- second person singular: say "Yours";
		-- third person singular:
			if printing gender for the player is:
				-- the masculine gender: say "His";
				-- the feminine gender: say "Hers";
				-- the neuter gender: say "Its";
		-- first person plural: say "Ours";
		-- second person plural: say "Yours";
		-- third person plural: say "Theirs";

To say Ourselves:
	now the prior named object is the player;
	if the story viewpoint is:
		-- first person singular: say "Myself";
		-- second person singular: say "Yourself";
		-- third person singular:
			if printing gender for the player is:
				-- the masculine gender: say "Himself";
				-- the feminine gender: say "Herself";
				-- the neuter gender: say "Itself";
		-- first person plural: say "Ourselves";
		-- second person plural: say "Yourselves";
		-- third person plural: say "Themselves";

To say Our:
	now the prior named object is the player;
	if the story viewpoint is:
		-- first person singular: say "My";
		-- second person singular: say "Your";
		-- third person singular:
			if printing gender for the player is:
				-- the masculine gender: say "His";
				-- the feminine gender: say "Her";
				-- the neuter gender: say "Its";
		-- first person plural: say "Our";
		-- second person plural: say "Your";
		-- third person plural: say "Their";

Section 3 - Further pronouns (in place of Section 3 - Further pronouns in English Language by Graham Nelson)

To say those:
	say those in the accusative.

To say Those:
	say Those in the nominative.

To say those in (case - grammatical case):
	if the case is nominative:
		let the item be the prior named object;
		if the prior naming context is plural:
			say "those";
		otherwise if the item is the player:
			say "[we]";
		otherwise:
			if printing gender for the item is:
				-- the masculine gender: say "he";
				-- the feminine gender: say "she";
				-- the neuter gender: say "that";
	otherwise:
		let the item be the prior named object;
		if the prior naming context is plural:
			say "those";
		otherwise if the item is the player:
			say "[we]";
		otherwise:
			if printing gender for the item is:
				-- the masculine gender: say "him";
				-- the feminine gender: say "her";
				-- the neuter gender: say "that";

To say Those in (case - grammatical case):
	if the case is nominative:
		let the item be the prior named object;
		if the prior naming context is plural:
			say "Those";
		otherwise if the item is the player:
			say "[We]";
		otherwise:
			if printing gender for the item is:
				-- the masculine gender: say "He";
				-- the feminine gender: say "She";
				-- the neuter gender: say "That";
	otherwise:
		let the item be the prior named object;
		if the prior naming context is plural:
			say "Those";
		otherwise if the item is the player:
			say "[We]";
		otherwise:
			if printing gender for the item is:
				-- the masculine gender: say "Him";
				-- the feminine gender: say "Her";
				-- the neuter gender: say "That";

To say they:
	let the item be the prior named object;
	if the prior naming context is plural:
		say "they";
	otherwise if the item is the player:
		say "[we]";
	otherwise:
		if printing gender for the item is:
			-- the masculine gender: say "he";
			-- the feminine gender: say "she";
			-- the neuter gender: say "it";

To say They:
	let the item be the prior named object;
	if the prior naming context is plural:
		say "They";
	otherwise if the item is the player:
		say "[We]";
	otherwise:
		if printing gender for the item is:
			-- the masculine gender: say "He";
			-- the feminine gender: say "She";
			-- the neuter gender: say "It";

To say their:
	let the item be the prior named object;
	if the prior naming context is plural:
		say "their";
	otherwise if the item is the player:
		say "[our]";
	otherwise:
		if printing gender for the item is:
			-- the masculine gender: say "his";
			-- the feminine gender: say "her";
			-- the neuter gender: say "its";

To say Their:
	let the item be the prior named object;
	if the prior naming context is plural:
		say "Their";
	otherwise if the item is the player:
		say "[Our]";
	otherwise:
		if printing gender for the item is:
			-- the masculine gender: say "His";
			-- the feminine gender: say "Her";
			-- the neuter gender: say "Its";

To say them:
	let the item be the prior named object;
	if the prior naming context is plural:
		say "them";
	otherwise if the item is the player:
		say "[us]";
	otherwise:
		if printing gender for the item is:
			-- the masculine gender: say "him";
			-- the feminine gender: say "her";
			-- the neuter gender: say "it";

To say Them:
	let the item be the prior named object;
	if the prior naming context is plural:
		say "Them";
	otherwise if the item is the player:
		say "[Us]";
	otherwise:
		if printing gender for the item is:
			-- the masculine gender: say "Him";
			-- the feminine gender: say "Her";
			-- the neuter gender: say "It";

To say theirs:
	let the item be the prior named object;
	if the prior naming context is plural:
		say "theirs";
	otherwise if the item is the player:
		say "[ours]";
	otherwise:
		if printing gender for the item is:
			-- the masculine gender: say "his";
			-- the feminine gender: say "hers";
			-- the neuter gender: say "its";

To say Theirs:
	let the item be the prior named object;
	if the prior naming context is plural:
		say "Theirs";
	otherwise if the item is the player:
		say "[Ours]";
	otherwise:
		if printing gender for the item is:
			-- the masculine gender: say "His";
			-- the feminine gender: say "Hers";
			-- the neuter gender: say "Its";

To say themselves:
	let the item be the prior named object;
	if the prior naming context is plural:
		say "themselves";
	otherwise if the item is the player:
		say "[ourselves]";
	otherwise:
		if printing gender for the item is:
			-- the masculine gender: say "himself";
			-- the feminine gender: say "herself";
			-- the neuter gender: say "itself";

To say Themselves:
	let the item be the prior named object;
	if the prior naming context is plural:
		say "Themselves";
	otherwise if the item is the player:
		say "[Ourselves]";
	otherwise:
		if printing gender for the item is:
			-- the masculine gender: say "Himself";
			-- the feminine gender: say "Herself";
			-- the neuter gender: say "Itself";

[English Language used /they're/ to do "that's" which is counterintuitive, but preserved.
 /they/ /'re/ gives the expected behavior.
]
To say they're:
	let the item be the prior named object;
	if the prior naming context is plural:
		say "they";
	otherwise if the item is the player:
		say "[we]";
	otherwise:
		if printing gender for the item is:
			-- the masculine gender: say "he";
			-- the feminine gender: say "she";
			-- the neuter gender: say "that";
	say "['re]".

To say They're:
	let the item be the prior named object;
	if the prior naming context is plural:
		say "They";
	otherwise if the item is the player:
		say "[We]";
	otherwise:
		if printing gender for the item is:
			-- the masculine gender: say "He";
			-- the feminine gender: say "She";
			-- the neuter gender: say "That";
	say "['re]".

To say It:
	say "[regarding nothing]It".

To say There:
	say "[regarding nothing]There".

To say it:
	say "[regarding nothing]it".

To say there:
	say "[regarding nothing]there".

To say It's:
	say "[regarding nothing]It['re]".

To say There's:
	say "[regarding nothing]There['re]".

To say it's:
	say "[regarding nothing]it['re]".

To say there's:
	say "[regarding nothing]there['re]".

To say possessive:
	let the item be the prior named object;
	if the item is the player:
		say "[our]";
	otherwise if the prior naming context is plural:
		say "[the item][apostrophe]";
	otherwise:
		say "[the item][apostrophe]s";

To say Possessive:
	let the item be the prior named object;
	if the item is the player:
		say "[Our]";
	otherwise if the prior naming context is plural:
		say "[The item][apostrophe]";
	otherwise:
		say "[The item][apostrophe]s".

Volume - Compatibility with Plurality (for use with Plurality by Emily Short)

Section - Deleted (in place of Section 4 - Enumeration in Plurality by Emily Short)

[The function of this section of Plurality was incorporated into the main pronoun rewrite, above.]

Section - Backward Compatibility for Plurality

[Both usages are deprecated.]

To have the parser notice (o - an object): 
	set pronouns from o.

To notice (o - an object) boringly:
	set pronouns from o.
	
Gender Options ends here.

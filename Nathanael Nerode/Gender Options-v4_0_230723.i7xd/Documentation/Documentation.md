Section - Summary

Gender Options makes male, female, and neuter into independent on-off properties, each of which determines respectively whether "HE", "SHE", or "IT" can be used to refer to the thing.  It makes "THEY" refer to any plural-named or ambiguously plural thing.  It also allows some authorial choices over which pronoun to print for things with multiple valid genders or numbers.  It should be just as fast and efficient as the standard rules.

I have a taste for writing stuff with odd gender behavior, and so I decided to do this in a general-purpose manner.  There are several purposes most of which are shown in the City Park example.

Section - Gender/Number Model and Pronouns

In the new model, male, female, and neuter are each separate properties, so that a thing is "male" or "not male", "female" or "not female", and "neuter" or "not neuter".  This allows for maximum flexibility short of adding new pronouns (which is much more complicated and probably slower).

The gender is primarily for pronoun purposes.
When the player types "HE", anything male will match.
When the player types, "SHE", anything female will match.
When the player types "IT", anything neuter will match.
Something which is none of the three will never match any singular pronoun, which is not usually desirable, but may occasionally be useful (e.g. "The Exalted One shall not be referred to by pronouns!").

If you define a "man" or "men", it will by default be male, and not female or neuter.
If you define a "woman" or "women", it will by default be female, and not male or neuter.
If you define a "person" or "people", it will by default be male and female, but not neuter.  This makes more sense than it might at first appear; a person of unknown gender can be referred to as "he" or "she" by the player.
If you define a "thing" or an "animal", it will by default be neuter, and not male or female.

All of these can be overrriden and changed by specifying things like:
	Tracy is not male.
	Tracy is not female.
	Tracy is neuter.

The parser will update and recognize the appropriate pronouns when used by the player.  So a character who is both male and female can be referred to as "he" or "she" by the player, a ship can be referred to as "it" or "she", etc.

A similarly flexible model is implemented for number.  Any object which is plural-named or ambiguously plural can be referred to as "THEY".  Any object which is ambiguously plural can additionally be referred to using the singular pronouns -- whichever ones apply according to its gender.

So an amibguously plural, male, female, neuter thing can be referred to by any of the pronouns THEY, HE, SHE, IT.  Even if it's singular-named.
	The jumble is an ambiguously plural, male, female, neuter thing.
	The description of the jumble is "Things and people, all in a jumble! [They] [are] quite something."

The concept of "ambiguously plural" items is present in the Standard Rules but is not fully implemented.  (A singular-named ambiguously plural item will not match "they" in the Standard Rules.  It will match with Gender Options active.)

Section - Advice on the gender model

This is designed to be a plug-in extension which requires no change in existing code and keeps the same behavior if you have been using "man", "woman", or "animal".  If you have been using "person" to refer to generic non-gendered people and using "ambiguously plural" appropriately, this should simply improve the pronoun behavior with no code changes necessary.   But there may be some changes required if you have been using explicit gender adjectives.

This is because now male, female, and neuter are entirely separate traits; setting one does not set another.  Consider this code:
	Tracy is a person.
	Tracy is male.
	
Because the default for "person" is both male and female, responding to "him" and "her", this makes Tracy both male and female; the "male" adjective does nothing.  If you want to make Tracy a man (male and not female), you would have to do this:
	Now Tracy is not female.

Now suppose you want to change Tracy from a man to a woman (female and not male).  You'll have to make two statements:
	Now Tracy is female.
	Now Tracy is not male.

Now you want to make Tracy respond to "it".
	Now Tracy is neuter.
	
Tracy is still female.  If you want Tracy to stop responding to "her":
	Now Tracey is not female.

Similarly, if you make an animal female, the player can refer to the animal as both "it" and "her" (unless you also make the animal not neuter):
	Peppy is a female animal.
	
This is usually desirable.

Section - Unsetting pronouns

By default, if you are changing the gender of characters, it doesn't change any pronoun referents already set by the player.  So if "him" is currently referring to Alex, and Alex stops being male, "him" will continue to refer to Alex until the player looks at another male character.  Under some circumstances, this satisfies "principle of least surprise" -- but under others it doesn't.  If you want to make sure that Alex can not be referenced as him:

	unset pronouns from Alex

Section - Gender in output messages

Gender and number is used for a second purpose other than recognizing pronouns in the English Language extension, and we must fix this up too.
It shows up in message substitutions such as [those].
For this, each object must have a single preferred grammatical gender, even when it has multiple genders which match player input.

We define two variables for this purpose: "prefer neuter gender" and "default animate gender".  These are variables so that they can be changed at runtime (for effect).

	Prefer neuter gender is a truth state which varies.
	Prefer neuter gender is usually true.
If you have a dog or a ship which can be referred to as "it" or "her", this will print "it".
If you would rather have "she" printed, use this:
	Prefer neuter gender is false.

	The preferred animate gender is a grammatical gender which varies.
	The preferred animate gender is usually the masculine gender.
If you have an androgynous person (both male and female, but not neuter), this will print "him".
If you would rather have "her" printed, use this:
	The preferred animate gender is the feminine gender.
	
Prefer neuter gender is checked first; if it is false, then the preferred animate gender is checked.  An object will never be printed with a pronoun which isn't valid for it, unless it is not male, not female, *and* not neuter -- not responding to any pronouns from the player -- in which case "it" will be used.

Note that these use values of a different kind from the genders of objects for parsing purposes; the phrase "masculine gender", "feminine gender", and "neuter gender" must be specifically used.

This is all implemented with the following decide phrase.  If you don't like these rules and want to do something even more complicated (perhaps a per-object choice), override the decide phrase.

	To decide which grammatical gender is the printing gender for (o - an object):

Section - Number in output messages

Ambiguously plural items (like "pair of shoes") will be treated as plural or singular by output messages depending on whether they are "plural-named" or "singular-named"  This is standard behavior.  This does not affect the ability to refer to them by pronouns (you can always use both "they" and the singular pronouns for their gender).

The plural-named property is also used for the items like "the trees" which are always plural.  This is standard behavior.

Please note that for a thing which is ambiguously plural but singular-named, such as "pair of dice", the substitution "[they're]" will produce "that's", while "[they]['re]" will produce "it's".  Choose wisely!

Section - Printing differences from standard behavior

For reference, this is the procedure currently used in the Standard Rules as of the time of writing:

	For non-people:
	If person is plural, the plural form ("they") is used.
	Otherwise, neuter form ("it") is used.

	For people (including animals)
	If person is the player, "you" is used.
	If person is plural, plural form ("they") is used.
	Otherwise, if person is female, female form ("her") is used.
	Otherwise, if person is neuter, neuter form ("it") is used.
	Otherwise, male form ("him") is used.

In contrast, this was the procedure in Emily Short's Plurality:

	If the thing/person is plural, plural form ("they") is used.
	Otherwise, if the thing/person is the player, "you" is used.
	Otherwise, if the thing/person is neuter, neuter form ("it") is used.
	Otherwise, if the thing/person is male, male form ("he") is used.
	Otherwise, if the thing/person is female, female form ("she") is used.

Changing the gender model causes these to be two different procedures, which is why I wrote an entirely new and more versatile procedure.

Section - Miscellaneous Changes

In Standard Rules, a person is always transparent -- their contents can be seen and interacted with.
This is perfectly reasonable as a baseline but can be restrictive for some story authors, so instead,
with this extension, a person is usually transparent.  Which changes nothing unless you as the story
author decide to create a non-transparent person.

Section - Interaction with Other Extensions

Gender Options replaces parts of Standard Rules by Graham Nelson and should be included after it.
Gender Options replaces most of English Language by Graham Nelson and should be included after it.

Gender Options replaces parts of CommandParserKit.
Gender Options replaces parts of EnglishLanguageKit.

Gender Options is compatible with Neutral Standard Responses by Nathanael Nerode.
Gender Options is incompatible with Neutral Library Messages by Aaron Reed, which predates the "responses" system.  Neutral Standard Responses is intended as a replacement.

Gender Options includes fixes for the gender handling in Original Parser by Ron Newcomb.  However, Original Parser is broken on the current version of Inform, so don't use it.  As a result this is untested and Gender Options probably doesn't work as well with Original Parser as it does with the standard parser.  I have retained this code in hopes of reviving Original Parser some day.

Gender Options is compatible with Plurality by Emily Short in that it is safe to include both.  But they will probably not interact well due to conflicting gender assumptions.  Plurality is largely obsolete due to incorporation of most of its features in the Standard Rules as of Inform 6M62; please use the Standard Rules features in preference to the features in Plurality.

Gender Options is incompatible with Second Gender by Felix Larsson.  The two do very similar things, but IMO Gender Options does so in a cleaner and more comprehensive fashion.  It was developed completely independently.

Section - Changelog

4.0.230722 - Comment changes regarding code moved around in Core Inform.
	4.0.220530 - Section number removal in documentation to accomodate automatic section numbering
	4.0.220529 - Example fixes to accomodate automated testing of examples
	4.0.220527 - Example fixes to accomodate automated testing of examples
	4.0.220524 - Format Changelog!
	4.0.220523 - Eliminate now-unnecessary dummy variable.
	4.0.220521 - Update for Inform v10.1.0, which restructured Standard Rules and the I6T code and the method of replacing I6T code.
	- Implement "unset pronouns from" in order to solve an issue noted on the forum without restricting options.
	- Many whitespace fixes.
	- New example game.
	- Make opaque persons possible.
	- Apply my Style Guide principles -- don't number the headings!
	3/210331 - Fix example / testsuite.
	3/170818 - Small documentation and comment tweaks.
	3/170816 - Replaced "always" with "usually" for man and woman.
	- Eliminated implications which didn't work.
	- Moved "person is usually not neuter" into correct section.
	- Removed androgyne kind and collective noun property for efficiency (they were syntactic sugar).
	- Revised documentation, comments, and City Park exmaple.  Added "It for All" example.
	2/170815 - First public release for gamma testing.


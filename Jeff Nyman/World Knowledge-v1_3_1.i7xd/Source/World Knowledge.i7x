Version 1.3.1 of World Knowledge by Jeff Nyman begins here.

"Mechanics to represent the player's knowledge and understanding about the world."

"based partly on Epistemology by Eric Eve and Optimized Epistemology by Andrew Plotkin"

Part - Observability (for use without Epistemology by Eric Eve)

To mark-everything-in-scope-as-seen:
	(- MarkSeenScopeFor(player); -).

Include (-
	! LoopOverScope(routine, actor) calls the given routine for each object in scope.
	! It calls routine_id(obj_id) for each obj_id in scope. If the optional actor is
	! supplied, that defines the scope. In this context, it will apply seen/familiar to
	! every item in scope. Here the "--> 1" is a word array variable reference with
	! two entries: familiarization --> 0 ("familiar") and familiarization --> 1 ("seen").
	[ MarkSeenScopeFor obj;
		LoopOverScope(((+ familiarization +)-->1), obj);
	];
-);

Part - Sight (for use without Epistemology by Eric Eve)

A thing can be examined or unexamined.
A thing is usually unexamined.

After examining something:
	now the noun is examined.

A thing can be seen or unseen.
A thing is usually unseen.

Carry out looking (this is the mark items as seen when looking rule):
	mark-everything-in-scope-as-seen.
	
Carry out an actor opening a container (this is the mark items as seen upon opening a container rule):
	mark-everything-in-scope-as-seen.

The mark items as seen upon opening a container rule is listed after the standard opening rule in the carry out opening rules.

Part - Familiarity (for use without Epistemology by Eric Eve)

A thing can be familiar or unfamiliar.
A thing is usually unfamiliar.

To familiarize (T - thing) (this is familiarization):
	now T is familiar;
	now T is seen.

Carry out examining something visible (this is the mark items as seen on examining rule):
	familiarize the noun.

Part - Knowledge State

Definition: a thing is known rather than unknown if it is familiar or it is seen.

Section - Subjects

A knowledge subject is a kind of thing.

A knowledge subject is usually familiar.

The specification of a knowledge subject is "Represents a concept, entity or idea that has no real-world presence or functionality."

Section - Suppositions

A supposition is a kind of thing.

The specification of a supposition is "Represents an uncertain belief on the part of the player character."

Awareness relates various people to various suppositions.
The verb to be aware of means the awareness relation.

Section - Facts

A fact is a kind of thing.

The specification of a fact is "Represents something that is known or proved to be true from the standpoint of the player character."

Knowledge relates various people to various facts.
The verb to establish means the knowledge relation.

Definition: a fact is unconfirmed rather than confirmed if it is not established by the player.

Part - Testing - not for release

Requesting knowledge status of is an action out of world applying to one visible thing.

Understand "kstate [any thing]" as requesting knowledge status of.

Report requesting knowledge status of (this is the report knowledge status rule):
	say "[noun]";
	if the noun is a supposition:
		say "  (SUPPOSITION)";
	if the noun is a fact:
		say "  (FACT)";
	say "[line break]
		[if the noun is examined]examined[otherwise]unexamined[end if] /
		[if the noun is seen]seen[otherwise]unseen[end if] /
		[if the noun is familiar]familiar[otherwise]unfamiliar[end if] /
		[if the noun is known]known[otherwise]unknown[end if]";
	if the noun is a supposition:
		say " / [if the player is aware of the noun]aware of[otherwise]not aware of[end if]";
	if the noun is a fact:
		say " / [if the noun is established by the player]established[otherwise]not established[end if] /
		[if the noun is unconfirmed]unconfirmed[otherwise]confirmed[end if]";
	say "." (A).

World Knowledge ends here.

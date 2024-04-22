Version 1.2.1 of Optimized Epistemology by Andrew Plotkin begins here.

"Keeping track of what the player character knows and sees."

Book 1 - Sight

A thing can be either seen or unseen. A thing is usually unseen.

[It might seem more straightforward simply to write "Now everything visible in
the location is seen." but this turns out to be unacceptably slow in practice.

The original Epistemology extension uses "repeat with item running through things that are enclosed by the location: if the item is not enclosed by an opaque closed container: ..." This is better, but it still iterates over every thing in the game world, which is bad for very large games.

Instead, we use an I6 scope search. This only runs through items in the room, which is typically a much more manageable list.]

Carry out looking (this is the mark items as seen when looking rule):
	observe-all-in-scope.

Carry out opening a container (this is the mark items as seen on opening a container rule):
	observe-all-in-scope.

The mark items as seen on opening a container rule is listed after the
standard opening rule in the carry out opening rules.

Book 2 - Familiarity

Chapter 1 - Basic Familiarity

A thing can be familiar or unfamiliar. A thing is usually unfamiliar.

[Mark an item as both familiar and seen.]
To familiarize (T - thing) (this is familiarization):
	now T is familiar;
	now T is seen.

Carry out examining something visible (this is the mark items as seen on examining rule):
	familiarize the noun.

Definition: a thing is known rather than unknown if it is familiar or it is seen.

Chapter 2 - Subject (for use without Threaded Conversation by Emily Short)

A subject is a kind of thing. The specification of a subject is "Something
that conversations can refer to, but which has no real-world presence or
functionality."

Chapter 3 - Familiarity of Subjects

A subject is usually familiar.

Book 3 - The Nasty Bits

To observe-all-in-scope: (- ObserveScopeWithin(player); -).

Include (-

! Perform a scope search for the given actor, applying seen/familiar to every item reached.
! In this routine, ((+ familiarization +)-->1) is the I6 idiom for calling the I7 "familiarization" phrase.
[ ObserveScopeWithin obj;
	LoopOverScope(((+ familiarization +)-->1), obj);
];

-);

Book 4 - Testing commands - not for release

Requesting epistemic status of is an action out of world applying to one visible thing.

Understand "epistat [any thing]" as requesting epistemic status of.

Report requesting epistemic status of (this is the report epistemic status rule):
	say "[noun] - [if the noun is seen]seen[otherwise]unseen[end if] /
		[if the noun is familiar]familiar[otherwise]unfamiliar[end if] /
		[if the noun is known]known[otherwise]unknown[end if]." (A).

Optimized Epistemology ends here.

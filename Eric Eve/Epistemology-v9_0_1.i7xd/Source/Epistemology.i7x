Version 9.0.1 of Epistemology by Eric Eve begins here.

"Keeping track of what the player character knows and sees."

Book 1 - Sight

A thing can be either seen or unseen. A thing is usually unseen.

[It might seem more straightforward simply to write "Now everything visible in
the location is seen." but this turns out to be unacceptably slow in practice.
The following code does approximately the same thing but much faster.]


Carry out looking (this is the mark items as seen when looking rule): 
	unless in darkness:
		now every backdrop in the location is seen;
		repeat with item running through things that are enclosed by the location:  
			if the item is not enclosed by an opaque closed container:	
				now the item is familiar;
				now the item is seen.


Carry out opening a container (this is the mark items as seen on opening a container rule):
	repeat with item running through things that are enclosed by the noun:
		if the item is unseen and the item is visible:			
			now the item is familiar;
			now the item is seen.

The mark items as seen on opening a container rule is listed after the
standard opening rule in the carry out opening rules.

Book 2 - Familiarity

Chapter 1 - Basic Familiarity

A thing can be familiar or unfamiliar. A thing is usually unfamiliar.

Carry out examining something visible (this is the mark items as seen on examining rule):
	now the noun is familiar;
	now the noun is seen.

Definition: a thing is known if it is familiar or it is seen.

Definition: a thing is unknown if it is not known.

Chapter 2 - Subject (for use without Threaded Conversation by Emily Short) 

A subject is a kind of thing. The specification of a subject is "Something
that conversations can refer to, but which has no real-world presence or
functionality."

Chapter 3 - Familiarity of Subjects

A subject is usually familiar.

Book 3 - Testing commands - not for release

Requesting epistemic status of is an action out of world applying to one visible thing.

Understand "epistat [any thing]" as requesting epistemic status of.

Report requesting epistemic status of (this is the report epistemic status rule):
	say "[noun] - [if the noun is seen]seen[otherwise]unseen[end if] /
		[if the noun is familiar]familiar[otherwise]unfamiliar[end if] /
		[if the noun is known]known[otherwise]unknown[end if]." (A).

Epistemology ends here.

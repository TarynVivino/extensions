Version 2.3.2 of Prepositional Correctness by Gavin Lambert begins here.

"Provides a way to customise the prepositions used to refer to containment or support, and perhaps other custom relationships added by other extensions."

Section - Preposition Framework

A thing has some text called preposition.  A thing has some text called capital preposition.
A thing has a verb called entering preposition.  A thing has a verb called exiting preposition.
The capital preposition of a thing is usually "[preposition of the item described in sentence case]".

Prepositionally naming something is an activity on objects.
Capital prepositionally naming something is an activity on objects.

To say at the (O - thing) -- running on:
	carry out the prepositionally naming activity with O.

To say At the (O - thing) -- running on:
	carry out the capital prepositionally naming activity with O.

To say enter the (O - thing) -- running on:
	say "[adapt entering preposition of O] [the O]".

To say entering the (O - thing) -- running on:
	say "[present participle of entering preposition of O] [the O]".

To say exit the (O - thing) -- running on:
	say "[adapt exiting preposition of O] [the O]".

To say exiting the (O - thing) -- running on:
	say "[present participle of exiting preposition of O] [the O]".

Last rule for prepositionally naming a thing (this is the standard prepositionally naming rule):
	say "[preposition of parameter-object] [the parameter-object]".

Last rule for capital prepositionally naming a thing (this is the standard capital prepositionally naming rule):
	say "[capital preposition of parameter-object] [the parameter-object]".

[These responses are here because they no longer contain any 'real' English text on their own]
The you-can-also-see rule response (B) is "[At the domain] [we] ".
The you-can-also-see rule response (C) is "[At the domain] [we] ".
The use initial appearance in room descriptions rule response (A) is "[At the item] ".
The describe what's on scenery supporters in room descriptions rule response (A) is "[At the item] ".
The describe what's on mentioned supporters in room descriptions rule response (A) is "[At the item] ".
The describe room gone into rule response (M) is "[at the vehicle gone by]".
The describe room gone into rule response (N) is "[at the vehicle gone by]".
The examine containers rule response (A) is "[At the noun] ".
The examine supporters rule response (A) is "[At the noun] ".
The standard search containers rule response (A) is "[At the noun] ".
The standard search supporters rule response (A) is "[At the noun] ".

Section - Room Description Headings

[These are called out separately so that they can be replaced without affecting the regular prepositions.]

Room heading describing something is an activity on objects.

Last rule for room heading describing a thing (called place) (this is the standard room heading description rule):
	say at the place.

To say room description heading description for (place - thing) -- running on:
	carry out the room heading describing activity with the place.

The room description heading rule response (B) is " ([room description heading description for the intermediate level])".
The room description heading rule response (C) is " ([room description heading description for the intermediate level])".

Section - Standard English

[These rules replicate the default behaviour of the Standard Rules.]
The verb to get into means the reversed containment relation.
The verb to get onto means the reversed support relation.
The verb to get out of means the reversed containment relation.
The verb to get off means the reversed support relation.
The preposition of a thing is usually "in".
The preposition of a supporter is usually "on".
The preposition of an animal is usually "on".
The entering preposition of a thing is usually verb get into.
The entering preposition of a supporter is usually verb get onto.
The exiting preposition of a thing is usually verb get out of.
The exiting preposition of a supporter is usually verb get off.
[There are a couple of places where the Standard Rules previously printed "inside" or "on top of" rather than "in" or "on" as we'll be doing now.
 It wouldn't be impossible to support these extra cases too, but I think this is already getting complex enough.]

[These aren't actually referenced anywhere in the code that I could find, but they do actually get called somehow.  Must be internal compiler magic.]
The list writer internal rule response (R) is "[preposition of the noun] [if the noun is a person]whom[otherwise]which[end if] ".
The list writer internal rule response (S) is ", [preposition of the noun] [if the noun is a person]whom[otherwise]which[end if] ".
The list writer internal rule response (T) is "[preposition of the noun] [if the noun is a person]whom[otherwise]which[end if] ".
The list writer internal rule response (U) is ", [preposition of the noun] [if the noun is a person]whom[otherwise]which[end if] ".

The can't drop if this exceeds carrying capacity rule response (A) is "[There] [are] no more room [at the receptacle]."
The can't drop if this exceeds carrying capacity rule response (B) is "[There] [are] no more room [at the receptacle]."
The stand up before going rule response (A) is "(first [exiting the chaise])[command clarification break]".
The can't travel in what's not a vehicle rule response (A) is "[We] [would have] to [exit the nonvehicle] first."
The can't travel in what's not a vehicle rule response (B) is "[We] [would have] to [exit the nonvehicle] first."
The can't enter what's already entered rule response (A) is "But [we]['re] already [at the noun]."
The can't enter what's already entered rule response (B) is "But [we]['re] already [at the noun]."
The can't enter closed containers rule response (A) is "[We] [can't] [adapt entering preposition of the noun] the closed [noun]."
The can't enter if this exceeds carrying capacity rule response (A) is "[There] [are] no more room [at the noun]."
The can't enter if this exceeds carrying capacity rule response (B) is "[There] [are] no more room [at the noun]."
The can't take what you're inside rule response (A) is "[We] [would have] to [exit the noun] first."
The can't get off things rule response (A) is "But [we] [aren't] [at the noun] at the [if story tense is present tense]moment[otherwise]time[end if]."
The standard search supporters rule response (B) is "[There] [are] nothing [at the noun]."
The can't search closed opaque containers rule response (A) is "[We] [can't see] [preposition of the noun], since [the noun] [are] closed."
The implicitly pass through other barriers rule response (A) is "([exiting the current home])[command clarification break]".
The implicitly pass through other barriers rule response (B) is "([exiting the current home])[command clarification break]".
The implicitly pass through other barriers rule response (C) is "([entering the target])[command clarification break]".
The implicitly pass through other barriers rule response (D) is "([entering the target])[command clarification break]".
The standard report entering rule response (A) is "[We] [enter the noun]."
The standard report entering rule response (B) is "[We] [enter the noun]."
The standard report entering rule response (C) is "[The actor] [enter the noun]."
The standard report entering rule response (D) is "[The actor] [enter the noun]."
The standard report exiting rule response (A) is "[We] [exit the container exited from]."
The standard report exiting rule response (B) is "[We] [exit the container exited from]."
The standard report exiting rule response (C) is "[The actor] [exit the container exited from]."

Section - Riding (for use with Rideable Vehicles by Graham Nelson)

The verb to mount means the reversed support relation.
The verb to dismount means the reversed support relation.
The preposition of a rideable animal is usually "riding".
The preposition of a rideable vehicle is usually "riding".
The entering preposition of a rideable animal is usually verb mount.
The exiting preposition of a rideable animal is usually verb dismount.

Prepositional Correctness ends here.

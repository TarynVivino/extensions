Chapter - Compatibility

This extension was written for Inform 6M62 and verified with Inform 10.1.2.  Since it delves heavily into Standard Library messages it is likely incompatible with any other version of Inform, but YMMV.

It does not depend on any other extensions, but does introduce some extra features to enhance "Rideable Vehicles by Graham Nelson" if you happen to be using that as well.

Chapter - Prepositions in General

Inform's world model currently only defines two types of things that can contain other things:
	
- Containers, which have things "in" them, and (if enterable) will show "(in the container)" in the room description heading.
- Supporters, which have things "on" them, and (if enterable) will show "(on the supporter)" in the room description heading.

Sometimes, however, we want to be more creative than this -- perhaps rather than "(on the ladder)" you'd rather see "(dangling from the ladder)".  Or in another case you might want "(under the chassis)" or perhaps even just "(lounging about)".  Or when describing the things contained in a closet, you might want to say "Hanging in the closet" rather than simply "In the closet".

This extension overrides a ton of internal things in the Standard Rules to (hopefully) allow you to replace *almost* all of the places where the default prepositions are used with your own item-specific ones:
	
	The preposition of the closet is "hanging inside".
	
Note that prepositions should always be specified in lower case.  They'll be automatically capitalised if required when used at the beginning of a sentence.  But if you don't like the automatic capitalisation, you can override it:
	
	The capital preposition of the closet is "Hanging within".
	
For more complex cases, you can either put if conditions in the preposition, or you can write a special rule -- but note that there are still a small number of places where only the preposition is used, not the rule:

	Rule for capital prepositionally naming a supporter (called the table):
		if the table is magical, say "Glowing runes surround [the table], illuminating";
		otherwise continue the activity.

Note that you need to specify the full text (typically including the name; while that's not mandatory it would usually be confusing without it), and (for the 'capital' variant only) needs to sound correct when followed by a list of objects.

Chapter - Entering/Exiting Prepositions

There are a few places where Inform wants to print a verb related to the preposition -- for example, when entering and exiting, it may want to use phrases like "get into" or "gets out of" or "getting onto".  These don't fit neatly into a simple text property since they need to adapt to the story narrative tense and whether the actor being mentioned is plural or not and a few other factors, so instead we're piggybacking on Inform's rich adaptive verb system to handle these.

To add a new action phrase, you first need to link it to a relation that Inform is aware of (while Inform does support verbs "for saying" that aren't linked to relations, it doesn't currently allow using prepositions with these for some reason):

	The verb to squeeze into means the reversed containment relation.
	The verb to pop out of means the reversed containment relation.
	The entering preposition of the small chest is the verb squeeze into.
	The exiting preposition of the small chest is the verb pop out of.
	
It doesn't really matter which relation you associate with them (unless you use the phrase elsewhere in your source text), but typically "reversed containment" and "reversed support" make the most sense, or perhaps another relation that is defined by an extension.

(And yes, you can just use a verb without a preposition, despite the property name.  But calling the property this keeps them logically related, despite not being entirely grammatically accurate.)

These don't have associated rules/activities, but if you need them to be dynamic for some reason then you can change the property during play as required.
	
Chapter - The Room Description Heading

By default, the same prepositions will be used in the room description heading (when inside or on top of something) as in other places.  However, since these are only printed for the player (whereas the others are most commonly used for things other than the player), it's fairly likely that you'd want to customise them independently.  This can be done through another activity:
	
	Rule for room heading describing the ladder: say "dangling from [the ladder]".
	Rule for room heading describing an animal (called the mount): say "riding [the mount]".
	
Note that you need to specify the full text that you want to appear in the parentheses, typically including the name of the thing that the player is inside or on, otherwise it may be confusing for the player.

Also note that these rules will only be used for the parenthetical extensions after the main location name -- if someone gets into a closet, then it will print the location name and follow the rule to print the closet's prepositional phrase afterwards; but if they then close the closet so they can no longer see the external room, then the closet is now the "visibility ceiling" and it will simply print its name without any parenthetical extensions and without trying these rules (unless the player were inside something else inside the closet).  If you really want to replace this text as well, then you'll have to use a different technique, such as:
	
	This is the closeted rule:
		say "[bold type]Hiding inside the closet[roman type][line break]";
		say run paragraph on with special look spacing.
		
	The closeted rule substitutes for the room description heading rule when the player is inside the closed closet.

Note that this requires more boilerplate, since you're replacing the entire standard rule.  (And this replacement rule doesn't check if the player is inside something else that is in turn inside the closet, so try to avoid doing that sort of thing, or you'll need a more complex rule or condition, or perhaps to intercept "printing the name" instead.)

Chapter - What's not affected

The response text for several actions (notably, the "putting it on" and "inserting it into" actions) have deliberately not been altered to use custom prepositions.  This is to remain consistent with the parser's grammar for the command itself.

If you want to recognise additional custom prepositions in player commands, then you will need to define additional commands and/or amend the grammar yourself.  Since Inform's parser is (in general) a left-to-right one, it isn't really feasible to have these parse using a preposition property for a not-yet-known second noun.

Chapter - Using with non-English languages

While this is heavily based on the English language version of the Standard Rules, it should in theory be feasible to provide similar support for other languages, provided they at least follow a somewhat similar grammatical structure.  This requires writing another extension that either entirely replaces this, or includes this along with a replacement section thusly:
	
	Section - Another Language (in place of Section - English Language in Prepositional Correctness by Gavin Lambert)
	
	Your definitions go here.


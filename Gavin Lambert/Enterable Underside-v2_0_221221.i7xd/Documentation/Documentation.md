This extension is based on Underside by Eric Eve, extending that to support the player actually entering the underside of objects.

It defines one new action, "entering underneath", which can move the player (or another actor) underneath any object that has had an underside created for it.  By default, this requires that the underside (specifically) has been declared as "enterable".

Naturally, the space under things is often quite limited.  Underside uses the Bulk Limiter extension (also by Eric Eve) to manage this; see the documentation for that extension for more details on setting the "bulk" (size) of each object and the "bulk capacity" (available space) in the underside.  By default, entering underneath will only be allowed if there's enough free space in the underside for the actor to actually fit.  (Although note that a little bit of Hammerspace may apply here -- by default the player's inventory is not counted in their bulk, so they can quite happily enter underneath something while carrying something else too large to fit underneath.  You can fix this by carefully setting the player's bulk capacity (so that they cannot pick up enough things to not fit) and/or dynamically changing the player's bulk depending on their current inventory.)

Note that this extension only introduces the new action -- it does not introduce any corresponding grammar to allow the player to actually perform it.  This is because depending on the specific objects in your story, different commands may make more sense than others.  You can define whatever commands you like; for example:
	
	Understand "hide under/beneath [something]" as entering underneath.

You can alternatively trigger "try entering underneath bed" from some other command's rules, as you'd expect, even if you don't define any commands for it.

You may also want to override the default response text to make it more suitable for the commands you're using, for example:
	
	can't enter underneath something not enterable rule response (A) is "[regarding the noun][Those] [aren't] something [we] [can] hide under."
	
Have a look at the "entering underneath" action in the Index for all the standard responses (and to quickly edit them using the 'set' link).

Since this builds on top of Prepositional Correctness, you're also able to customise the "under" preposition used in the room heading when the player is underneath, or in room descriptions when other objects are:

	The preposition of under#bed is "beneath".


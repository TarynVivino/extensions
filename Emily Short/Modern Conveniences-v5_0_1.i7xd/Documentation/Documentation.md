Modern Conveniences provides a kitchen kind and a bathroom kind of room. Kitchens will automatically be furnished with scenery cabinets, counters (called "furniture counter" to distinguish them from other counter variables), stove-and-oven assemblies, sinks, and refrigerators. Bathrooms will automatically be furnished with sinks, toilets, baths, and cabinets.

One slight challenge lies in giving these assembled pieces separate descriptions. When we have an assembly that adds parts to objects, we can then talk about (for instance) "the stove's switch" elsewhere in the code. But items that have been assigned rooms are not named in the same way, so we cannot talk about "the Industrial Kitchen's stove" in our code as a way to assign it a description or special behavior.

If we only have one instance of each item in our game, we may simply say something like

	The description of a stove is "Scrupulously polished."

applying the description to the class as a whole since there will only be one instance of it.

In a game that features multiple bathrooms and kitchens, this won't be enough; we might instead give the items descriptions that check their location (if there are only a couple of each):

	The description of a stove is "[if in Industrial Kitchen]A massive stainless steel stove-top with six burners[otherwise]Your standard four-burner item[end if]."

or create an

	Instead of examining the stove in the Industrial Kitchen: ...

sort of rule for those objects we want to describe specially; or, as the most extreme case, we might write a When play begins: ... rule to initialize the features of the generated objects, like so:

	When play begins:
		let N be a random stove in the Industrial Kitchen;
		move the boiling pot to N;
		change the description of N to...

We can also, of course, use the appliances individually. In the end, the "kitchen" and "bathroom" room types are likely to be most useful when we want to include the standard props but not actually make them a critical part of the game; if stoves and sinks have more of a starring role in the production, we may be better off coding them or at the very least placing them by hand, as in

	The Industrial Kitchen is a room.
	Thor is a stove in the Industrial Kitchen. It supports a boiling pot.


Additional code is provided for a more rigorous treatment of liquids when this extension is used alongside Measured Liquid by Emily Short. In that case, turning on taps will create a liquid source called "flowing water" from which fluid containers can be filled.


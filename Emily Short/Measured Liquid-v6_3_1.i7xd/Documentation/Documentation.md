Measured Liquid provides a concept of volume, kinds for fluid containers and liquid sources, and actions for pouring, drinking, and swimming. It handles mixture recipes and allows players to combine liquids to produce new ones. It also provides full support for non-player characters to use the same actions.

Measured Liquid can be used with the Metric Units extension by Graham Nelson, or on its own, in which case it will assume the use of Imperial units. (Note that Metric Units requires Glulx.)

The inclusion of Assorted Text Generation by Emily Short will add some additional detail to the description of partially-filled containers, but that extension is not required.

Chapter: New Units

Section: Volumes

Volumes are by default measured in fl oz, fluid ounces; but should we prefer metric measurement, including Metric Units by Graham Nelson will handle all volumes in milliliters/cubic centimeters instead.

In the event that neither fluid ounces nor milliliters are suitable for a project, or we want to use mL but without committing to Glulx as Metric Units requires, we may safely alter the units of volume however we wish by replacing the relevant section of this extension.

For instance, if we wanted to go a bit cookery-crazy and use nothing but teaspoons for measurement, we might write:

	Section 1 - Definition (in place of Section 1I - Definition (for use without Metric Units by Graham Nelson) in Measured Liquid by Emily Short)

	A volume is a kind of value. 1 tsp specifies a volume.

	A fluid container has a volume called a fluid capacity. A fluid container has a volume called fluid content. The fluid capacity of a fluid container is usually 50 tsp. The fluid content of a fluid container is usually 0 tsp.

	The sip size is a volume that varies. The sip size is usually 1 tsp.

	The max volume is a volume that varies. The max volume is 2147483647 tsp.

(Note that our max volume should be 2147483647 of the base unit if we are compiling for Glulx, or 32767 if compiling for the Z-machine, as these are the maximum possible values.)

Chapter: New Kinds

Section: Liquids

Liquids are a kind of value in the present system. By default, only water and a null value, "nonliquid", are defined, but we may revise the list by adding entries to the Table of Liquids, like this:

	Table of Liquids (continued)
	liquid	potable	flavor
	absinthe	true	"It tastes bitter."
	motor oil	false	--

The potable entry indicates whether the liquid can be drunk.

The flavor sentence is optional, but is used to construct more interesting results for tasting and drinking, as demonstrated below. Providing a flavor sentence for a non-potable liquid will never have any interesting effect.

Section: Fluid containers and their descriptions

A fluid container is assigned a liquid and two volumes.

The liquid is whatever the container contained last (or perhaps still contains).

The volumes are the fluid capacity (how much it could possibly contain at maximum) and the fluid content (how much it does contain at the moment).

Like regular containers, fluid containers respond to examination by adding a line of text about their contents, as in:

	>EXAMINE TUMBLER
	A heavy tumbler with gold flecks in the glass.

	The tumbler is about half full of scotch.

For the purpose of puzzles involving measurement, a fluid container can be "graduated" or "ungraduated". Containers are ungraduated by default, and will only declare proportional information about the amount they contain, as in

	The pitcher is full of absinthe.
	The pitcher is mostly full of absinthe.
	The pitcher is about half full of absinthe.
	The pitcher is mostly empty of absinthe.

Including Assorted Text Generation by Emily Short will make this proportional information more detailed, as in

	The cup is approximately three quarters full of water.

Graduated fluid containers always give the exact measurement of their content, thus:

	The pitcher contains 8.8 fl oz of absinthe.

If we want to make more substantial changes to the way a fluid container is described with respect to its contents, we may do this with the describing the fullness activity. This activity should print only the text that comes after the name of the object, and should end with no line break.

For instance, one of the describing fullness rules currently is

	Rule for describing the fullness of a non-empty graduated emptyable fluid container (called the sample cup) (this is the describe graduated containers rule):
		say "contain[s] [the fluid content of the sample cup] of [the liquid of the sample cup].[no line break]";

This produces the text that is shown on examining a fluid container, and sometimes after pouring.

We can also remove the entire rule that prints this content, as in

	{*}The examining fluid containers rule is not listed in any rulebook.

...but this approach should be handled with caution. If we take this rule out and also do not define any description text for the fluid container, the Standard Rules' "examining containers" rule will run and print something like "The pitcher is empty" because the pitcher contains no solid objects, even if the pitcher is in fact brimming with Belgian ale at the time.

Section: Fluid containers and solid objects

By default the player is prevented from putting solid objects into any fluid container. This prevents many complicated situations where part of the volume of a glass might be displaced by a a metal cube, where a cork might float on the surface of some wine, where a handwritten note might be put into a coffee cup and rendered illegible, where a scrap of cloth might be discolored by its contact with red fruit punch, and so on.

If we want to remove this constraint, we can unlist it by writing
	
	{*}The can't put solids into a fluid container rule is not listed in any rulebook.

...but then it's up to us to deal with the implications, whatever those might be.

Section: Inserting fluid containers

By default, we are not allowed to put an open, non-empty fluid container into another portable container, because it's likely to spill. (Fixed in place or scenery containers are exempt, to allow for refrigerators, cabinets, and similar installations.) This gets around the nonsensical situation of stowing a vase full of water into a backpack and then coming back later to find that the water all stayed in.

If we do want to allow this after all, we can unlist the relevant rule thus:

	{*}The can't stash full cups rule is not listed in any rulebook.

If Measured Liquid is used alongside Jon Ingold's Considerate Holdall extension, it will provide holdall a rule so that the game does not even attempt to stash an open non-empty container. The rule in question is the don't try to stash full cups rule.

Section: Cleaning fluid containers

By default, when we drink from something, even an empty cup retains a trace amount of the liquid it used to contain. This information is used in descriptions of the cup, and is also used to determine reactions if we try to DRINK JUICE after the juice cup is already emptied. Further, the game will assume we want to fill the container with more of whatever it previously contained, if that option is available.

Only an explicit command to RUB (or CLEAN, which is the same action) the cup will remove this trace; if we do that, however, its liquid is changed back to the null value, nonliquid.

To remove this behavior, add:
	
	{*}Use no trace amounts.

whereupon drinking or pouring will always leave vessels empty and the behavior of RUB will not be interfered with.

Section: Liquid Sources

Fluid containers have a sub-kind called a liquid source. Liquid sources are supplies of water that flow eternally and never run out; it doesn't matter how much we take from this source.

Yet further sub-kinds are the liquid lake and the liquid stream.

The liquid lake represents a body of water large enough to swim in, and into which we can safely empty smaller containers without significantly diluting the content. Lakes are also relevant to the swim verb (see below).

The liquid stream is better used for fountains, faucets, and other flows of liquid that provide a constant supply but no standing body of liquid.

Chapter: New Actions

Section: Drinking

The player is allowed to drink liquids from a fluid container, assuming those liquids have not been defined to be not potable.

By default, the output is one of the following, depending on whether the supply is depleted as a result:

	You take a sip of (the liquid).
	You take a sip of (the liquid), leaving (the container) empty.

If we have defined a flavor sentence for that liquid, that is added as the next sentence, as in:

	You take a sip of fruit punch, leaving the glass empty. The flavor is exceptionally cloying.

The amount of liquid swallowed by a sip is determined by the sip size. By default the sip size is 2.0 fl oz, or (with Metric Units) 55 mL. These are not exactly equal volumes, but each is 1/6 the size of a standard-volume soda can, 12 fl oz or 330 mL, in the US and Britain respectively.

Sometimes liquid measurement may be used as part of a puzzle in which we want the player to be compelled to measure things precisely. In this case, it might be desirable to make sips non-uniform in size so that the player cannot safely quantify liquids by sipping them. To do this, we have the option to
	
	Use variable sip size.

When using variable sip size, the sip is subject to a variation of up to 2/3 the standard size of a sip. (So, for instance, if the sip size is set at 0.3 fl oz, the possible variation is up to 0.2 fl oz, with the result that any given sip might range in volume from 0.1 fl oz to 0.5 fl oz.)

It will not be possible to have a sip size of 0 as a result of random variation.

Finally, a fluid container can be "preferred for drinking". We can set this with, for instance:

	The cocktail glass is preferred for drinking.

This indicates that, in any ambiguous case, the game should try to drink from that vessel rather than from something else. This makes it easier to implement polite player characters who prefer to drink from glasses rather than from the carton, even though both may contain the same kind of liquid.

The drinking action has a liquid that varies, called "the liquid drunk".

Section: Pouring and Filling

This extension supports a wide range of pouring and filling grammar, including

	fill something with/from something
	pour something in/into/on/onto something
	mix something in/with something
	empty something into something

By default, if the player types only

	FILL CUP

the game will attempt to find a source that provides the same kind of liquid already in the cup in order to fill it back up; then it will default to some other liquid source, if no matching liquid source is available.

The player is prohibited from pouring a container into itself, overfilling a container that is already full, or filling from an empty container.

The pouring action has a liquid that varies, called "the liquid poured", and a volume that varies, called "the amount poured". These values can be used in constructing our own report rules to describe the action differently; for instance, we might write

	Report pouring something into a graduated container:
		say "You pour [the amount poured] of [the liquid poured] into [the second noun]." instead.

if we wished to describe pouring more precisely in the context of volume-marked containers.

Section: Simple Mixing

By default, the player is not allowed to mix liquids of different types, since such mixtures make extra work for the author and may not always be desirable. Moreover, there is a text that varies which contains the refusal the player will receive, defined as follows:

	The liquid-mixture refusal is some text that varies. The liquid-mixture refusal is "That would mix [the liquid of the noun] with [the liquid of the second noun]."

If we want to keep the default behavior but change the message, we should alter the liquid-mixture refusal, as in

	When play begins:
		now the liquid-mixture refusal is "[The person asked] dare not mix liquids!"

...or some similar message, bearing in mind that if characters other than the player can be persuaded to pour liquids, their responses as well as the player's will be handled by the liquid-mixture refusal.

If we do want to mix liquids, we may write

	Use mixed liquids.

With this use option enabled, we allow the player to mix together liquids to produce new ones. In order to indicate how drinks should work, we must include all the liquids that can be mixed, as well as all their components, in our Table of Liquids, like so:

	Table of Liquids (continued)
	liquid	potable	flavor
	cranberry juice	true	"It tastes deliciously tangy."
	vodka	true	"It doesn't taste like much except alcohol."
	crantini	true	"It's cranberry juice, but with more of a kick."

And we must also provide an exhaustive collection of recipes in the form

	Table of Liquid Mixtures (continued)
	mix-list	result
	{cranberry juice, vodka}	crantini

If the player combines two liquids in any proportion, they create a third liquid as determined by a list of mixture components.

Section: Mixing with Quantified Ingredients

By default, there is no attempt to determine whether the mixture involves precise quantities of elements; if we want that, we should provide our own, more precise specification of how mixture components are to behave.

We can do this by meddling with the liquid-mixing rulebook, which currently contains two rules: "keep same recipe as before rule", which makes no change if we're pouring more of a component into a recipe that already contains that component, and the "create mixtures" rule, which applies the rather simple criteria we currently use. De-listing those and replacing them with more exacting rules will alter the behavior of mixture.

The following rulebook variables may be useful:

	The liquid-mixing rulebook has a fluid container called the destination container.
	The liquid-mixing rulebook has a list of liquids called the recipe contents.

The recipe contents are always sorted when they're created, so that they can be reliably checked against other liquid lists.

The liquid-mixing rulebook is called during the phase of setting action variables for pouring, which means that if it has results, the choice of result will be saved as "the resulting liquid".

The example "Exactitude", below, shows off one possible way to edit this rulebook to provide stricter kinds of mixing simulation.

Section: Swimming

By default, the player is not allowed to swim, but the verb is implemented in order to provide sensible responses in a range of situations. The command to swim will produce the message

	There's nothing sensible to swim in.

unless the player can see a liquid lake, in which case he'll be told

	You don't feel like a dip in (the liquid lake) just now.

SWIM IN (some specific item) will also be understood, though again there will be a default refusal in all cases.

If we want to allow swimming in liquid lakes, we should begin by unlisting the block swimming rule, as in

	The block swimming in liquid lakes rule is not listed in any rulebook.

...and then supplying some carry out rules for swimming.


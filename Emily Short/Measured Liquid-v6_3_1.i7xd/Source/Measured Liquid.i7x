Version 6.3.1 of Measured Liquid by Emily Short begins here.

"Measured Liquid provides a concept of volume, together with the ability to fill containers, pour measured amounts of liquid, and drink from containers. It handles mixtures as well, if desired. It is compatible with, but does not require, the Metric Units extension by Graham Nelson."

[Updated for adaptive responses.]

To hold is a verb. To contain is a verb. To clean is a verb. To fill is a verb. To dump is a verb. To must is a verb. To remain is a verb. To offer is a verb. To pour is a verb. To lead is a verb. To fit is a verb.

Part 1 - Volumes and Capacities

Chapter 1 - The fluid container

Section 1 - The container

A fluid container is a kind of container. 

A fluid container is either graduated or ungraduated. A fluid container is usually ungraduated.

Check inserting something into a fluid container (this is the can't put solids into a fluid container rule):
	say "[The second noun] [hold] only liquids." (A) instead. 
	

Understand the liquid property as describing a fluid container. Understand "of" as a fluid container.

Understand "empty" as a fluid container when the item described is patently empty.
Understand "closed" as a container when the item described is closed.

Definition: a fluid container is patently empty:
	if it is not empty:
		no;
	if it is closed and it is not transparent:
		no;
	yes.

Check an actor inserting a non-empty open fluid container into something (this is the can't stash full cups rule):
	if the second noun is fixed in place or the second noun is scenery:
		make no decision; [if we don't carry it around, it's probably not a liability.]
	if the second noun is part of something which is fixed in place:
		make no decision;
	if the second noun is part of something which is scenery:
		make no decision;
	if the actor is the player:
		say "That [would lead] to spills." (A);
	stop the action.

Section 2 - Considerate holdall behavior (for use with Considerate Holdall by Jon Ingold)

A holdall rule for a non-empty open fluid container (this is the don't try to stash full cups rule):
	disallow stashing.

Chapter 2 - Volume (for Z-Machine only)

Section 1I - Definition (for use without Metric Units by Graham Nelson)

A volume is a kind of value. 15.9 fl oz (in Imperial units, in fl oz) specifies a volume with parts ounces and tenths.

A fluid container has a volume called a fluid capacity. A fluid container has a volume called fluid content. The fluid capacity of a fluid container is usually 12.0 fl oz. The fluid content of a fluid container is usually 0.0 fl oz.

The sip size is a volume that varies. The sip size is usually 2.0 fl oz.

The max volume is a volume that varies. The max volume is 3276.7 fl oz. 

Chapter 2 - Volume (for Glulx only)

Section 1I - Definition (for use without Metric Units by Graham Nelson)

A volume is a kind of value. 15.9 fl oz (in Imperial units, in fl oz) specifies a volume with parts ounces and tenths.

A fluid container has a volume called a fluid capacity. A fluid container has a volume called fluid content. The fluid capacity of a fluid container is usually 12.0 fl oz. The fluid content of a fluid container is usually 0.0 fl oz.

The sip size is a volume that varies. The sip size is usually 2.0 fl oz.

The max volume is a volume that varies. The max volume is 214748364.7 fl oz.

Section 1M - Definition (for use with Metric Units by Graham Nelson)

A fluid container has a volume called a fluid capacity. A fluid container has a volume called fluid content. The fluid capacity of a fluid container is usually 330 mL. The fluid content of a fluid container is usually 0 mL.

The sip size is a volume that varies. The sip size is usually 55 mL.

The max volume is a volume that varies. The max volume is 2147483647 mL.

Chapter 3 - Emptiness 

The null volume is a volume that varies. [This will automatically be 0 in whichever units we happen to be using this time around, which is convenient for doing comparisons and setting values elsewhere in the code without having to refer to mL or fl oz explicitly.]

Definition: a fluid container is empty if the fluid content of it is the null volume. 
Definition: a fluid container is non-empty if it is not empty.
Definition: a fluid container is full if the fluid content of it is the fluid capacity of it.


Chapter 4 - Prefixes and Suffixes

Before printing the name of a fluid container (called the target) while not drinking or pouring (this is the prefix empties rule):
	if the current action is the action of opening the target:
		make no decision;
	if the person asked is the player and the target is patently empty:
		say "empty " (A);
	otherwise:
		make no decision;

Before printing the plural name of a fluid container (called the target) while not drinking or pouring (this is the plural prefix empties rule):
	if the current action is the action of opening the target:
		make no decision;
	if the person asked is the player and the target is patently empty:
		say "empty " (A);
	otherwise:
		make no decision;

Before printing the name of a closed transparent fluid container (called the target) while taking inventory (this is the prefix closedness rule):
	say "closed " (A).

Rule for printing room description details of an empty fluid container (this is the don't append emptiness rule):
	stop.

After printing the name of a fluid container (called the target) while not examining or searching or pouring (this is the suffix with contents rule):
	if the current action is the action of opening the target:
		do nothing;
	if the target is a liquid source:
		do nothing instead;
	if the target is closed and the target is not transparent:
		do nothing instead; 
	if the person asked is not the player:
		do nothing instead;
	unless the target is empty:
		say " of [liquid of the target]" (A);
		omit contents in listing.

After printing the plural name of a fluid container (called the target) while not examining or searching or pouring (this is the plural suffix with contents rule):
	if the current action is the action of opening the target:
		do nothing;
	if the target is a liquid source:
		do nothing instead;
	if the target is closed and the target is not transparent:
		do nothing instead; 
	if the person asked is not the player:
		do nothing instead;
	unless the target is empty:
		say " of [liquid of the target]" (A);
		omit contents in listing.

Report opening a fluid container when the noun is not transparent (this is the report fluid container contents on opening rule):
	say "[We] [open] [the noun], which [fill description of the noun][paragraph break]" instead.

Chapter 5 - Room Description Details

Rule for printing room description details of a fluid container:
	do nothing instead.

Part 2 - Liquids

Liquid is a kind of value.  A fluid container has a liquid.  

Some liquids are defined by the Table of Liquids.

Table of Liquids
liquid	potable	flavor	description (text)
nonliquid	false	--	--
water	true	"Refreshing!"	--

To decide what text is the flavor of (beverage - a liquid):
	decide on flavor corresponding to a liquid of beverage in the Table of Liquids.

To decide whether (beverage - a liquid) can be drunk:
	decide on potable corresponding to a liquid of beverage in the Table of Liquids.

Use no trace amounts translates as (- Constant TRACES_OFF; -). 

Instead of an actor rubbing a fluid container (this is the clean away traces rule):
	if the no trace amounts option is active:
		make no decision;
	if the noun is not empty:
		say "[It's] hard to clean [the noun] while [they] still [contain] so much." (A);
		rule fails;
	if the liquid of the noun is not nonliquid:
		say "[The actor] [clean] away all traces of [the liquid of the noun]." (B);
		now the liquid of the noun is nonliquid;
		rule succeeds;
	otherwise:
		say "[The noun] [are] already clean." (C);
		rule succeeds.
 
Part 3 - Liquid Sources

Chapter 1 - The Liquid Source

[And now we add our liquid source kind, which will represent streams of tap water, saltwater lakes, absinthe fountains, and any other infinite supplies of liquid we might need. The volume of a liquid source is always set to be the largest possible number of fluid ounces available to us, but this varies for the Z-machine and Glulx, so they are separately defined.]

A liquid source is a kind of fluid container. A liquid source has a liquid. A liquid source is usually scenery.

When play begins (this is the initialize liquid sources rule):
	repeat with item running through liquid sources:
		now the fluid capacity of the item is max volume;
		now the fluid content of the item is max volume.

Carry out pouring a liquid source into something (this is the liquid sources stay full rule): 
	now the fluid content of the noun is the max volume. 
 
Chapter 2 - Pouring from Liquid Sources

[We want filling things from liquid sources to work the same way as usual, with the distinction that a) the liquid source never depletes in quantity (hence the carry-out rule resetting its fullness); and b) we should report the results a bit differently as well:]

Report pouring a liquid source into a fluid container (this is the report filling from a liquid source rule):
	say "[We] [fill] [the second noun] up with [liquid of the noun] from [the noun]." (A) instead.

Report someone pouring a liquid source into a fluid container (this is the report someone filling from a liquid source rule):
	say "[The actor] [fill] [the second noun] up with [liquid of the noun] from [the noun]." (A) instead.


Part 4 - Lakes and streams

Chapter 1 - Defining Lakes

[A liquid lake is a large and potentially swimmable body of liquid in which objects could be lost. This doesn't cover every possible sort of liquid source, obviously: one might also have a fountain or tap that produced lots of liquid but was not suitable to swim in..]

[Pouring liquids into a liquid lake needs to work completely differently from pouring liquids into anything else. Let's say we're going to allow any liquid at all to be dumped into rivers and streams (environmental protections evidently are not very well-enforced in this scenario):]

A liquid lake is a kind of liquid source.

Instead of an actor pouring a fluid container into a liquid lake (this is the dumping fluids rule):
	if the noun is empty:
		if the actor is not the player:
			stop the action;
		say "[The noun] already [contain] nothing." (A) instead;
	now the fluid content of the noun is null volume;
	if the actor is the player:
		say "[We] [dump] out [the noun] into [the second noun]." (B);
		rule succeeds;
	otherwise if the actor is visible:
		say "[The actor] [dump] out [the noun] into [the second noun]." (C);
		rule succeeds;

Before an actor inserting something into a liquid lake (this is the can't throw objects in a liquid source rule):
	if the player is the actor: 
		say "[The noun] would get lost and never be seen again." (A) instead;
	stop the action.

Chapter 2 - Swimming

Swimming in is an action applying to one thing. Understand "swim in [something]" or "dive in/into [something]" as swimming in. Understand "swim" or "dive" as swimming in.

Rule for supplying a missing noun while an actor swimming in (this is the try to swim in visible lakes rule):
	if a liquid lake is visible:
		now the noun is a random visible liquid lake; 
	otherwise:
		say "[There's] nothing sensible to swim in." (A);
		rule fails.

Check an actor swimming in a liquid lake (this is the block swimming in liquid lakes rule):
	if the player is the actor:
		say "[We] [don't] feel like a dip in [the noun] just [if story tense is present tense]now[otherwise]then[end if]." (A) instead;
	stop the action.

Check an actor swimming in a fluid container (this is the block swimming in small vessels rule):
	if the noun is a liquid lake:
		make no decision;
	if the player is the actor:
		say "[We] [wouldn't fit] in [the noun]." (A) instead;
	stop the action.

Check an actor swimming in something (this is the block swimming in random objects rule):
	if the noun is a liquid lake:
		make no decision;
	if the player is the actor:
		say "[The noun] [aren't] [if the noun is plural-named]things[else]something[end if] [we] [can] swim in." (A) instead;
	stop the action.

Chapter 3 - Liquid Stream

A liquid stream is a kind of liquid source.

Instead of an actor pouring a fluid container into a liquid stream (this is the no dumping in streams rule):
	if the noun is empty:
		if the player is the actor:
			say "[The noun] already [contain] nothing." (A) instead;
		stop the action;
	now the fluid content of the noun is null volume;
	if the player is the actor:
		say "[We] [dump] out [the noun] into [the second noun], where [they] [are] quickly washed away." (B);
		rule succeeds;
	otherwise if the actor is visible:
		say "[The actor] [dump] out [the noun] into [the second noun], where [they] [are] quickly washed away." (C);
		rule succeeds.

Instead of an actor inserting something into a liquid stream (this is the no inserting things into flowing water rule):
	if the player is the actor:
		say "[The second noun] [cannot contain] things." (A) instead;
	stop the action.

Instead of an actor inserting a fluid container into a liquid stream:
	try the actor filling the noun with the second noun.

Report an actor pouring a liquid stream into a fluid container (this is the report filling from a liquid stream rule):
	if the player is the actor:
		say "[We] [fill] [the second noun] up from [the noun]." (A) instead;
	stop the action.

Part 5 - Output

Chapter 1 - Examining

Definition: a fluid container is emptyable if it is not a liquid source.

The examining fluid containers rule is listed before the examine containers rule in the carry out examining rules.

This is the examining fluid containers rule:
	if the noun is not a fluid container:
		make no decision;
	if the noun is closed and the noun is not transparent:
		make no decision;
	say "[The noun] [fill description of the noun]" (A);
	if the description of the liquid of the noun is not "":
		say " [description of the liquid of the noun]" (B);
	say "[paragraph break]" (C);
	now examine text printed is true.

Chapter 2 - Searching

Report searching a fluid container (this is the just examine fluid containers rule):
	say "[The noun] [fill description of the noun][paragraph break]"  (A) instead.

Chapter 3 - Describing the Fullness of Activity

Section 1 - Fullness in general

Describing the fullness of something is an activity.

To say fill description of (sample cup - a fluid container):
	carry out the describing the fullness activity with the sample cup.

Rule for describing the fullness of a liquid source (called the sample lake) (this is the describe sources rule):
	say "[regarding the sample lake][offer] a ready supply of [liquid of the sample lake].[no line break]" (A)

Rule for describing the fullness of an empty fluid container (called the sample cup) (this is the describe empty containers rule):
	if the no trace amounts option is active:
		say "[regarding the sample cup][contain] nothing.[no line break]" (A);
	otherwise if the liquid of the sample cup is nonliquid:
		say "[regarding the sample cup][don't] contain even a trace of liquid.[no line break]" (B);
	otherwise: 
		say "[regarding the sample cup][contain] only a trace of [the liquid of the sample cup] at the bottom.[no line break]" (C).

Rule for describing the fullness of a non-empty graduated emptyable fluid container (called the sample cup) (this is the describe graduated containers rule):
	say "[regarding the sample cup][contain] [the fluid content of the sample cup] of [the liquid of the sample cup].[no line break]" (A); 

Section 2 - Fancy Fullness (for use with Assorted Text Generation by Emily Short)

Rule for describing the fullness of an ungraduated non-empty emptyable fluid container (called the sample cup) (this is the describe ungraduated containers rule):
	let percent be the fluid content of the sample cup times 100 divided by the fluid capacity of the sample cup;
	say "[are]" (A);
	if percent is less than 15:
		say " almost empty, except for a small amount" (B);
	otherwise if percent is greater than 84:
		say " almost full" (C);
	otherwise if the sample cup is full:
		say " full" (D);
	otherwise:
		say "[percent as a proportion] full" (E);
	say " of [the liquid of the sample cup].[no line break]" (F). 

Section 3 - Dull Fullness (for use without Assorted Text Generation by Emily Short)

Rule for describing the fullness of an ungraduated non-empty emptyable fluid container (called the sample cup) (this is the describe ungraduated containers rule):
	let percent be the fluid content of the sample cup times 100 divided by the fluid capacity of the sample cup;
	say "[are]" (A);
	if sample cup is full:
		say " full" (B);
	otherwise if percent is less than 25:
		say " mostly empty" (C); 
	otherwise if percent is greater than 75:
		say " mostly full" (D);
	otherwise:
		say " about half full" (E);
	say " of [the liquid of the sample cup].[no line break]" (F).  


Part 6 - Drinking

The block drinking rule is not listed in any rulebook.

The drinking action has a liquid called the liquid drunk.

Setting action variables for an actor drinking something (this is the setting liquid drunk rule):
	if the noun is a fluid container:
		now the liquid drunk is the liquid of the noun;

A fluid container can be preferred for drinking. A fluid container is usually not preferred for drinking.

Does the player mean drinking a preferred for drinking fluid container (this is the preferential drinking rule):
	it is very likely.

Does the player mean asking someone to try drinking a preferred for drinking fluid container (this is the preferential asking to drink rule):
	it is very likely.

Understand "drink from [fluid container]" as drinking.

Check an actor drinking a closed fluid container (this is the can't drink from closed sources rule):
	if the player is the actor:
		say "(first opening [the noun])[command clarification break]" (A);
	silently try opening the noun;
	if the noun is closed:
		stop the action.

Check an actor drinking something which is not carried by the actor (this is the prefer to carry drink sources rule):
	if the noun is fixed in place or the noun is scenery or the noun is part of something:
		make no decision;
	otherwise:
		if the player is the actor:
			say "(first taking [the noun])[command clarification break]" (A);
		silently try the actor taking the noun.

Check an actor drinking something which is not a fluid container (this is the can't drink things that aren't fluids rule):
	if the player is the actor:
		say "[The noun] [aren't] suitable to drink." (A) instead;
	stop the action.

Check an actor drinking an empty fluid container (this is the can't drink from empty containers rule):
	if the player is the actor:
		if the liquid of the noun is nonliquid:
			say "[The noun] [are] completely empty." (A) instead;
		otherwise:
			say "[regarding the noun][There's] no more [liquid drunk] in [the noun]." (B) instead;
	stop the action.

Definition: a fluid container is undrinkable:
	if the liquid of it can be drunk:
		no;
	yes.

Check an actor drinking an undrinkable fluid container (this is the can't drink noxious containers rule): 
	if the actor is the player:
		say "The [liquid drunk] [aren't] something [we] [can] drink." (A) instead;
	stop the action.

Use variable sip size translates as (- Constant VARIABLE_SIP; -). 

Carry out an actor drinking a fluid container (this is the standard drinking fluids rule):
	let swallowed amount be the sip size;
	if the variable sip size option is active:
		let max variation be ( sip size * 2) / 3;
		let variation be a random volume between null volume and max variation;
		if a random chance of 1 in 2 succeeds:
			increase swallowed amount by variation;
		otherwise:
			decrease swallowed amount by variation;   
	if the noun is emptyable:
		decrease the fluid content of the noun by the swallowed amount; 
		if the fluid content of the noun is less than null volume:
			now the fluid content of the noun is null volume;
	if the noun is empty and the no trace amounts option is active:
		now the liquid of the noun is nonliquid.
	
Report drinking a fluid container (this is the standard report drinking rule):
	say "[We] [take] a sip of [the liquid drunk][if the noun is empty], leaving [the noun] empty[end if]" (A);
	if the flavor of the liquid of the noun is not "":
		say ". [flavor of the liquid drunk][paragraph break]" (B);
	otherwise:
		say "." (C)

Report someone drinking a fluid container (this is the standard report someone drinking rule):
	say "[The actor] [take] a sip of [the liquid drunk][if the noun is empty], leaving [the noun] empty[end if]." (A)

Check an actor tasting an undrinkable fluid container (this is the can't taste noxious containers rule):
	if the actor is the player:
		say "The [liquid drunk] [aren't] something [we] [can] drink." (A) instead;
	stop the action.
	
Check tasting a closed fluid container (this is the can't drink from shut containers rule):
	if the actor is the player:
		say "(first opening [the noun])[command clarification break]" (A);
	silently try opening the noun;
	if the noun is closed:
		stop the action.

Check tasting a fluid container (this is the report flavors of drinks rule):
	if the flavor of the liquid of the noun is not "":
		say "[flavor of the liquid of the noun][paragraph break]" (A) instead;

[And to deal with the case where there might be multiple empty containers lying around: ]

Does the player mean drinking an empty fluid container (this is the discourage pointless drinks rule): 
	it is very unlikely.

Part 7 - Filling and Pouring

Chapter 1 - Filling

Understand the command "fill" as something new.

[Here we want Inform to prefer full liquid sources to other containers when it chooses an end to a player's unfinished or ambiguous command. And so:]

Understand "fill [fluid container] with/from [full liquid source]" as filling it with. 
Understand "fill [fluid container] with/from [non-empty fluid container]" as filling it with.
Understand "fill [fluid container] with/from [fluid container]" as filling it with.

[Both grammar lines point to the same ultimate outcome; the purpose of specifying both is to tell Inform to check thoroughly for full liquid sources before falling back on other fluid containers when making its decisions.]

Understand "fill [something] with/from [something]" as filling it with.

Understand "fill [something]" as filling it with.

Filling it with is an action applying to two things. 

Carry out an actor filling something with something (this is the convert filling to pouring rule): 
	try the actor pouring the second noun into the noun instead.

Rule for supplying a missing second noun while an actor filling (this is the assume matching source rule):
	repeat with possible source running through visible non-empty fluid containers:
		if the liquid of the possible source is the liquid of the noun and the possible source is not the noun:
			now the second noun is the possible source;
			rule succeeds;
	if the person asked can touch a liquid source (called the target source):
		now the second noun is the target source;
	otherwise:
		if the player is the person asked:
			say "[We] [have] to fill [the noun] with something specific." (A) instead;
		otherwise:
			say "You'll need to specify what to fill [the noun] with." (B)

Chapter 2 - Pouring

Understand "mix [non-empty fluid container] in/into/with [fluid container]" as pouring it into. 
Understand "pour [non-empty fluid container] in/into/on/onto [fluid container]" as pouring it into. 
Understand "empty [non-empty fluid container] in/into [fluid container]" as pouring it into.

Understand "mix [fluid container] in/into/with [fluid container]" as pouring it into. 
Understand "pour [fluid container] in/into/on/onto [fluid container]" as pouring it into. 
Understand "empty [fluid container] in/into [fluid container]" as pouring it into.

Understand "mix [something] in/into/with [something]" as pouring it into. 
Understand "pour [something] in/into/on/onto [something]" as pouring it into. 
Understand "empty [something] in/into [something]" as pouring it into.

Does the player mean pouring something into a liquid source (this is the discourage mixing with liquid source rule):
	it is unlikely.
Does the player mean pouring something into a fluid container which is not a liquid source (this is the encourage mixing in glasses rule):
	it is likely.

Pouring it into is an action applying to two things.
The pouring it into action has a liquid called the liquid poured.
The pouring it into action has a liquid called the liquid receiving.
The pouring it into action has a volume called the amount poured.

Setting action variables for pouring something into something (this is the setting liquid poured rule):
	if the noun is a fluid container:
		now the liquid poured is the liquid of the noun.

Setting action variables for pouring something into something (this is the setting liquid receiving rule):
	if the second noun is a fluid container:
		now the liquid receiving is the liquid of the second noun.

Setting action variables for pouring something into something (this is the setting amount poured rule):
	if the noun is a fluid container and the second noun is a fluid container:
		now the amount poured is the fluid capacity of the second noun minus the fluid content of the second noun;
		if the amount poured is greater than the fluid content of the noun:
			now the amount poured is the fluid content of the noun;

Check an actor pouring a closed fluid container into something (this is the can't pour from a closed noun rule): 
	if the player is the actor:
		say "(first opening [the noun])[command clarification break]" (A);
	silently try the actor opening the noun;
	if the noun is not open:
		rule fails.

Check an actor pouring something into a closed fluid container (this is the can't pour into a closed noun rule):
	if the player is the actor:
		say "(first opening [the second noun])[command clarification break]" (A);
	silently try the actor opening the second noun;
	if the second noun is not open:
		rule fails.

Check an actor pouring something which is not carried by the actor into something which is not carried by the actor (this is the can't pour two untouched things rule):
	if the noun is not fixed in place and the noun is not scenery and the noun is not part of something:
		if the player is the actor:
			say "(first taking [the noun])[command clarification break]" (A);
		silently try the actor taking the noun;
		if the actor does not carry the noun:
			rule fails;
		otherwise:
			make no decision;
	if the second noun is not fixed in place and the second noun is not scenery and the second noun is not part of something:
		if the player is the actor:
			say "(first taking [the second noun])[command clarification break]" (B);
		silently try the actor taking the second noun;
		if the actor does not carry the second noun:
			rule fails;
		otherwise:
			make no decision;
	if the player is the actor:
		say "[We] [need] to be holding at least one of [the noun] or [the second noun]." (C) instead;
	stop the action.

Check an actor pouring something into something (this is the can't pour without fluid containers rule):
	if the noun is not a fluid container:
		if the player is the actor:
			say "[We] [can't] pour [the noun]." (A) instead;
		stop the action;
	if the second noun is not a fluid container:
		if the player is the actor:
			say "[We] [can't] pour liquids into [the second noun]." (B) instead;
		stop the action.

Check an actor pouring something into the noun (this is the no pouring something into itself rule):
	if the player is the actor:
		say "[We] [can] hardly pour [the noun] into itself." (A) instead;
	stop the action.

Check an actor pouring an empty thing into something (this is the can't pour empties rule):
	if the noun is empty:
		if the actor is the player:
			if the liquid of the noun is not nonliquid:
				say "No more [liquid poured] [remain] in [the noun]."  (A) instead;
			otherwise:
				say "[The noun] [are] completely empty." (B) instead;
		stop the action.

Check an actor pouring something into a full fluid container (this is the can't overfill rule):
	if the second noun is full:
		if the actor is the player:
			say "[The second noun] [cannot] contain any more than it already holds." (A) instead;
		stop the action.

Carry out an actor pouring something into something (this is the standard carry out pouring rule):
	increase the fluid content of the second noun by amount poured;
	decrease the fluid content of the noun by amount poured;
	if the noun is empty and the no trace amounts option is active:
		now the liquid of the noun is nonliquid.

Report pouring it into (this is the standard report pouring rule):
	if the noun is scenery or the noun is fixed in place or the noun is part of something:
		say "[We] [fill] [the second noun] with [the liquid poured]" (A);
	otherwise:
		say "[We] [pour] [the liquid poured] into [the second noun]" (B);
	say "[if the noun is empty], leaving [the noun] empty[end if]" (C); 
	if the second noun is not full or the liquid of the second noun is not the liquid of the noun:
		say ". [run paragraph on]" (D);
		say "[regarding the second noun][They] [fill description of the second noun][paragraph break]" (E); 
	otherwise:
		say "." (F)

Report someone pouring something into something (this is the standard report someone pouring rule):
	if the noun is scenery or the noun is fixed in place or the noun is part of something:
		say "[The actor] [fill] [the second noun] with [the liquid poured]" (A);
	otherwise:
		say "[The actor] [pour] [the liquid poured] into [the second noun]" (B);
	say "[if the noun is empty], leaving [the noun] empty[end if]" (C); 
	if the second noun is not full or the liquid of the second noun is not the liquid of the noun:
		say ". [run paragraph on]" (D);
		try examining the second noun;
	otherwise:
		say "." (E)

Chapter 3 - Basic Mixtures

Section 1 - Allowing for Mixtures to Exist

Use mixed liquids translates as (- Constant MIXED_LIQUIDS; -). 

The liquid-mixture refusal is some text that varies. The liquid-mixture refusal is "[We] [don't] want to mix [the liquid of the noun] with [the liquid of the second noun]."

Check an actor pouring something into something (this is the might mix substances rule):
	if the liquid of the noun is not the liquid of the second noun:
		if the second noun is empty:
			now the liquid of the second noun is the liquid of the noun;
		otherwise unless the mixed liquids option is active:
			if the player is the actor:
				say "[The liquid-mixture refusal][paragraph break]" instead;
			stop the action.

Carry out an actor pouring something into something when the mixed liquids option is active (this is the carry out mixing substances rule):
	if the liquid poured is not the liquid of the second noun and the second noun is non-empty:
		now the liquid of the second noun is the resulting liquid.

Section 2 - New Pouring Rules

The pouring it into action has a liquid called the resulting liquid.

Last setting action variables for pouring something into something when the mixed liquids option is active (this is the establish mixture rule):
	if the noun is not a fluid container:
		make no decision;
	if the second noun is not a fluid container:
		make no decision;
	if the liquid poured is not the liquid of the second noun: 
		if amount poured is greater than null volume and the second noun is non-empty:
			let L be the liquid produced by the liquid-mixing rules for the amount poured;
			now the resulting liquid is L.

Section 3 - Liquid-mixing Rulebook

The liquid-mixing rules are a volume based rulebook producing a liquid.
The liquid-mixing rulebook has a fluid container called the destination container.
The liquid-mixing rulebook has a list of liquids called the recipe contents. 
 
First liquid-mixing rule for a volume (called the poured volume) (this is the assign quantities while mixing rule): 
	now the destination container is the second noun;
	add the liquid of the noun to the recipe contents;
	add the liquid of the second noun to the recipe contents;
	sort the recipe contents;  

A liquid-mixing rule (this is the keep the same recipe as before rule):
	[If we add more of an existing component to the mix, there is no change]
	repeat through the Table of Liquid Mixtures:
		if the liquid of the second noun is the result entry:
			let L be the mix-list entry;
			repeat with item running through L:
				if the liquid of the noun is the item:
					rule succeeds with result the liquid of the noun.

A liquid-mixing rule (this is the create mixtures rule):
	[otherwise, we must look up the combination in our recipe book] 
	repeat through the Table of Liquid Mixtures:
		sort the mix-list entry;
		if mix-list entry is the recipe contents:
			rule succeeds with result the result entry.

Last liquid-mixing rule (this is the default conversion of liquids rule):
	[If we can't locate a valid mixture of liquids, set the second noun to use the same liquid as the first]
	rule succeeds with result the liquid of the noun.

Section 4 - Initial Table of Liquid Mixtures

Table of Liquid Mixtures
mix-list (a list of liquids)	result (a liquid)
--	--
 

Chapter 4 - Unsuccessful Attempts 

Unsuccessful attempt by someone pouring something into something (this is the explain unsuccessful pouring rule):
	if the reason the action failed is:
		-- the can't pour from a closed noun rule:
			say "[The actor] [can't] pour from [the noun] when [they] [are] closed." (A);
			rule succeeds;
		-- the can't pour two untouched things rule:
			say "[The actor] [can't] quite get [the noun] and [the second noun] into the right configuration for pouring." (B);
			rule succeeds;
		-- the can't pour without fluid containers rule:
			if the noun is not a fluid container:
				say "[The noun] [aren't] something that can be poured." (C);
				rule succeeds;
			if the second noun is not a fluid container:
				say "[The second noun] [aren't] something that can be poured." (E);
				rule succeeds;
		-- the no pouring something into itself rule:
			say "[The actor] [can] hardly pour [the noun] into [if the noun is plural-named]themselves[otherwise]itself[end if]." (F);
			rule succeeds;
		-- the can't pour empties rule:
			say "No more [liquid of the noun] [remain] in [the noun]." (G);
			rule succeeds;
		-- the can't overfill rule:
			say "[The second noun] [cannot] contain any more than [they] already [hold]." (H);
			rule succeeds;
		-- the might mix substances rule:
			say "[The liquid-mixture refusal][paragraph break]" (I);
			rule succeeds;
	make no decision.

Unsuccessful attempt by someone drinking something (this is the explain unsuccessful drinking rule):
	if the reason the action failed is:
		-- the can't drink things that aren't fluids rule:
			say "[The noun] [aren't] suitable to drink." (A);
			rule succeeds;
		-- the can't drink from empty containers rule:
			say "[The noun] [contain] nothing." (B) instead;
			rule succeeds;
		-- the can't drink noxious containers rule:
			say "The [liquid of the noun] [aren't] something [the actor] [can] drink." (C);
			rule succeeds.


Measured Liquid ends here.

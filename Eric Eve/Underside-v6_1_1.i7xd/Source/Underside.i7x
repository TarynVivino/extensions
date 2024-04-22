Version 6.1.1 of Underside by Eric Eve begins here.
   
"Allows objects to be put under other objects. An underside usually starts out closed so that its contents are hidden from view. Requires Version 7 (or later) of Bulk Limiter; the space under objects is limited by bulk. Underside is compatible with Version 10 or later of Implicit Actions, but does not require it. Version 5 of Underside avoids features deprecated in Version 6E59 of Inform."

[ 6/210627: fixed small error preventing compilation when Implicit Actions was included ]

Part 1 - Includes

Include Version 9 of Bulk Limiter by Eric Eve. 

Part 2 - The Underside Kind

An underside is a kind of container. The carrying capacity of an underside is usually 10000. [limit by bulk rather than quantity]
An underside is usually closed. [so that it conceals its contents]
An underside is usually privately-named [players should never need to refer to these objects directly.]

The printed name of an underside is normally "[printed name of the holder of the item described]"

The specification of underside is "An underside is a special kind of container that represents the space under an object. To use it, define an object of kind underside and make it a part of the thing you want to be able to put things under."


Part 3 - Looking Under

This is the clever looking under rule:
   if an underside (called the underpart) is part of the noun and something is in the underpart begin;
      now the underpart is open;      
      say "Under [the noun] [is-are a list of things in the underpart]." (A);   
   otherwise;
      follow the standard looking under rule;
   end if.

The clever looking under rule is listed instead of the standard looking under rule in the carry out looking under rules.

Part 4 - Placing Under

Chapter 1 - Action Definition

Placing it under is an action applying to two things.
Understand "put [things preferably held] under/beneath/underneath [something]" as placing it under.

The placing it under action has an object called the u-side.

Setting action variables for placing something under something:
   Now the u-side is a random underside that is part of the second noun.

Chapter 2a - Before and Precondition Rules  (for use with Implicit Actions by Eric Eve)

Before placing something under something (this is the take before placing under rule):
  if the u-side is not nothing and the noun is in the u-side,
     say "[The noun] [are] already under [the second noun]." (A) instead;
  
Precondition for placing something under something (this is the placing under precondition rule):
   if the noun is not carried, carry out the implicitly taking activity with the noun;
   if the noun is not carried, stop the action.


Chapter 2b - Before Rules  (for use without Implicit Actions by Eric Eve)

Before placing something under something (this is the take before placing under rule):
  if the u-side is not nothing and the noun is in the u-side,
     say "[The noun] [are] already under [the second noun]." (A) instead;
  if the noun is not carried begin;
      let actdesc be "trying to take";
      if the player can touch the noun and the noun is portable, let actdesc be "taking";
      say "(first [actdesc] [the noun])[command clarification break]" (B);
      silently try taking the noun;
   end if;
   if the noun is not carried, stop the action.

Chapter 3 - Check, Carry Out and Report

Check an actor placing something under the noun (this is the can't put anything under itself rule):
  say "Nothing can go under itself." (A) instead.


Check placing something under something (this is the can't put under any old thing rule):
  if the u-side is not an underside,  say "[We] [can't] put anything under [the second noun]." (A) instead.

Check someone placing something under something  (this is the someone can't put things under any old thing rule):
  if the u-side is not an underside,  stop the action.

Check an actor placing something under something (this is the test bulk underneath rule):
  if u-side is an underside and u-side provides the property bulk capacity begin;
     if the bulk of the noun > the bulk capacity of u-side,
        say "[The noun] [are] too big to fit under [the second noun]." (A) instead;
     if the bulk of the noun > the free capacity of u-side,
        say "[There] [are not] enough room left under [the second noun] for [the noun]." (B) instead;
  end if.

Carry out an actor placing something under something (this is the standard place under rule):
   move the noun to the u-side.

Report an actor placing something under something (this is the standard report place under rule):
  say "Done." (A).

Part 5 - Phrases for Under

To move (obj - an object) under/underneath (targetobj - a thing), making it hidden:
   if the targetobj encloses an underside (called the underpart) which is part of the targetobj begin;
      move the obj to the underpart;
      if making it hidden, now the underpart is closed;
   end if.

To decide whether (obj - an object) is contained under/underneath/beneath (targetobj - a thing):
    if the targetobj encloses an underside (called the underpart) which is part of the targetobj,  decide on whether or not the obj is in the underpart;
    decide no.

To decide which object is the associated/attached/appropriate underside of (obj - a thing):
    if an underside (called underpart) is part of obj, decide on underpart;
    decide on nothing.

Chapter 5a - Being Notionally Under (for use without Hiding Under by Eric Eve)

Notionally-underlying relates  a thing (called X) to a thing (called Y) when X is contained under Y.


Chapter 5b - Being Notionally Under (for use with Hiding Under by Eric Eve)

Notionally-underlying relates  a thing (called X) to a thing (called Y) when X is contained under Y or X is hidden under Y.


Chapter 5c - Notionally Under Verbs

The verb to be under implies the notionally-underlying relation.

Part 6 - Finding after Taking (for use without Hiding Under by Eric Eve)

To say previously-hidden-under (obj - a thing): say "hidden underneath".

To say reveal-hidden-under (obj - a thing):
  let underpart be a random underside that is part of the obj;
  say "Taking [the obj] reveals [a list of things in the underpart] [previously-hidden-under the noun].";

The taking action has an object called the place taken from.

Setting action variables for taking:
now the place taken from is the holder of the noun.

After taking something when an underside (called the underpart) is part of the noun  (this is the reveal what was underneath when taking rule):
  if something is in the underpart begin;
	 say reveal-hidden-under the noun;
 	 now everything in the underpart is in the place taken from;
  otherwise;
	continue the action;
  end if.
 
Part 7 - Conclusion

Underside ends here.

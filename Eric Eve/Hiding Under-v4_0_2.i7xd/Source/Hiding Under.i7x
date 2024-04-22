Version 4.0.2 of Hiding Under by Eric Eve begins here.

"Allows things to be hidden under other things, using a many-to-one underconcealment relation. Can be used either standalone (with basic functionality) or in conjunction with Underside (to add fuller functionality to both extensions)."

Part 1 - The Underconcealment Relation

Underconcealment relates various things to one thing.

The verb to be hidden under implies the underconcealment relation.

Part 2 - Phrases

To hide (hide_obj - a thing) under/beneath/underneath (under_obj - a thing):
   remove hide_obj from play;
   now hide_obj is hidden under under_obj.

To say find-hidden-under (obj - a thing):
  say  "Under [the obj] [we] [find] [a list of things hidden under the obj]."

Part 3 - Extensions to Underside (for use with Underside by Eric Eve)

Check looking under something (this is the check for things hidden under rule):
   if an underside (called the underpart) is part of the noun begin;
      now everything hidden under the noun is in the underpart;
      now nothing is hidden under the noun;
   otherwise if something is hidden under the noun;
      now everything hidden under the noun is in the holder of the noun;
      say find-hidden-under the noun;     
      now nothing is hidden under the noun;    
      rule succeeds;
    end if.


Part 4 - Standalone Material (for use without Underside by Eric Eve)

Chapter 1 - Action Definition for Putting Under

Placing it under is an action applying to two things.
Understand "put [things preferably held] under/beneath/underneath [something]" as placing it under.

Check placing something under something (this is the standard can't put under rule):
  say "[We] [can't] put anything under [the second noun]." (A) instead.

[
   To allow putting something under something we could write an instead rule, e.g.:

	Instead of placing the pen under the desk:
		hide the pen under the desk;
		say "Done."  
]

Chapter 2 - Looking Under

This is the revised looking under rule:
   if something is hidden under the noun begin;      
      now everything hidden under the noun is in the holder of the noun;
	say find-hidden-under the noun;
      now nothing is hidden under the noun;   
   otherwise;
      follow the standard looking under rule;
   end if.

The revised looking under rule is listed instead of the standard looking under rule in the carry out looking under rules.


Part 5 - Common Grammar

Understand "hide [things preferably held] under/beneath/underneath [something]" as placing it under.


Part 6 - Taking something that hides something underneath

Chapter 1 - Common Material

The taking action has an object called the place taken from.

Setting action variables for taking:
now the place taken from is the holder of the noun.

After taking something when something is hidden under the noun (this is the reveal what's underneath when taking rule):
  say reveal-hidden-under the noun;
  now everything hidden under the noun is in the place taken from;
  now nothing is hidden under the noun.

To say previously-hidden-under (obj - a thing): say "hidden underneath".

To say reveal-hidden-under (obj - a thing):
  say "Taking [the noun] reveals [a list of things hidden under the noun] [previously-hidden-under the noun].";

Chapter 2 - Additional rule for use with Underside (for use with Underside by Eric Eve)

[ The following rule adds anything in the underside to the list of things that will be revealed by the reveal what's underneath when taking rule. ]

Carry out taking something when an underside (called the underpart) is part of the noun (this is the prepare to reveal what's underneath when taking rule):
  now everything in the underpart is hidden under the noun.



Hiding Under ends here.


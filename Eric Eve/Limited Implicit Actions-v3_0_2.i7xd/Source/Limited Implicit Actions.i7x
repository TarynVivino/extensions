Version 3.0.2 of Limited Implicit Actions by Eric Eve begins here.
"A cut-down version of Implicit Actions for use where code size may be restricted and the full functionality of Implicit Actions is not needed. Compatible with Locksmith by Emily Short."

Volume 1 -  Implicit Action Framework


[ We use the same basic framework as for the full implicit actions extension ]

Book 1 - The Precondition Rulebook

ignore_preconditions is a truth state that varies. ignore_preconditions is false.

The precondition rules are a rulebook. 

This is the precondition stage rule:   abide by the precondition rules.
   

The precondition stage rule is listed before the basic accessibility rule in the action-processing rules.

Book 2 - Activities

Part 1 - Implicit Taking

Rule for implicitly taking something (called the object desired) (this is the implicit taking rule):  
  let actdesc be "trying to take";
  if the object desired is portable and the object desired is touchable, let actdesc be "taking";
  say "(first [actdesc] [the object desired])[command clarification break]" (A);
  silently try taking the object desired.  
  

Part 2 - Implicit Opening

Implicitly opening something is an activity.

The last for implicitly opening something (called the obstructor) (this is the implicit opening rule):
   let actdesc be "trying to open";
   if the obstructor is touchable and the obstructor is openable and the obstructor is unlocked, let actdesc be "opening";
   say "(first [actdesc] [the obstructor])[command clarification break]" (A);
   silently try opening the obstructor;  
   
Part 3 - Implicit Exiting

implicitly exiting something is an activity.

The last for implicitly exiting something (called the nested room)  (this is the implicit exiting rule):
  say "(first leaving [the nested room])[command clarification break]" (A);
  silently try exiting.


Book 3 - Preconditions

Precondition for putting something on something when the noun is not carried (this is the take object before putting it on rule):
  if the noun is on the second noun,
    say "[The noun] [are] already on [the second noun]."  (A) instead;
 carry out the implicitly taking activity with the noun;
 if the noun is not carried, stop the action.

Precondition for inserting something into something when the noun is not carried (this is the take object before inserting it into rule):
  if the noun is in the second noun,
    say "[The noun] [are] already in [the second noun]." (A) instead;
 carry out the implicitly taking activity with the noun;
 if the noun is not carried, stop the action.

Precondition for inserting something into something when the second noun is an openable closed container (this is the open container before inserting rule):
  carry out the implicitly opening activity with the second noun;
  if the second noun is closed, stop the action.

Precondition for searching a closed openable opaque container (this is the open container before searching rule):
  carry out the implicitly opening activity with the noun;
  if the noun is closed, stop the action.

Precondition for taking something when the noun is inside a closed container (called the receptacle) (this is the open before taking contents rule):
  carry out the implicitly opening activity with the receptacle;
  if the receptacle is closed, stop the action.

Precondition for going from a room when the holder of the player is not a room (this is the exit holder before leaving room rule):
  while the holder of the player is not a room begin;
      let loc be the holder of the player;      
      carry out the implicitly exiting activity with loc;
      if the holder of the player is loc, break;
   end while;
  if the holder of the player is not a room, stop the action.


Limited Implicit Actions ends here.

Version 3.2.1 of Easy Doors by Hanon Ondricek begins here.

"Easy Doors provides a new kind of door which does not use map connections, and may be manipulated via rules more flexibly than the standard doors provided in Inform 7.  Version 3 removes elements for compatibility with 6M62"

[Removed the I6 "perform" dropin as it no longer consistently functions properly under 6M62]

An easydoor is a kind of thing.
An easydoor is usually fixed in place.
An easydoor can be enterable.  An easydoor is usually enterable.
An easydoor can be scenery.
An easydoor can be openable or unopenable. An easydoor can be open or closed.  An easydoor is usually openable.
An easydoor can be lockable.  An easydoor can be locked or unlocked.

An easydoor has a text called dooraction.  The dooraction of an easydoor is usually "".

The description of an easydoor is usually "[The noun] [are] [if open]open[otherwise]closed[end if]."

Understand "[easydoor]" as entering.

Roomconnecting relates one room (called the outpoint) to various things.

The verb to lead to implies the reversed roomconnecting relation.

Portalling relates one easydoor (called the doorfriend) to another.

The verb to portal implies the portalling relation.

Understand "door/doorway" as an easydoor.

Before an actor entering an easydoor (called D) (this is the implicitly open easydoors rule):
	if D is closed:
		try the person asked opening D.
	
Check an actor entering an easydoor (this is the can't enter a locked easydoor rule):
	if the noun is locked:
		stop the action.
	
After entering an easydoor (this is the say dooraction and move the player rule):
	if dooraction of noun is "":
		say "[dooraction of noun][run paragraph on]" (A);
	otherwise:
		say "[dooraction of the noun][line break]" (B);
	now the player is in the outpoint of the noun.
	
After someone entering an easydoor (called D) (this is the NPC uses easydoor rule):
	say "[The person asked] [go] through [the D]." (A);
	now the person asked is in the outpoint of the noun.
	
Check an actor entering a portable easydoor (called D) (this is the we are not MC Escher rule):
	if the the person asked carries D:
		say "[The person asked] [can't] enter [the D] while holding it." (A);
		stop the action.
	
Check entering an easydoor (this is the disallow entering easydoors with no outpoint rule):
	if the outpoint of the noun is nothing:
		if the dooraction of the noun is "":
			say "[The noun] [don't] lead anywhere." (A);
		otherwise:
			say "[dooraction of the noun][line break]" (B);
		stop the action.
		
Check someone entering an easydoor (this is the disallow npc entering easydoors with no outpoint rule):
	if the outpoint of the noun is nothing:
		say "[The noun] [don't] seem to lead anywhere." (A);
		stop the action.
	
Carry out an actor opening an easydoor (called D) (this is the open doorfriend rule):
	now the doorfriend of D is open.
	
Carry out an actor closing an easydoor (called D) (this is the close doorfriend rule):
	now the doorfriend of D is closed.
	
Carry out an actor unlocking an easydoor (called D) with something (this is the unlock doorfriend rule):
	now the doorfriend of D is unlocked.
	
Carry out an actor locking an easydoor (called D) with something (this is the lock doorfriend rule):
	now the doorfriend of D is locked.
	
Before an actor unlocking an easydoor with something (called K):
	If K unlocks the doorfriend of the noun:
		now K unlocks the noun.  
		
Before an actor locking an easydoor with something (called K):
	If K unlocks the doorfriend of the noun:
		now K unlocks the noun. 
	
Volume 1 - Not for release

When play begins:
	repeat with D running through easydoors:
		if D leads to nothing:
			say "*** CAUTION - [bold type][The D][roman type] in [bold type][the location of D][roman type] does not lead anywhere!!! ***[paragraph break]"
	
	

Easy Doors ends here.

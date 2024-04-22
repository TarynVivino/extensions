Chapter : Introduction

Doors as implemented in Inform 7 are limited and sometimes frustrating to use since they must connect two rooms using map directions.  They can thwart some architectural and magical realism: they cannot be moved during play, and they cannot change their destination.  We cannot have an enterable broom closet on the same wall as a map direction.  Doors cannot be part of an object, or inside an enterable container.

Easy Doors is a small extension that provides a new kind called "easydoor". These behave like normal doors and can be placed anywhere, providing one-way, directionless transport to any location in the game world.  Easydoors can be moved around the map, on and off-stage, and can change what location they lead to at the author's whim using normal rules.  Since easydoors do not require directional hookups on the map, they are very simple to implement.

Section : Update Log

2016.04-25 - Removed "perform" functionality as it no longer operates consistently in 6M62 and using it with certain actions cause a compiler error with no specific indication what caused the error.  Functionality can be duplicated using the "carry out" phase of entering an easydoor as explained below.

Section : Acknowledgements

Thanks to Carolyn VanEseltine and Jason Lautzenheimer for suggestions about door behaviors.  Also to Daniel Stelzer and Andrew Schultz for assistance and advice and testing.

Please feel free to email hanon.ondricek@gmail.com with any feedback, questions, or bug reports.

Chapter : Creating Easydoors

Easydoors can be created and placed wherever we want.  They behave in the expected way a door would, by default fixed in place, openable and closed.  We can declare them also lockable and locked or unlocked (unlocked is default) and create keys to unlock them.  We can make them open and unopenable to simulate stairs or an open passage.  We also specify where an easydoor leads to when a player enters one.

Section : One-Way Easydoors

	The front door is an easydoor in Porch.  It leads to Foyer.
	
This is the minimum code for a working easydoor.  We can of course give our easydoor an initial appearance, a description (the default just says whether the door is closed or open) and use all of the normal rules for opening and closing and locking.  (The exception to be careful with is AFTER ENTERING - see the section later for details.)

	An iron grating is an easydoor in Dungeon Mouth.  It leads to Dungeon Throat.  It is lockable and locked.
	The dungeon key unlocks iron grating.  Dungeon key is carried by the fearsome ogre.
	
	A windy passage is an easydoor in Dungeon Throat.  "A windy passage leads deeper into the dungeon."  It is unopenable and open.  It leads to Dungeon Lungs.
	
Notice none of these specify compass directions.  We can place as many doors in a location as we wish.  The player can enter an easydoor and be transported to the location it leads to by using any synonym of the entering action, or by typing the name of an easydoor as if it were a direction.

	>ENTER FRONT DOOR
	>GRATING
	>GO THROUGH WINDY PASSAGE
	
If the easydoor is closed and not locked, the parser will open it implicitly.  If it is locked, the player will be informed and not allowed to open it until they find a key.
	
We can simulate that an easydoor leads in a direction by redirecting the player's input to the entering action.

	A revolving door is an easydoor in Plaza.  "The department store's revolving door slices and dices holiday shoppers to the north."  It is unopenable and open.  It leads to Women's Shoes.  The description of revolving door is "It makes you sort of ill to watch it for too long."
	
	Instead of going north in Plaza: try entering revolving door.
	
Section : Two-Way Doors

Since easydoors traverse only one way, we might wish to provide the other half of the door so there is a two-way connection.

	some automatic doors are an easydoor in Women's Shoes.  "You note some automatic doors to the south that lead back out into the street."  It leads to Plaza.  The dooraction is "At least you don't have to contend with the revolving door this time as glass panels are whisked aside automatically for you."
	
	Instead of going south in Women's Shoes:
		try entering automatic doors.
		
Section : Portalling Two Easydoors as One

When we are simulating both sides of a door with two separate easydoors, we would like them to stay in sync with regard to locking,  unlocking, opening and closing.  We do that by connecting them with the portalling relation, which is reciprocal and only needs to be declared on one of the matching portals.

	The coaster security gate is an easydoor in Midway.  It is lockable and locked.  It leads to Roller Coaster.  The description is "Through the chain link, you can see the wooden supports of the roller coaster."  Understand "chain/link" as security gate.
	
	The gate back to the midway is an easydoor in Roller Coaster.  "A gate here appears to lead back to the midway."  The description is "It's the back side of that security gate you saw earlier."  It leads to midway.  It portals coaster security gate.  Understand "security" as gate back to midway.
	The passkey unlocks coaster security gate.  Passkey is on security guard's corpse.
	
This will ensure that if we unlock the security gate from one side but slip into the Roller Coaster grounds by other means, when we encounter the allegedly same gate from the other side that it will also be unlocked.  It also allows the same key to lock and unlock the other half of the portalled door.

Section : Dooraction

Every easydoor contains a text called "dooraction" which can optionally be used to provide some descriptive text when the player moves through the door.

	a spiral staircase is an open, unopenable easydoor in Minimalistic Apartment. It leads to Loft.  the dooraction of spiral staircase is "Your knees complain as you climb the wrought iron twists of this contraption."

	a time machine is an open, unopenable easydoor in Laboratory. "A humming time machine sits in the corner, the passage into it glowing expectantly."  It leads to Swirly Void.  The dooraction of time machine is "All right.  Here goes."
		
The dooraction should encompass the actual traversal of the door.  The opening and closing are separate actions and shouldn't necessarily be included in the dooraction.

	a crypt door is an openable easydoor in Graveyard.  It leads to Inner Tomb.  The dooraction is "As you cross the threshold, a cold wind ruffles your hair.".
	
	After an actor opening crypt door, say "The door of the crypt creaks open."
	After an actor closing crypt door, say "The crypt door bangs shut."
	
Section:  After Entering an Easydoor

In most cases, we should not override the AFTER ENTERING rules affecting an easydoor, as this is where the player is moved to the location that the door leads to (called an "outpoint" in code).  Should you need to do anything fancy when an easydoor is traversed, The best place to work it out is in the carry out phase of entering.

	A revolving door is an easydoor in Plaza.  "The department store's revolving door slices and dices holiday shoppers to the north."  It is unopenable and open.  It leads to Women's Shoes.  The description of revolving door is "It makes you sort of ill to watch it for too long."  The dooraction of revolving door is "You are whirled for several minutes[if the player encloses a mitten], losing a mitten in the process[end if].  Finally you are through and your shopping can begin!"
	
	Carry out entering revolving door:
		if the player encloses a mitten:
			now a random mitten enclosed by the player is off-stage.
	
If you decide you need to use the after rules, you should ensure that you move the player to the outpoint of the easydoor as well.

Easy Doors usually lead to a room.  Altering the AFTER ENTERING rules would be one way to, for whatever reason, have a door lead to the inside of an enterable container or onto a supporter.  Take care with this, as getting your player stuck inside an object or in a backdrop might have strange consequences.  An example is provided below.

Section : Portable Doors

Easydoors are usually immobile as far as the player is concerned, although the author can move them as part of gameplay using rules.  An easydoor can be declared portable, leading to wild effects.

	A round black hole is an easydoor carried by the player.  It is portable.  It leads to Phobos.
	
A portable door must be dropped before it can be entered, of course, because carrying a door through itself would break even imaginary laws of physics and cause your game to collapse into itself and wink out of existence.

	Carry out turning the Infinite Improbability dial:
		now round black hole leads to Magrathea.

Chapter : Debug

An easydoor without a destination (in code, an "outpoint") would transport the player off-stage, which could cause all kinds of nasty effects.  When a game is run in the Inform IDE, easydoors without outpoints will be flagged when play begins.

We may have good reason to have a destination-less door (as shown in the example below) and can ignore these warnings which will not appear in a published game.  This is provided to notify the author in case of inadvertently forgetting to include a destination for an easydoor.  Instead of recklessly transporting the player offstage, the extension will inform the player that the door leads nowhere, and change the outpoint of the easydoor to its own location should the player try again.

Chapter : NPCs, and Pathfinding

Easy Doors can handle an NPC character manipulating and entering an easydoor if manually told to in rules by the author, or by a player if persuasion succeeds.  Unfortunately Inform's automatic pathfinding ("The best route from A to B") will not take easydoors into account.  Any route to a location will detour around an easydoor if there is another way using regular map connections and doors, or will fail as "nothing" if an easydoor is the only route.

If our game relies on routefinding and autonomous NPCs, some suggestions are:
	
A: Create the world with map connections and regular doors where we need NPCs to travel, reserving easydoors for special cases. (In TRANSPARENT, there is a map connection between the study and the library that ghosts can use, but the player is directed from the map connection through an easydoor, which might be locked.)

B: Divide the map into regions that easydoors connect, and have Inform find "The best route from A to (an easydoor)."  Once arrived, have the NPC try entering the easydoor and continue their route to a destination.

C: Find plot reasons to teleport the NPCs.

Hopefully if our game involves traveling NPCs and extended logic to move them, we are skilled enough to manage within the limitations of this extension, or modify it to suit.

A vague caution:  This extension is designed to help authors solve some door problems, and create special effects.  While it can be used to make an entire game full of non-traditional map traversal, it has not been stress-tested with hundreds of portaling doors in a game.  Some memory limitations and weirdness might be encountered if we are using this extension to write a game called "Maze of a Million Doors".


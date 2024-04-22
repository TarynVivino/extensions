Foreword: This is an optimized version of Epistemology by Eric Eve (version 9). I created it for use in very large games (hundreds of objects), where the original code might detectably bog down. This version is meant as a drop-in replacement.

Like the original Epistemology, this version only marks objects "seen" when you look around, open a container, or examine something. (Or move to a different room, which invokes LOOK.) This means that objects which are moved into a room might not be "seen" until the player does LOOK or EXAMINE.

This version differs from the original in a couple of minor ways:

- When you open a container, all objects in the room (not just the container) are marked "seen". (This should be fine, since objects in the room should already have been seen when you walked in.)

- When you LOOK or OPEN, objects added to scope (with the "deciding the scope of" activity) are marked "seen". The original Epistemology did not do this.

- The phrase "familiarize (thing)" is provided to mark a thing as both "seen" and "familiar". You can also do "observe-all-in-scope" to re-scan the entire room.

If you want to be certain about marking every object that appears, you can add this rule, at the expense of some game speed:

Every turn: observe-all-in-scope.

--- ORIGINAL DOCUMENTATION ---

The purpose of this extension is to keep track of what objects the player character knows about, either because s/he has seen them, or because they are already familiar for some other reason. It is not intended as a way to track NPC knowledge, which might be better implemented using a system of relations.

When the Epistemology extension is used all game objects are either seen or unseen, either familiar or unfamiliar, and either known or unknown. By default, all objects start unseen and unfamiliar, and hence unknown (although we can of course change this for indivdual objects, groups of objects or kinds). The seen/unseen and familiar/unfamiliar pairs can be tested or set as requires. The known/unknown status may be tested but not directly changed in code, since it derives from the other two: a thing is considered to be known if it is either seen or familiar; otherwise it is unknown.

These distinctions are maintained since the player character may well know about things he or she is yet to see (such as the Magical Golden Golf Ball of Destiny that she has been sent to recover) or are which are in any case unseeable (such as love, freedom, democracy and inflation) which may nevertheless be the subject of conversation or thoughts. Things that are known about but as yet unseen or entities that are abstract can be marked as familiar, either from the outset, or when the player learns about them during the course of the game. Also, there may be cases where it's important to distinguish whether the player character has actually seen the Golden Golf Ball (say) or merely knows about it.

The new kind called subject is provided for more abstract objects such as love and atomic physics. Unlike other things, subjects are considered familiar by default.

As far as possible, the extension tries to keep track of what the player character has seen, first by marking as seen (and familiar) everything that's in plain view in the location when a LOOK command is executed, and second eveything in plain view within a container when that container is opened. The algorithm for doing this may be less than perfect (in the interests of acceptable speed), and there will be cases that it does not cover (for example when an object is moved into the location to simulate its being found under the rug); in such cases it will be necessary explicitly to change the newly-arrived object to seen in our code (if we need to keep track of it).

This extension also marks an object as both seen and familiar when it is examined (which should catch most, if not all, the cases not already covered).

Finally, the testing command EPISTAT X (not for release) is provided to aid testing and debugging games using this extension. For example the command EPISTAT GOLD BALL will show whether the gold ball is seen, familiar or known. This may be useful to help track whether the epistemic status of various objects in our game is actually what we think it should be. EPISTAT (derived from EPIstemic STAtus) is indeed a nasty non-word, but it has the merits of being (a) reasonably brief, (b) acceptably memorable and (c) unlikely to clash with any verbs defined in-game.

(With thanks to Aaron Reed for suggesting some optimization, which also led me to spot a bug.)


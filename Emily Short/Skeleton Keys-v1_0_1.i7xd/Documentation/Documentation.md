This extension replaces the default behavior of Inform, which allows one key per lock, with a more generous system in which unlocking applies to multiple objects. That means that it is possible to write a skeleton key like so:

	Every door is unlocked by the skeleton key.

Because it is possible for more than one key to unlock a given door, the property "matching key" is now meaningless.

The drawback to this arrangement is that it adds more information to every item in the game, which will mean using up several K of dynamic memory. This is not important when compiling to Glulx, but may be problematic for projects targeting the Z-machine.

Skeleton Keys is compatible with, but does not require, Locksmith by Emily Short.


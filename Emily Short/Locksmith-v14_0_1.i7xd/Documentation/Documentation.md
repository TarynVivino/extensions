Locksmith adds implicit handling of doors and containers so that lock manipulation is automatic if the player has the necessary keys.  There are five parts of Locksmith.

First, Locksmith will try opening all doors the player tries to pass through; try closing all lockables before locking them; and try unlocking all locked items before opening them. Other characters will follow the same rules.

By default, these actions are described as other automatic actions usually are in Inform: the player sees something like "(first unlocking...)" before he opens the door. The "Use sequential action" mode is provided for the case where we would prefer to see "You unlock the door." instead.

If the player tries to open a door but does not have the right key, he receives a key-refusal message, such as "You lack a key that fits the red chest." We can override this by writing other "to say key-refusal for..." phrases, like this:

	To say key-refusal for (locked-thing - a container):
		say "You will be unable to see the contents of [the locked-thing] until you find the appropriate key."

	To say key-refusal for (locked-thing - the red chest):
		say "The red chest resists all your attempts because you do not have the magic orb."

Second, Locksmith tries to provide an intelligent default if no key is specified, so that >LOCK DOOR will work if the player is holding the correct key.

Third, Locksmith introduces a kind called the passkey.  The passkey is a key which will name itself in inventory listings after use. Once the passkey has been identified, the game also automates taking the key before using it on the door it matches.  Keys the player has never successfully identified, or keys not defined as belonging to the passkey kind, will not behave this way. Passkeys are also renamed if the player has seen another character use them successfully.

The "unbolts" relation is used to keep track of what the player knows about keys. We will probably not need to do this in most cases, but it is possible to change this manually during play to give the player new knowledge (or ignorance) about the functions of keys.

Passkeys can also be used with the keychain kind. Keychains are portable supporters which can have passkeys (but only passkeys) put on them. Keys on a keychain can be used as though they were in the player's hand, and will not be automatically removed for locking and unlocking actions.

Finally, Locksmith provides the debugging command 'unlockall', only identified in debugging compilations of the game.  If during play we type UNLOCKALL, all locks in the game will magically spring open.

One thing Locksmith does not handle is allowing skeleton keys that unlock multiple locks. This functionality costs some memory overhead, so it is not included compulsorily in Locksmith, but if we want it, we can also include Skeleton Keys by Emily Short.


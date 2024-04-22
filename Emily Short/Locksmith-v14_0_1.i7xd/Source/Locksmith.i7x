Version 14.0.1 of Locksmith by Emily Short begins here.

"Implicit handling of doors and containers so that lock manipulation is automatic if the player has the necessary keys."

Use authorial modesty.

To open is a verb. To lack is a verb. To fit is a verb. To lock is a verb. To unlock is a verb.

Volume 1 - Automatic locking and unlocking with necessary actions

Use sequential action translates as a configuration flag.

Before going through a closed door (called the blocking door) (this is the opening doors before entering rule):
	if sequential action option is active:
		try opening the blocking door;
	otherwise:
		say "(first opening [the blocking door])[command clarification break]" (A);
		silently try opening the blocking door;
	if the blocking door is closed, stop the action.

Before locking an open thing (called the door ajar) with something (this is the closing doors before locking rule):
	if sequential action option is active:
		try closing the door ajar;
	otherwise:
		say "(first closing [the door ajar])[command clarification break]" (A);
		silently try closing the door ajar;
	if the door ajar is open, stop the action.
	
Before locking keylessly an open thing (called the door ajar) (this is the closing doors before locking keylessly rule):
	if sequential action option is active:
		try closing the door ajar;
	otherwise:
		say "(first closing [the door ajar])[command clarification break]" (A);
		silently try closing the door ajar;
	if the door ajar is open, stop the action.

Before opening a locked thing (called the sealed chest) (this is the unlocking before opening rule): 
	if sequential action option is active:
		try unlocking keylessly the sealed chest;
	otherwise:
		say "(first unlocking [the sealed chest])[command clarification break]" (A);
		silently try unlocking keylessly the sealed chest;
	if the sealed chest is locked, stop the action.
	
Before someone trying going through a closed door (called the blocking door) (this is the intelligently opening doors rule):
	try the person asked trying opening the blocking door;
	if the blocking door is closed, stop the action.
	
Before someone trying locking an open thing (called the door ajar) with something (this is the intelligently closing doors rule):
	try the person asked trying closing the door ajar;
	if the door ajar is open, stop the action.
	
Before someone trying locking keylessly an open thing (called the door ajar)  (this is the intelligently closing keyless doors rule):
	try the person asked trying closing the door ajar;
	if the door ajar is open, stop the action.
	
Before someone trying opening a locked thing (called the sealed chest) (this is the intelligently opening containers rule):
	try the person asked trying unlocking keylessly the sealed chest;
	if the sealed chest is locked, stop the action.

Volume 2 - Default locking and unlocking

Part 1 - The matching key rule

This is the need a matching key rule:
	if the person asked encloses something (called item) which unlocks the noun:
		now the second noun is the item;
		abide by the second noun must be accessible rule;
	otherwise if a visible passkey (called item) unbolts the noun: 
		now the second noun is the item;
		abide by the second noun must be accessible rule;
	otherwise:
		if the player is the person asked, say "[key-refusal for noun]";
		stop the action.

To say key-refusal for (locked-thing - an object):
	carry out the refusing keys activity with the locked-thing.

Refusing keys of something is an activity.

Rule for refusing keys of something (called locked-thing) (this is the standard printing key lack rule):
	say "[We] [lack] a key that fits [the locked-thing]." (A).

Definition: a thing is key-accessible:
	if the person asked carries it, yes;
	if it is on a keychain which is carried by the person asked, yes;
	no.

Part 2 - Unlocking

Section 1 - Regular unlocking

Understand the command "unlock" as something new. Understand "unlock
[something] with [something]" as unlocking it with. Understand "unlock [a
locked lockable thing] with [something]" as unlocking it with. Understand
"unlock [a lockable thing] with [something]" as unlocking it with.

Understand the commands "open" and "uncover" and "unwrap" as something new.
Understand "open [something]" or "uncover [something]" or "unwrap [something]"
as opening. Understand "open [something] with [something]" as unlocking it
with. Understand "open [a locked lockable thing] with [something]" as
unlocking it with. Understand "open [a lockable thing] with [something]" as
unlocking it with.

Check unlocking it with (this is the must be able to reach the key rule):
	abide by the second noun must be accessible rule.

The right second rule is listed instead of the can't unlock without the
correct key rule in the check unlocking it with rulebook.

This is the right second rule:
	if the second noun does not unlock the noun:
		say "[The second noun] [do not fit] [the noun]." (A) instead.

Section 2 - Keylessly

Understand "unlock [something]" as unlocking keylessly. Understand "unlock [a
locked lockable thing]" as unlocking keylessly. Understand "unlock [a lockable
thing]" as unlocking keylessly.

Unlocking keylessly is an action applying to one thing.
The unlocking
keylessly action has an object called the key unlocked with.

Check an actor unlocking keylessly (this is the check keylessly unlocking rule):
	abide by the can't unlock without a lock rule;
	abide by the can't unlock what's already unlocked rule;
	abide by the need a matching key rule;
	now the key unlocked with is the second noun.

Carry out an actor unlocking keylessly (this is the standard keylessly unlocking rule):
	if sequential action option is active:
		do nothing;
	otherwise if the person asked is the player:
		say "(with [the key unlocked with])[command clarification break]" (A);
	try the person asked unlocking the noun with the key unlocked with.


Part 3 - Locking

Section 1 - Regular locking

Understand the command "lock" as something new. Understand "lock [something]
with [something]" as locking it with. Understand "lock [an unlocked lockable
thing] with [something]" as locking it with. Understand "lock [a lockable
thing] with [something]" as locking it with.

Check locking it with:
	abide by the second noun must be accessible rule.

The right second rule is listed instead of the can't lock without the correct
key rule in the check locking it with rulebook.

Section 2 - Keylessly

Understand "lock [something]" as locking keylessly. Understand "lock [an
unlocked lockable thing]" as locking keylessly. Understand "lock [a lockable
thing]" as locking keylessly.

Locking keylessly is an action applying to one thing.
The locking keylessly
action has an object called the key locked with.

Check an actor locking keylessly (this is the check keylessly locking rule):
	abide by the can't lock without a lock rule;
	abide by the can't lock what's already locked rule;
	abide by the can't lock what's open rule;
	abide by the need a matching key rule;
	now the key locked with is the second noun.
	
Carry out an actor locking keylessly (this is the standard keylessly locking rule):
	if sequential action option is active:
		do nothing;
	otherwise if the person asked is the player:
		say "(with [the key locked with])[command clarification break]" (A);
	try the person asked locking the noun with the key locked with.

Volume 3 - The Passkey kind, needed only if you want keys to name themselves

A passkey is a kind of thing. The specification of a passkey is "A kind of key
whose inventory listing changes to reflect the player's knowledge about what
it unlocks."

Definition: a passkey is identified if it unbolts something.

Unbolting relates one passkey to various things.

The verb to unbolt means the unbolting relation.

After printing the name of an identified passkey (called the item) while
	taking inventory (this is the identify passkeys in inventory rule):
	now the prior named object is the item;
	say " (which [open] [the list of things unbolted by the item])" (A);
	
After examining an identified passkey (this is the passkey description rule):
	say "[The noun] [unlock] [the list of things unbolted by the noun]." (A).
	
Carry out unlocking something with a passkey (this is the standard passkey unlocking rule):
	if the second noun unlocks the noun, now the second noun unbolts the noun.
	
Report someone trying unlocking something with a passkey (this is the observe someone unlocking rule):
	now the second noun unbolts the noun.
	
Carry out locking something with a passkey (this is the standard passkey locking rule):
	if the second noun unlocks the noun, now the second noun unbolts the noun.

Report someone trying locking something with a passkey (this is the observe someone locking rule):
	now the second noun unbolts the noun.


Volume 4 - The Keychain kind, needed only if you want a keychain



A keychain is a kind of supporter that is portable. The specification of a
keychain is "A keychain which can hold the player's keys without forcing the
player to take them off the ring in order to unlock things."

Instead of putting something which is not a passkey on a keychain (this is the limiting keychains rule):
	say "[The noun] [are] not a key." (A).

The keychain-aware carrying requirements rule is listed instead
	of the carrying requirements rule in the action-processing rules.

This is the keychain-aware carrying requirements rule:
	if locking or unlocking something with something which is on a keychain which is carried by the actor:
		continue the action;
	abide by the carrying requirements rule.
 
Understand "put [passkey] on [keychain]" as putting it on.

Rule for deciding whether all includes passkeys which are on a keychain (this is the don't strip keys rule):
	if the second noun is not a keychain, it does not.

Volume 5 - Support Materials

This is the noun autotaking rule:
	if sequential action option is active:
		if the player is the person asked:
			try taking the noun;
		otherwise:
			try the person asked trying taking the noun;
	otherwise:
		carry out the implicitly taking activity with the noun;

This is the second noun autotaking rule:
	if sequential action option is active:
		if the player is the person asked:
			try taking the second noun;
		otherwise:
			try the person asked trying taking the second noun;
	otherwise:
		carry out the implicitly taking activity with the second noun.

This is the must hold the noun rule:
	if the person asked does not have the noun, follow the noun autotaking rule;
	if the person asked does not have the noun, stop the action; 
	make no decision.

This is the must hold the second noun rule:
	if the person asked does not have the second noun, follow the second noun autotaking rule;
	if the person asked does not have the second noun, stop the action;
	make no decision.

This is the noun must be accessible rule:
	if the noun is not key-accessible:
		if the noun is on a keychain (called the containing keychain), now the noun is the containing keychain;
		follow the noun autotaking rule;
	if the noun is not key-accessible:
		if the player is the person asked,
			say "Without holding [the noun], [we] [can] do nothing." (A);
		stop the action;
	make no decision.

This is the second noun must be accessible rule:
	if the second noun is not key-accessible:
		let the held second noun be the second noun;
		if the second noun is on a keychain (called the containing keychain),
			now the second noun is the containing keychain;
		follow the second noun autotaking rule;
		now the second noun is the held second noun;
	if the second noun is not key-accessible:
		if the player is the person asked,
			say "Without holding [the second noun], [we] [can] do nothing." (A);
		stop the action;
	make no decision.


Volume 6 - Unlocking all - Not for release

Understand "unlockall" as universal unlocking.

Universal unlocking is an action applying to nothing.

Carry out universal unlocking (this is the lock debugging rule):
	repeat with item running through locked things:
		now the item is unlocked;
		say "Unlocking [the item]." (A).

Report universal unlocking (this is the report universal unlocking rule):
	say "A loud stereophonic click assures you that everything in the game has been unlocked." (A).

Locksmith ends here.

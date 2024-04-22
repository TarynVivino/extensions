Version 2.0.230726 of Scope Caching by Mike Ciul begins here.

"Gives things the 'marked visible' property, to check the visibility of something without repeating the entire scope loop each time. Works with Epistemology by Eric Eve, Conditional Backdrops by Mike Ciul, and Remembering by Aaron Reed."

"based on code provided by Andrew Plotkin"

[and Jimmy Maher? http://www.intfiction.org/forum/viewtopic.php?f=7&t=3241&start=40]

Use authorial modesty.

Volume - Scope Caching

Chapter - Bugfix in PlaceInScope

Include (-
+replacing [ PlaceInScope O opts; ! If opts is set, do not place contents in scope
	! Removed this problematic line, don't know what it was for:
	@push wn;
	wn = match_from;
	if (opts == false) DoScopeActionAndRecurse(O);
	else DoScopeAction(O);
	@pull wn;    
	return;
];
-)

Chapter - Iterating over Scope

[Thanks to Andrew Plotkin for this code to make the scope checking not incredibly repetitive]

To iterate scope with (func - phrase thing -> nothing): (-scope_token=0; LoopOverScope({func}-->1); -).

To iterate scope for (actor - thing) with (func - phrase thing -> nothing): (- scope_token=0; LoopOverScope({func}-->1, {actor}); -).

Chapter - The Marked Visible Property

A thing can be marked visible or marked invisible.
A room can be marked visible or marked invisible.
A direction can be marked visible or marked invisible.
A region can be marked visible or marked invisible.

To mark the/-- visibility of (target - a thing) (this is scope caching):
	now target is marked visible;

Caching scope something is an activity on objects.

For caching scope of something (called viewer):
	Now everything is marked invisible;
	Iterate scope for viewer with scope caching.

Chapter - When to Perform Scope Caching

Section - Trusting the Scope Cache

Trust in the scope cache is a truth state that varies.

To decide whether we trust the scope cache:
	Decide on whether or not trust in the scope cache is true.

To trust the scope cache until next turn:
	Now trust in the scope cache is true.

To mistrust the scope cache:
	Now trust in the scope cache is false.

Section - Caching Scope After Reading a Command

After reading a command (this is the cache player's scope rule):
	if we trust the scope cache:
		Mistrust the scope cache;
	otherwise:
		Carry out the caching scope activity with the player.

The cache player's scope rule is listed first in the after reading a command rules.

Volume - Interactions with Conditional Backdrops (for use with Conditional Backdrops by Mike Ciul)

After moving floating objects (this is the cache scope after moving floating objects rule):
	Carry out the caching scope activity with the player;
	Trust the scope cache until next turn.

The cache scope after moving floating objects rule is listed last in the after moving floating objects rules.

Volume - Interactions with Epistemology (for use with Epistemology by Eric Eve)

Book - Sight (in place of Book 1 - Sight in Epistemology by Eric Eve)

A thing can be either seen or unseen. A thing is usually unseen.

[ With the speed advantages of scope caching, we can now do more accurate accounting of what has actually been seen. ]

After reading a command (this is the mark cached items as seen rule):
	Now every marked visible thing is seen.

The mark cached items as seen rule is listed last in the carry out looking rules.

The mark cached items as seen rule is listed after the cache player's scope rule in the after reading a command rulebook.

The cache player's scope rule is listed last in the carry out opening rules.
The mark cached items as seen rule is listed last in the carry out opening rules.

Book - Caching Scope When Looking (for use without Conditional Backdrops by Mike Ciul)

[In the case where both Epsitemology and Conditional Backdrops are used, we want to avoid redundant scope caching. The moving floating objects activity causes a scope loop, and moving floating objects usually happens before looking, so we want to skip doing it when looking]

The cache player's scope rule is listed last in the carry out looking rules.

Volume - Interactions with Remembering (for use with Remembering by Aaron Reed)

Book - Keeping Track (for Glulx only)

[
Section - Rules (in place of Section - Rules in Remembering by Aaron Reed)

After reading a command (this is the update remembered positions of cached things rule):
	repeat with item running through marked visible things that are enclosed by the location:
		if remembered location of item is not holder of item:
			now the remembered location of item is the holder of item.

The update remembered positions of cached things rule is listed after the cache player's scope rule in the after reading a command rules.

First report remembering (this is the Remembering specific report remembering rule):
	if remembered location of noun is nothing, continue the action;
	say the message corresponding to a rule name of Remembering specific report remembering rule in Table of Remembering Messages;
	stop the action. 
]

Volume - Testing commands - not for release

scope-cache-checking is an action out of world.
Understand "scopestat" as scope-cache-checking.

Report scope-cache-checking  (this is the standard report checking the scope cache rule):
	say "The following items are marked visible: [line break]";
	repeat with item running through marked visible things:
		say "  [the item][line break]";

scope-cache-checking it for is an action out of world applying to one visible thing.
Understand "scopestat [any thing]" as scope-cache-checking it for.

Carry out scope-cache-checking something for (this is the recache scope when checking the scope cache for rule):
	carry out the caching scope activity with the noun;

Report scope-cache-checking something for (this is the standard report checking the scope cache for rule):
	say "The following items are marked visible for [the noun]: [line break]";
	repeat with item running through marked visible things:
		say "  [the item][line break]";

Scope Caching ends here.

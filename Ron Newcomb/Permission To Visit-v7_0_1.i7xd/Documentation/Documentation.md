Section: Compass Hiatus


The craft of writing holds that if a journey doesn't advance the plot or deepen relationships, the journey should be skipped with a sentence or two.  This extension defines the verbs VISIT, ATTEND, GO TO, and FIND in accordance with this writing advice by plucking the character from one location and setting him in another, bypassing the need for cardinal directions.  The author may also free herself and her players from geographical concerns altogether by simply not connecting locations together with cardinal directions, and concentrate her efforts on story concerns.

The author can still provide guidance to the player by asserting certain regions of the work as off-limits.  Each region has a "gatekeeper", which is either a character whose explicit permission (or temporary invitation) is required, or, is an item the player must be carrying, to enter the region.  Individual rooms may be declared "public" so that they may always be entered by the player.  For example, outside the entrance to a secure building would typically be public.

Whether a room is public or not may be changed by the author during the game.  Changing the gatekeepers is also done directly.  (A region is public when its gatekeeper is "nothing".)  Invitations and permissions however are changed via the actions PERMIT, FORBID, and INVITE. Invitations are temporary, expiring when the invitee leaves the region.  Permitting a character grants a permanent invitation, or at least until the gatekeeper forbids the character.
	now the gatekeeper of Dune is Leto Atreides;
	now the courtyard entrance is public;
	try Leto forbidding the Harkonnens from Dune;
	try Leto permitting Paul Atreides to Dune;
	try the Fremen inviting Duncan Idaho to the desert.


These Actions work equally well with PCs and NPCs. PCs can themselves become -- and cease to be -- gatekeepers.  For example, if we would allow our player to claim regions as his own:
	{*}Understand "claim [any region]" as claiming.
	Claiming is an action applying to one visible object.
	Carry out claiming: now the gatekeeper of the noun is the actor.
	Report claiming: say "You claim [the noun] for Spain!"


Modifying our player's inventory to list these many new resources is almost certainly in order.  We'll need a new rule for each.
	{*}First carry out taking inventory:
		if the number of player-owned regions is not 0, say "You own [list of player-owned regions].";
		otherwise say "You don't own any real estate.  Even your apartment is rented."

	First carry out taking inventory:
		repeat through the table of Invitations begin;
			say "[The invitor entry] [if the temporary entry is true]invites[otherwise]permits[end if] [invitee entry][if there is a place entry] to [place entry][otherwise] anywhere[end if].";
		end repeat.

A testing command, "list invitations", is provided.  It will list all permissions and invitations currently held by anyone, anywhere.

Compass directions are still supported, of course.  Permissions are checked when moving thus.


Section: Miscellany

Visit, Attend, Find, and Go To are all functionally synonymous with one another:  each command moves the character to the location of the desired person, place, thing, or event, provided the gatekeeper allows it of course.  The verbs can be used interchangably with all noun types as an allowance to the player, but in the case of disambiguations, each has specific preferences:  Visit prefers persons, then rooms, and finally things; Find prefers things, then persons, then rooms; and Attend & Go prefer rooms, then people, and finally things.  This is an important point because any rules the author's game affects will affect all of these verbs equally.  Such consistancy is usually a good thing, if at first unexpected.

Modifying the default behavior for hybrid works is relatively painless.  For example, if we are writing an exploratory game and do not wish the player to skip rooms:
	{*}Check travelling to (this is the Don't Jump To Unvisited Places rule): if the destination is unvisited, say "You don't know where [the noun] is." instead.


Similarly, if we wish to warn the player when his invitation is about to expire:
	{*}Check travelling to (this is the invitation expiration warning rule):
		if the actor invitation to the room travelled from will expire by going to the room travelled to begin;
			say "Your invitation will expire.  Are you sure? ";
			unless the player consents, do nothing instead;
		end if.


If we would like to hide unknown people and items, using extension Epistemology by Eric Eve:
	{*}Check visiting (this is the Don't Jump To Unknown People rule): if the noun is unknown, say "You don't know where [the noun] is." instead.
	Check finding (this is the Don't Jump To Unknown Items rule): if the noun is unknown, say "You don't know where [the noun] is." instead.


If we would like to introduce concepts of last known locations, hard to find people, and things misplaced by other characters, here's a start:
	{*}A thing has a room called the last known location.
	
	This is the Last Known Location rule:
		try actor travelling to the last known location of the noun.
	
	The Last Known Location rule is listed instead of the Visit Uses Travel-To rule in the carry out visiting rules.
	The Last Known Location rule is listed instead of the Find Uses Travel-To rule in the carry out finding rules.


We can ask at any time if a person "can visit" a region, room, thing, person, or even a direction.
	if Uncle Ernie can visit Aunt Bertha,
	if the player can visit the skeleton key,
	if the actor can visit the town square,
	if the player can visit north, say "You can go north from here."



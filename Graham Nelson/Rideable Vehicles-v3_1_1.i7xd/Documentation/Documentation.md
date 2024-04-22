Inform's built-in "vehicle" kind assumes that the vehicle is a
container, which is fine for cars or hot-air balloons, but not so
good for a pony or a four-wheeled lawnmower, which one rides rather
than gets inside. Rideable Vehicles is an extension which creates
two more kinds: "rideable animal" (good for the pony) and
"rideable vehicle" (good for the lawnmower).

	The pony is a rideable animal in the Forest Clearing.
	The lawnmover is a rideable vehicle in the Garden Shed.

This means that three different kinds of thing can be used as a
means of travel, which might make it awkward to write a general
rule about them, so we also define the adjective "vehicular" for
any thing of any of these kinds.

	The Transport Museum is a room. "The Museum is filled with means of transport old and new, including [list of vehicular things in the Transport Museum]."

A new action called "mounting" is created, and a new command "mount"
(or "ride") is added for the player to use. Thus:

	Instead of mounting the pony, say "The pony snorts and backs off."

results in

	>ride pony
	The pony snorts and backs off.

And a corresponding "dismounting" action handles the command "dismount".

	>dismount
	You get off the pony.

Moreover, commands such as "get off the pony" or "get on the lawnmower"
are converted into these new actions instead, so that rules like the
following will always work, no matter what command is tried:

	Instead of mounting the tricycle when the transport pass is not carried by the player:
		say "The tricycle can only be ridden by those with a transport pass."

Lastly, a special rule means that "pony, go east" is recognised when
the player is riding the pony. (This works for rideable animals, but not
rideable vehicles.)


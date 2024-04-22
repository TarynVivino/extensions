This is a very straightforward extension that allows you to tweak the way that "brief" room descriptions work in Inform stories.

Without this extension, all players are in "verbose" mode by default and will see the full room description every time they visit a room.  At the player's option, they may request "brief" mode, which will print a description the first time and nothing on subsequent times, or "superbrief" mode, which will print nothing on the first time either.  In all cases, using "look" explicitly will show the full description regardless of the mode.

Including this extension tweaks things slightly so that players default to the "brief" mode, but also gives every room a "brief description" property, which will be printed on the second and subsequent visits to a room rather than printing nothing.

It still respects player preferences, however, so if they explicitly request "verbose" mode then they will get it.

The "superbrief" mode remains unaffected by this and will not display either kind of description.  We presume the player knows what they're doing if they request this.


The purpose of Ordinary Room Description is to replicate as closely as possible the default room description behavior of Inform while relying on the framework provided by Room Description Control.

This means that including Ordinary Room Description should, by itself, change nothing about the way descriptions are presented in our game.

The advantage of including it is that we can then make use of Room Description Control to make slight tweaks to Inform's default behavior, as for instance by writing description-concealing rules or changing the priority of items so that they are listed in a different order from the usual within a room.

For more detail on these abilities, see the documentation for Room Description Control.

Changelog:

	Version 4.0.220524 updated to Inform v10.1 version numbering.  (Modified by Nathanael Nerode.)
	Version 4/210333 added the missing space in "On the dresser are[ ]a set of sheets."
	Version 4/210332 stopped trying to print initial descriptions when the initial description was "".
	Version 4/210322 is updated to work with version 14 of Room Description Control, which renamed the "output" column of the Table of Seen Things to "output subject" to reduce namespace conflicts with games.  (Modified by Nathanael Nerode.)


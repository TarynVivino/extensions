This extension allows the programmer to override what the player typed and parse different commands instead.

	force the command "jump"
	force the command set {"north", "east", "northeast"}

This "forces" the player to type the specified command, by overriding the keyboard input.

	replay the command "jump"
	replay the command set {"north", "east", "northeast"}

This prints and executes the specified command without waiting for player input, as if it were replayed from the Skein.

	silently execute the command "jump"
	silently execute the command set {"north", "east", "northeast"}

This is the same as "replay", but the command line is hidden entirely. Note that the results of the actions are still printed.


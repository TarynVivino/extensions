Section: Usage

The Regional Travel extension adds a new action, traveling regionally to, that allows the player to travel between different regions with the command TRAVEL TO. This kind of technique is sometimes used in games where the player can travel between distant locations, for example between cities or between separate locations inside a city. The extension can also be used when the player needs a vehicle for traveling to certain areas (see example B for a demonstration).

The minimal setup is to group rooms into regions (see chapter 3.4 in Inform 7 (5Z71) documentation) and define what is the "travel entry point" of each region. The travel entry point is the room where the player will end up when traveling to that region. Note that the travel entry point doesn't actually have to be inside the region. Example A demonstrates a basic setup.

By default the player can't travel to any region that is unvisited. If we want the player to be able at any point of the game to travel somewhere they haven't visited yet it's recommended to include another extension, Epistemology by Eric Eve. When we're using Epistemology we can make a room 'familiar' which allows traveling there. See Epistemology's documentation for more information or example B for another method for granting travel access to an unvisited location.


Section: Version history

Version 2 (April 2014): Modified the extension for compatibility with the new release of Inform. Message variables are now removed and changing messages is handled through means provided by Inform itself. The travel destination announcements option is removed and removing the announcement is done by removing the rule that prints it.



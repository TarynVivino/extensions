This extension allows for a room description to "decay" in a gradual way, based on how often the player has seen the location.

How this work is that the first time a room is gone to by the player, they will see the full description of the room. On the next time going to the room, the player will also see the description. However, you can provide a "summary description" for a room and if that is provided, this is what will always be used for the room's description the second time the player visits it.

The third time the player visits the room, they will see no description at all. (This is akin to "superbrief" mode.)

Of course, a "LOOK" command will always return the appropriate text of the location. However, the initial full description of the room is gated behind a check for whether the room is visited or unvisited. That means any subsequent looks will always rely on the summary description. You can use this extension with my Contextual Descriptions, which provides an "impressions" action that allows the player to recover the full text of the room.

Something to note is that the way this logic works, it entirely overrides the description styles that players can usually choose. There are unabbreviated room descriptions ("verbose", "long"), sometimes abbreviated room descriptions ("brief", "normal"), and abbreviated room descriptions ("superbrief", "short"). Using this extension means you want to control the display of descriptions by, in a sense, cycling through those various settings. In other words, by using this extension you are explicitly saying, as a design choice, you want the descriptions to "decay" rather than be in one mode.


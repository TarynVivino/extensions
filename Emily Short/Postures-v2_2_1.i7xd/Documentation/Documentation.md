Postures defines three postures -- seated, standing, and reclining -- and allows pieces of furniture to specify which postures are possible and preferred when the player is on those furnishings.

Chapter: Postures and Furniture

Section: Possible Postures

Each piece of furniture comes with a range of possible postures, which can be expressed with the posture-permission relation: as in

	The bunk bed allows seated and reclining.

This definition would say that we're allowed to sit or lie down on the bunk bed, but not to stand up on it. Player attempts to

	>STAND ON BUNK BED

will be rejected with

	You can't take that position on the bunk bed.

Section: Preferred Postures

In addition to permitted postures, furniture can have a "preferred" posture: it's possible to stand on a chair, but we're more likely to sit on it. Preferred postures are used to guess what the player means if he types

	>GET ON BUNK BED

without naming a posture.

Section: Entering and Leaving Furniture

If an actor attempts to leave an enterable object, his posture is automatically returned to "standing"; if he enters something without setting a posture explicitly, as in

	>GET ON SOFA

the actor's posture will automatically be set to the default posture for that piece of furniture (sitting, in this case).

Section: Defining New Furniture

To make use of the features of Postures, we may define pieces of furniture like so:

	A chair is a kind of supporter. A chair is always enterable. Every chair allows seated and standing. A chair is usually seated.

Section: Rooms and Postures

Rooms cannot enter into the posture-allowing relation. However, rooms can be set as "posture-friendly" (you can lie or sit down on the ground in those rooms) and "posture-unfriendly" (no lying down or sitting allowed). By default, they are posture-friendly.

This feature determines whether a player can take postures other than standing while in a room (that is, not on a piece of furniture). Suppose the player types

	>LIE DOWN

without naming where he wants to lie down. The game will first look for an available piece of furniture that allows reclining (ideally one whose preferred posture is reclining) and try to lie on that, but if it finds none and the room is posture-friendly, the player will lie down on the floor. If the room is posture-unfriendly and there is no suitable piece of furniture, the game will be rejected with

	There's nothing to lie on.

Section: The Posture Visibility Checks option

Before printing an error message for an NPC, such as "Clark is already sitting" when Clark is trying to sit, this extension can first check whether the player can actually see Clark. If he is in another room or in a closed opaque container, no message will be printed. As visibility checks in Inform can sometimes be slow, this feature is off by default, but can be turned on with the line

	Use posture visibility checks.

Note that this only applies to the new messages introduced by this extension. Some error messages in the Inform Standard Rules will print even if the NPC they mention is not visibile to the player.

See this discussion about other glitches that may occur when NPC actions fail, and some ideas on what to do about it: https://intfiction.org/t/postures-by-emily-short/6748/6

Section: Change Log

Version 2/180528 fixes a run-time error that could occur when typing LIE. It also always looks for a reasonable piece of furniture to sit or lie down on in a room rather than defaulting to the floor when typing just SIT or LIE, even if the room is posture-friendly. It also introduces the posture visibility checks option


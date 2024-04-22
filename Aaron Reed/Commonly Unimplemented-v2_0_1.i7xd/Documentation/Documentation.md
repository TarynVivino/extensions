An extension for Smarter Parser, this provides three new rules that offer tutorial-style messages if the player tries interacting with unimplemented body parts, clothing, or generic surroundings like the floor or ceiling.

Chapter: Customizing

Frequently you actually *will* implement some of these things, and want to avoid misleading your players if they're using the right word but an incorrect syntax. You can alter the messages to help teach players the correct format (see below) but you can also keep the extension from triggering at all by excluding specific words from the match list.

To do this, probably in a "when play begins" rule, you can use either of the phrase variants:

	release body part word "skull" from Smarter Parser
	release body part words {"skull", "head", "hair"} from Smarter Parser
	
...as well as four other phrases to "release clothing word(s)" and "release surroundings word(s)." This will also stop plurals from matching as well. You can see a list of the current words with:

	say body part words
	
And likewise for the other two categories.

Chapter: Rules

Section: the flexible stripping body parts rule

Looks for commands that reference parts of the body. If the reference is in the form of an addendum like ON HIS SHOULDER or IN THE FACE, strip the addendum and reparse. Also tries to reparse something like LOOK AT LISA'S FACE as LOOK AT LISA. If a body part word is found outside either of these patterns, reject the command.

The default list is:

	eye, head, skull, hair, nose, mouth, ear, cheek, forehead, face, neck, chest, gut, breast, belly, stomach, body, nipple, shoulder, collar, arm, wrist, hand, finger, knuckle, fingernail, waist, thigh, leg, knee, shin, ankle, foot, feet, toe, elbow, fist, thumb, tongue, lip, heart
	
To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	flexible stripping body parts rule	"[as the parser]You do not normally need to refer to parts of the body.[as normal]"
	
To remove:

	{*}The flexible stripping body parts rule is not listed in the Smarter Parser rulebook.
	
Section: the usually no clothing rule

Rejects commands which include mentions of common articles of clothing. The default list is:

	clothes, shirt, pant, jacket, sock, shoe, belt, hat, underwear, jean, trouser, pocket
	
To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	usually no clothing rule	"[as the parser]You do not normally need to refer to articles of clothing.[as normal]"
	
To remove:

	{*}The usually no clothing rule is not listed in the Smarter Parser rulebook.
	
Section: the generic surroundings rule

Rejects commands which include mentions of generic and probably unimplemented surroundings. The default list is:

	ground, floor, wall, corner, ceiling, sky
	
To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name		message
	generic surroundings rule		"[as the parser]Unless specifically mentioned by the text, avoid general concepts like the floor and ceiling. Try typing LOOK and then using verbs like TAKE or EXAMINE on the things you see mentioned.[as normal]"
	
To remove:

	{*}The generic surroundings rule is not listed in the Smarter Parser rulebook.
	

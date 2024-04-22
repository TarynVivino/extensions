Version 2 of Screen Reset by Brent Worthington begins here.

"Allows the player to reset the screen."

Include Basic Screen Effects by Emily Short.

Resetting is an action out of world applying to nothing. Understand "r", "reset", "refresh" and "screen" as resetting.

Carry out resetting (this is the standard carry out resetting rule):
clear the screen;
say paragraph break;
try looking.

Screen Reset ends here.

---- DOCUMENTATION ----

This extension allows the player to reset the screen as is possible in Infocom games.

Example:** Tranquility - Resetting the screen

	*:"Tranquility"

	Include Screen Reset by Brent Worthington.

	A market stall is a kind of room. The description of a market stall is usually "You are among the clamour of market sellers, arranged from east-to-west, each shouting their wares. It's quite distracting."

	The Cacophonous Market is a market stall. The Clamorous Market is a market stall. The Claustrophobic Market is a market stall. The Clamorous Market is east of the Cacophonous Market. The Claustrophobic Market is east of the Clamorous Market.

	A person can be distracted. A person is usually not distracted.

	After looking when the player is in a market stall:
		now the player is distracted;	
		get lost in the sound.

	The Peaceful Fountain is east of the Claustrophobic Market. "At last, you can take a moment to take in the quiet of the fountain."

	To get lost in the sound:
		say "'[one of][or]COME ON! [or]HEAR YE! HEAR YE! [or]BARGAIN HERE! [or]WE GOT IT! [or][or][at random][one of]FRESH[or]GET YOUR[or]COME ONE, COME ALL, FOR[or]WE GOT[or]WE HAVE[or]LAST CHANCE FOR[or]THREE FOR A POUND ON[at random] [one of]TOMATOES[or]BANANAS[or]CABBAGES[or]ORANGES[or]APPLES[or]PICKLES[or]PASTRIES[or]CAKES[or]LEEKS[or]BROCOLLI[or]FLOWERS[at random]!'";
		if a random chance of one in ten succeeds:
			now the player is not distracted;
		else:
			get lost in the sound.

	Test me with "E / E / E / R"

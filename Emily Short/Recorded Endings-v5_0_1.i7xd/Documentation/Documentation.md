Recorded Endings is intended for use with Glulx works that can end in multiple ways. It records short text descriptions of the various endings to an external file, then allows the player an ENDINGS option when the game is over, so that he can review all of the endings he has encountered so far whether in this playthrough or in an earlier one.

To use Recorded Endings, we need only to:

1) include a line naming the file in which conclusions will be written, thus:

	The File of Conclusions is called "recconclusions".

Everything about this line should be exactly as written *except* the name within the quotation marks, which should be something that the game author chooses.

Originally Recorded Endings declared this file itself, but the result is that if one game is played in the same directory as another that also uses Recorded Endings, the identical file names will cause bugs in whichever game is played second. Therefore we should pick a name that will be unique to this particular game, perhaps using the initials of the title or the game author in some way.

It does not matter whether the File of Conclusions is named before or after the "Include Recorded Endings" line is added.

2) tell the game what to record before each ending. So for instance if we have a sequence leading to death, we might write
	
	record "Martyrdom among the lions" as an ending;
	end the game in death.

Or again we might write

	record "Abduction by aliens" as an ending;
	end the game saying "You spend the rest of your life orbiting Alpha Centauri".

By default, Recorded Endings offers the player the ENDINGS option regardless of whether the game ended in victory. If we wish to change this so that the ENDINGS are shown only after "end the game in victory", then we might write

	When play begins:
		choose a row with a final response rule of list endings rule in the Table of Final Question Options;
		change the only if victorious entry to true.

If there are more than twenty possible endings in the game, we may need to extend the table that records them, the Table of Possible Endings. To do this, we might write

	Table of Possible Endings (continued)
	description
	--
	with 10 blank rows.

(This will actually append a total of 11 rows to the table, but that -- entry cannot be omitted or Inform will become confused about appending more blank rows to the table.)

Finally, we may want elsewhere in the game to find out whether the player has already experienced a specific ending. (Perhaps the game subtly changes descriptions after multiple playings.) For this case, we would write

	if "Turning into a pumpkin" is a used ending: ...

where "Turning into a pumpkin" is the exact text that we record when that ending occurs.


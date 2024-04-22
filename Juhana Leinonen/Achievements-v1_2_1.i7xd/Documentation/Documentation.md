Section: Setting up

We must define the following table in the story source:

	Table of Achievements
	achievement	description	validation	awarded
	"Example"	"You've unlocked the example achievement"	example achievement rule	false

The "achievement" column is the name of the achievement, and the "description" column is the longer explanation of the achievement, usually the reason for why the achievement was awarded.

The validation column should contain a rule that succeeds when the achievement should be awarded.

	This is the example achievement rule:
		if the player is carrying the MacGuffin:
			rule succeeds.
			
The rule doesn't need to check if the condition is true for the first time, the extension awards each achievement only once.

The validation entry can also be left blank. In that case the achievement must be awarded manually (see the next chapter).

The last column, "awarded", tracks whether the achievement has already been awarded. It should start out as false (unless for some reason we want the player to start the story with achievements already awarded).


Section: Awarding achievements

The rules in the validation column are checked at the very end of every turn and any new achievements are awarded. Achievements can also be awarded manually at any time:
	
	award the "Example" achievement;
	
Adding the "silently" modifier to the phrase suppresses the achievement notification:
	
	award the "Example" achievement, silently;
	
The rule responsible for achievement notifications is the print achievement unlocked rule, so unlisting it will remove notifications altogether.

Printing achievement text is an activity and rules can be attached to it like to any other activity:
	
	Before printing the achievement text:
		say "Drumroll please..."
		

Section: Persistent achievements

The achievements can optionally persist between playthroughs by applying a use option:

	Use persistent achievements.

Any unlocked achievements are then saved to a file and restored from there when play begins.

Persistent achievements works only in Glulx.



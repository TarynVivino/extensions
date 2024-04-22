Tutorial Mode is intended to make a work of interactive fiction act a little more like a commercial game with a standard tutorial mode that begins whenever the player first starts play.

Tutorial mode by default teaches LOOK, EXAMINE, INVENTORY, TAKE, DROP, and the use of compass directions. It does this by prompting the player to try these commands whenever the situation is right -- so it will only prompt the player to try INVENTORY if he is holding something, TAKE if he can see a portable object, and so on. The intention is to create a tutorial that will work flexibly with a wide range of first rooms in games.

It's likely that in any given game, Tutorial Mode will still need a little adjustment. Rules about what to teach are part of the instructional rules rulebook. If we don't like one of the rules currently included, we can get rid of it -- for instance, the compass directions rule might not be valuable in a game that uses GO TO ROOM instead, so we might want

	The teach compass directions rule is not listed in any rulebook.

...to remove this rule from the list.

We can also add new instructional rules on the model of the existing ones. For example, we might add a new rule teaching the player to eat things like this:

	An instructional rule (this is the teach eating rule):
		if the teach eating rule is listed in the completed instruction list, make no decision;
		if the player can see a previously-mentioned edible thing (called target item):
			let N be indexed text;
			now N is "[target item]";
			say "[italic type]If you get hungry, you can always try eating the food you find. Try EAT [N in upper case].[roman type]";
			now the held rule is the teach eating rule;
			rule succeeds;
		otherwise:
			make no decision.

This is slightly complicated, so to go over the elements: the completed instruction list is a list of all the instruction rules that the player has successfully learned. These lessons are not repeated.

We check whether the target is "previously-mentioned" because we want to make sure that, at each stage, the player is only being asked to interact with things that the text of the game has already mentioned to him. This excludes inventory objects when the player hasn't yet taken inventory, for instance, even though those objects are technically "visible".

Earlier versions of this extension would strictly force the player to type exactly what was instructed, similar to the strict behavior of tutorial modes in casual games, but playtesting found that this was more annoying than helpful.

We change "held rule" to the current rule (that is, in this example, the "teach eating rule") so that after the player's command is read, the parser can determine whether the player has learned this lesson or not, and, if he has, add this rule to the completed instruction list.

It's often the case that we want to follow up a lesson by telling the player a little something extra -- for example, that he can use abbreviations for compass directions. That kind of reply -- printed only when the player has successfully issued the command we're currently teaching -- can be stored in the Table of Instruction Followups, like this:

	Table of Instruction Followups (continued)
	selector	followup
	teach opera rule	"Perfect. To simplify matters, the ARIA command can be abbreviated throughout the game as A."


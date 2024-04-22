Version 2.0.220524 of Distantly Visible Things by Marc Von Der Heiden begins here.

"Provides flexible handling of things that can be seen in multiple rooms, but - unlike backdrops - still have one distinct location."

[Version number and filename updated by Nathanael Nerode for Inform 10.1, with no other changes needed from the 6L62 version.]

Chapter 1 - Basic framework

Distant visibility relates various things to various rooms. The verb to be distantly visible from implies the distant visibility relation.
 
A thing has a text called distant description.

The distance visibility rules are an action based rulebook. The distance visibility rules have outcomes allow action (success) and deny action (failure). The distance visibility rules have default failure.

Printing a refusal for distantly handling something is an activity on things

Chapter 2 - Bringing distantly visible things in scope

After deciding the scope of the player (this is the put distantly visible things in scope rule):
	if the player is not enclosed by a closed opaque container:
		repeat with X running through things that are distantly visible from the location of the player:
			if X is not enclosed by a closed opaque container:
				if X is lit or the location of X is lit or X can see a lit thing, place X in scope, but not its contents.

Chapter 3 - Handling touchability of distantly visible things

The can't touch distantly visible things rule is listed before the access through barriers rule in the accessibility rulebook.
Accessibility rule (this is the can't touch distantly visible things rule):
	if the action requires a touchable noun and the noun is a thing that is distantly visible from the location of the player:
		carry out the printing a refusal for distantly handling activity with the noun; 
		stop the action;
	if the action requires a touchable second noun and the second noun is a thing that is distantly visible from the location of the player:
		carry out the printing a refusal for distantly handling activity with the second noun;
		stop the action.

Chapter 4 - The distance visibility rulebook

The distance visibility stage rule is listed before the instead stage rule in the action-processing rulebook.
This is the distance visibility stage rule:
	unless the noun is a thing that is distantly visible from the location of the player or the second noun is a thing that is distantly visible from the location of the player, continue the action;
	follow the Distance visibility rulebook;
	if rule succeeded, continue the action;
	if rule failed, stop the action.

Last distance visibility rule (this is the block actions with distantly visible things rule):
	if the noun is a thing that is distantly visible from the location of the player:
		carry out the printing a refusal for distantly handling activity with the noun;
		deny action;
	if the second noun is a thing that is distantly visible from the location of the player:
		carry out the printing a refusal for distantly handling activity with the second noun;
		deny action.

Distance visibility for Examining (this is the examining distantly visible things rule):
	unless the noun provides a distant description, make no decision;
	if the distant description of the noun is "", make no decision;
	say the distant description of the noun;
	say paragraph break;
	deny action.

Chapter 5 - Standard refusal message for distantly visible things

Rule for printing a refusal for distantly handling a thing (called target) (this is the standard printing a refusal for distantly handling rule):
	say "[We] [need] to get closer to [the target][unless best route from the location of the player to the location of the target is nothing], which [regarding the target][are] to the [best route from the location of the player to the location of the target][end unless]." (A).

Distantly Visible Things ends here.

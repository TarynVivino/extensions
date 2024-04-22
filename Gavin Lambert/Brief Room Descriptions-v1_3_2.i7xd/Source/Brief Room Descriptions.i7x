Version 1.3.2 of Brief Room Descriptions by Gavin Lambert begins here.

"Alters BRIEF mode to display a room's brief description instead of nothing."

Use authorial modesty.

Section - Default Setting

Use brief room descriptions.

Section - Everything Else

A room has some text called brief description.

Carry out looking (this is the brief room description body text rule):
	if the visibility level count is 0
		or the visibility ceiling is not the location
		or not set to sometimes abbreviated room descriptions
		or abbreviated form allowed is false
		or the location is not visited, continue the action;
	let desc be the brief description of the location;
	if desc is not empty:
		say desc;
		say paragraph break.
		
The brief room description body text rule is listed before the room description body text rule in the carry out looking rules.

Brief Room Descriptions ends here.

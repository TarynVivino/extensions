Version 7.0.220526 of Single Paragraph Description by Emily Short begins here.

"A room description extension based on Room Description Control (which is required). All contents of a room are summarized in a single paragraph, starting with the regular room description."

Include Room Description Control by Emily Short.
 
The room description body text rule is not listed in any rulebook.

Definition: a thing is initially-described if the initial appearance of it is not "" and it is not handled.

The new reporting descriptions rule is listed instead of the reporting descriptions rule in the description-priority rulebook.

The reporting items rule is listed after the new reporting descriptions rule in the description-priority rulebook.

A ranking rule for an initially-described thing (called special-target): 
	increase description-rank of the special-target by 5.

A ranking rule for a container (called special-target): 
	increase description-rank of the special-target by the number of mentionable things in the special-target.

A ranking rule for a supporter (called special-target): 
	increase description-rank of the special-target by the number of mentionable things on the special-target.

A ranking rule for something (called special-target) which is not in the location:
	increase description-rank of the special-target by 1. 


Printed a room description is a truth state that varies. Printed a room description is false.

This is the new reporting descriptions rule:
	if the description of the location is not "":
		if set to abbreviated room descriptions:
			make no decision;
		otherwise if set to sometimes abbreviated room descriptions and abbreviated form allowed is true and the location is visited:
			make no decision;
		otherwise:
			say "[description of the location] [run paragraph on]" (A); [Need rpo because end of rule]
			now printed a room description is true;

This is the reporting items rule: 
	if the Table of Seen Things is empty: 
		if printed a room description is true:
			now printed a room description is false;
			say "[line break]" (A);
		otherwise:
			say "[conditional paragraph break]" (B);
		make no decision; 
	now printed a room description is false; 
	repeat through the Table of Seen things:
		if the output subject entry is mentionable:
			if the output subject entry is initially-described:
				say "[initial appearance of output subject entry] " (C);
				now output subject entry is mentioned;
			otherwise if output subject entry is in something (called special-vase):
				say "In [the special-vase] [regarding mentionable things in the special-vase][are] [list of mentionable things in the special-vase]. " (D);
			otherwise if output subject entry is on something (called special-vase):
				say "On [the special-vase] [regarding mentionable things on the special-vase][are] [list of mentionable things on the special-vase]. " (F);
			otherwise if output subject entry supports something mentionable:
				say "On [a output subject entry] [regarding mentionable things on the output subject entry][are] [list of mentionable things on the output subject entry]. " (G);
			otherwise if output subject entry contains something mentionable:
				say "In [a output subject entry] [regarding mentionable things in the output subject entry][are] [list of mentionable things in the output subject entry]. " (H);
			otherwise:
				say "[We] also [see] here [a list of mentionable things]. " (I); 
	say "[paragraph break]" (J).

After printing the name of something (called special-target):
	now the special-target is not marked for listing;
	now the special-target is mentioned.  

The new describe contents rule is not listed in the report entering rulebook.

Single Paragraph Description ends here.

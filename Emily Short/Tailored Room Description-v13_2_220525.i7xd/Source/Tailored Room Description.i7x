Version 13.2.220525 of Tailored Room Description by Emily Short begins here.

"An extension to go with Room Description Control, providing a different style of room description than the default. Parenthetical remarks such as (open) and (in which are...) are omitted in favor of full English sentences. Removes the requirement for Text Variations."

Include Room Description Control by Emily Short.


Section 1 - Rankings

[These rankings give priority to items that have an interesting initial appearance and those that support or contain a large number of other items.]

A thing has some text called a flexible appearance. The flexible appearance of a thing is usually "blank".

Definition: a thing is flexibly-described if the flexible appearance of it is not "blank".

[A ranking rule for something (called special-target) which is in a room:
	increase the description-rank of the special-target by 1.]

A ranking rule for something (called special-target) which is not in the holder of the player:
	decrease the description-rank of the special-target by 2.

A ranking rule for a flexibly-described thing (called special-target):
	increase description-rank of the special-target by 4.

Definition: a thing is initially-described if it is not handled and its initial appearance is not "".

A ranking rule for an initially-described thing (called special-target):
	increase description-rank of the special-target by 5.

A ranking rule for something (called special-target):
	let N be the number of mentionable things enclosed by special-target;
	increase the description-rank of the special-target by N.


Section 2 - The current-paragraph

[The concept of the current-paragraph is that a marker keeps track of every item we mention within a given paragraph. This allows us to group together items that might otherwise not share the same priority rank -- for instance, if we say

A platter is on the table.

...then "platter" and "table" are marked as being referenced by this paragraph, and appropriate other sentences about these items will be added to the same paragraph. For instance: "The platter supports a tea kettle and a bottle of water. There is also a roast chicken on the table."]

current-paragraph is a thing. Referencing relates one thing to various things. The verb to reference (it references, he references, he referenced, it is referenced, it is referencing) implies the referencing relation.

Before printing the name of something (called special-target) while writing a paragraph about:
	now the current-paragraph references special-target.

Before writing a paragraph about something:
	now current-paragraph does not reference anything;

Section 3 - Writing Paragraph Rules

Rule for writing a paragraph about a deeply dull thing (called special-target) (this is the ordinary items rule):
	carry out the disclosing contents activity with the holder of the special-target;
	carry out the giving-surrounding-details-for activity with the special-target;
	now held-break is true;
	say "[run paragraph on]";

Definition: a thing is deeply dull if it lacks relative interest.

To decide whether (special-target - a thing) lacks relative interest:
	if the special-target is initially-described, no;
	if the special-target is flexibly-described, no; [make sure to account for all flexibly described things]
	let bias be lowest-rank plus 2;
	if the description-rank of special-target is greater than bias, decide no; [allow for the possibility that objects in a container may deserve to be listed together in a single sentence]
	let N be the holder of the special-target;
	if N is a container or N is a room
	begin;
		repeat with other-target running through mentionable things which are in N
		begin;
			if the description-rank of other-target is less than the description-rank of special-target, decide no;
		end repeat;
	otherwise if N is a supporter;
		repeat with other-target running through mentionable things which are on N
		begin;
			if the description-rank of other-target is less than the description-rank of special-target, decide no;
		end repeat;
	end if;
	decide yes.

Rule for writing a paragraph about something (called special-target) (this is the standard paragraphs rule):
	now the special-target is mentioned;
	set pronouns from the special-target;
	carry out the writing a topic sentence about activity with the special-target;
	if the holder of the special-target is not the location and the holder of the special-target is not referenced by current-paragraph:
		carry out the disclosing exterior activity with the special-target;
	carry out the giving-surrounding-details-for activity with the special-target;
	now held-break is true;
	say "[run paragraph on]";

Giving-surrounding-details-for something is an activity on objects.

Rule for giving-surrounding-details-for something (called the special-target) (this is the standard surroundings rule):
	while a surprising thing (called second special-target) is referenced by the current-paragraph:
		carry out the disclosing contents activity with the second special-target;
		now every thing contained by the second special-target is mentioned;
		now every thing supported by the second special-target is mentioned;
		now every thing held by the second special-target is mentioned;
		now every thing which is part of the second special-target is mentioned;

Held-break is a truth state that varies. Held-break is false.

Last after writing a paragraph about something when held-break is true:
	now held-break is false;
	say "[paragraph break]";

Writing a topic sentence about something is an activity.

Rule for writing a topic sentence about something (called the special-target):
	if the special-target is initially-described
	begin;
		say initial appearance of the special-target; say " ";
	otherwise if the special-target is flexibly-described;
		say flexible appearance of the special-target; say " ";
	otherwise;
		now the current-subject is special-target;
		choose a random row in the current-topic-sentences-table;
		say "[disclosure entry][run paragraph on]";
	end if;
	now the current-paragraph references the special-target.


current-subject is an object that varies.
current-exterior is an object that varies.
first-subject is an object that varies.
count-of-mentionable-contents is a number that varies.
count-of-mentioned-contents is a number that varies.

Definition: a thing is surprising if it is mentionable.

Definition: a supporter is surprising if it supports a mentionable thing.

Definition: a container is surprising if it contains a mentionable thing.

Definition: a person is surprising:
	if it carries a mentionable thing, yes;
	if it wears a mentionable thing, yes.

Disclosing contents of something is an activity. Disclosing exterior of something is an activity.

Rule for disclosing exterior of something (called special-target) (this is the standard-exterior rule):
	let the chosen table be the current-NE-table;
	now current-subject is special-target; [so that printing routines can refer to it]
	now first-subject is special-target;
	let nesting be false;
	while the holder of the current-subject is not a room:
		if nesting is false:
			choose a random row in the current-subject-introductions-table;
			say "[disclosure entry][run paragraph on]";
		now current-exterior is the holder of current-subject;
		now count-of-mentionable-contents is the number of mentionable things held by the current-exterior;
		now count-of-mentioned-contents is the number of mentioned things held by the current-exterior;
		now nesting is false;
		if the holder of the current-subject is a person, now the chosen table is the current-NC-table;
		otherwise now the chosen table is the current-NE-table;
		choose a random row in the chosen table;
		say "[disclosure entry][run paragraph on]";
		if the count-of-mentionable-contents is greater than 0 and the current-exterior is in a room and the current-subject is the first-subject:
			choose a random row in the current-ao-table;
			say "[disclosure entry][run paragraph on]";
		otherwise if the current-exterior is not in a room:
			choose a random row in the current-connectives-table;
			say "[disclosure entry][run paragraph on]";
			now nesting is true;
		otherwise:
			say ". ";
		now current-subject is the holder of current-subject;

To sit is a verb. To rest is a verb.

To say sits:
	if the current-subject is carried by a person or the current-subject is worn by a person
	begin;
		say "[regarding current-subject][are] ";
	otherwise;
		say "[regarding current-subject][one of][sit] [or][rest] [or][are] [or][are] sitting [at random]";
	end if;

To say (N - a thing) as a possibly-known item:
	if N is mentioned, say "[the N]";
	otherwise say "[a N]".

To say in-on (N - a thing):
	if the current-subject is part of N
	begin;
		say "part of [the N]";
	otherwise if N is a container;
		say "in [the N]";
	otherwise;
		say "on [the N]";
	end if;

To say in-on (N - a thing) as a possibly-known item:
	if the current-subject is part of N
	begin;
		say "part of ";
	otherwise if N is a container;
		say "in ";
	otherwise;
		say "on ";
	end if;
	say N as a possibly-known item.

Rule for disclosing contents of a room (called special-target) (this is the disclosing-rooms rule):
	now the current-subject is special-target;
	now count-of-mentionable-contents is the number of mentionable things held by the special-target;
	now count-of-mentioned-contents is the number of mentioned things held by the special-target;
	choose a random row in the current-room-content-table;
	say "[disclosure entry][run paragraph on]".

Rule for disclosing contents of something (called special-target) (this is the disclosing-contents-of-holders rule):
	now the current-subject is special-target;
	now count-of-mentionable-contents is the number of mentionable things held by the special-target;
	now count-of-mentioned-contents is the number of mentioned things held by the special-target;
	choose a random row in the relevant table;
	say "[disclosure entry][run paragraph on]".

To say optional also:
	if count-of-mentioned-contents is greater than zero, say "also ".
To say mentioned-are:
	if the count-of-mentioned-contents is greater than one, say "are";
	otherwise say "is".
To say mentionable-are:
	if the count-of-mentionable-contents is greater than one, say "are";
	otherwise say "is".

Section 4 - Template Tables

To decide which table-name is the relevant table:
	if the current-subject is a supporter which supports a mentioned thing and the current-subject is not mentioned, decide on the current-prementioned-supporters-table;
	if the current-subject is a container which contains a mentioned thing and the current-subject is not mentioned, decide on the current-prementioned-containers-table;
	if the current-subject is a supporter, decide on the current-supporter-content-table;
	if the current-subject is a container, decide on the current-container-content-table;
	if the current-subject is a person, decide on the current-person-content-table.


The current-topic-sentences-table is a table-name that varies. The current-topic-sentences-table is the Table of Basic Sentences.

Table of Basic Sentences
disclosure
"[if the current-subject is a person][The current-subject] [are] here. [otherwise]You can see [a current-subject] here. [end if]"

current-ao-table is a table-name that varies. The current-ao-table is the Table of Adjacent Objects.
current-connectives-table is a table-name that varies. The current-connectives-table is the Table of Connectives.
current-subject-introductions-table is a table-name that varies. The current-subject-introductions-table is the Table of Subject Introductions.
current-NC-table is a table-name that varies. The current-NC-table is the Table of Nesting Carriers.
current-NE-table is a table-name that varies. The current-NE-table is the Table of Nesting Exteriors.

Table of Adjacent Objects
disclosure
", alongside [a list of mentionable things held by the current-exterior]. "

Table of Connectives
disclosure
", [if the current-exterior is a person]who[otherwise]which[end if] [regarding current-subject][are] ".

Table of Subject Introductions
disclosure
"[if the current-subject is the first-subject][regarding current-subject][They][otherwise][The current-subject][end if] [sits]"

Table of Nesting Carriers
disclosure
"[if the current-subject is carried by someone]carried[otherwise]worn[end if] by [current-exterior as a possibly-known item]"

Table of Nesting Exteriors
disclosure
"[in-on the current-exterior as a possibly-known item][if the current-exterior holds the player] beside you[end if]"

current-room-content-table is a table-name that varies. current-room-content-table is the Table of Room Content Disclosures.

Table of Room Content Disclosures
disclosure
"You can [optional also]see [a list of mentionable things in the current-subject] [if current-subject is the location]here[otherwise]in [the current-subject][end if]. ".

current-person-content-table is a table-name that varies. current-person-content-table is the Table of Person Content Disclosures.

Table of Person Content Disclosures
disclosure
"[holding-and-wearing][run paragraph on]"

To say holding-and-wearing:
	say "[if the prior named object is the current-subject][regarding current-subject][They][otherwise][The current-subject][end if] ";
	if the current-subject carries something mentionable and the current-subject wears something mentionable
	begin;
		if the number of mentionable things held by the current-subject is greater than 5
		begin;
			say "[regarding current-subject][have] [a list of things carried by the current-subject]. [regarding current-subject][They] [are] wearing [a list of things worn by the current-subject]. [run paragraph on]";
		otherwise;
			say "[are] carrying [a list of things carried by the current-subject] and wearing [a list of things worn by the current-subject]. [run paragraph on]";
		end if;
	otherwise if the current-subject carries something mentionable;
		if a random chance of 1 in 2 succeeds, say "[are] [optional also][one of]holding[or]carrying[at random] ";
		otherwise say "[regarding current-subject][have][run paragraph on] ";
		say "[a list of mentionable things carried by the current-subject]. [run paragraph on]";
	otherwise if the current-subject wears something mentionable;
		say "[are] wearing [a list of mentionable things worn by the current-subject]. [run paragraph on]";
	end if.

current-container-content-table is a table-name that varies. current-container-content-table is the Table of Container Content Disclosures.

Table of Container Content Disclosures
disclosure
"[The current-subject] [optional also][contain] [a list of mentionable things in the current-subject]. "
"In [the current-subject] [is-are a list of mentionable things in the current-subject]. "
"There [mentionable-are] [optional also][a list of mentionable things in the current-subject] in [the current-subject]. "


current-supporter-content-table is a table-name that varies. current-supporter-content-table is the Table of Supporter Content Disclosures.

Table of Supporter Content Disclosures
disclosure
"On [the current-subject] [is-are a list of mentionable things on the current-subject]. "
"There [mentionable-are] [optional also][a list of mentionable things on the current-subject] on [the current-subject]. "


current-prementioned-supporters-table is a table-name that varies.  current-prementioned-supporters-table is the Table of Prementioned Supporters.

Table of Prementioned Supporters
disclosure
"[The list of mentioned things which are on the current-subject] [mentioned-are] on [a current-subject][if current-subject supports something mentionable], which also [hold] [a list of mentionable things on the current-subject][end if]. "


current-prementioned-containers-table is a table-name that varies.  current-prementioned-containers-table is the Table of Prementioned Containers.

Table of Prementioned Containers
disclosure
"[The list of mentioned things which are in the current-subject] [mentioned-are] in [a current-subject][if current-subject contains something mentionable], which also [hold] [a list of mentionable things in the current-subject][end if]. "

Section 5 - Excluding concealed items

Rule for deciding whether all includes something (called special-target) while taking (this is the excluding concealed items rule):
	now special-target is marked for listing;
	follow the mentioning tedious things rule;
	follow the determining concealment rule;
	if the special-target is not marked for listing, it does not;
	make no decision.

Tailored Room Description ends here.

Tailored Room Description is an extension for use with Emily Short's Room Description Control. Tailored Room Descriptions provides a set of rules for writing paragraphs about objects.

Chapter: Using Tailored Room Description

Section: Overview of Tailored Room Description's Process

The behavior of Tailored Room Description is to go through the list of Seen Things prepared by Room Description Control and follow this protocol:

	(a) if the item in question has an initial appearance and has not been moved, print the initial appearance; otherwise, if it has a flexible appearance (see below), print the flexible appearance; otherwise, say that you see the item.

	(b) if the item is on or in something other than the location, mention the holder of the item and any other objects also in the holder of the item.

	(c) if the paragraph so generated has mentioned any containers or supporters that themselves hold unmentioned items, generate sentences mentioning the contents of those things, until everything referenced by the paragraph has been adequately revealed.

	(d) as an exceptional case, if the item is considered "deeply dull", a sentence will instead be printed listing the item together with all other "deeply dull" objects in a single sentence, as in "You also see here the wrench, the monkey, and the weasel." Items are only deeply dull if they share in having the lowest possible description-rank; according to the ranking rules of this extension, that means that they neither contain nor support anything, have no initial appearance, and have not been rendered interesting by any other ranking rule. It is possible to add further definitions to affect whether specific kinds of things are considered deeply dull; see the "Doors and doors" example below.

Section: Initial appearance, flexible appearance

Initial appearance is a description of something that is printed when the player looks and the object has not been moved. Tailored Room Description adds a "flexible appearance", which will be printed even if the object in question has been moved. So we might say

	The initial appearance of the cup is "Someone has casually tossed away a paper cup here."

so that after being moved it will simply be described in the collection of random objects; but

	The flexible appearance of the tripod is "A tripod is set up [if the location is indoors]on the floor[otherwise]on the ground[end if]."

so that the tripod will always have its own treatment, even if moved from room to room. If an item has both an initial appearance and a flexible appearance, the initial appearance will be consulted until the item is moved, and the flexible appearance afterward.

Section: Overriding the default for specific objects

The entire protocol can be overwritten by providing a more particular rule for writing a paragraph about for specific items; so for instance

	Rule for writing a paragraph about a person (called dude):
		say "[The dude] is standing way too close to you."

would print this sentence and omit all other results.

The printing of an item's holder is managed by the disclosing exterior activity. We can change the way this is handled by writing a new rule for disclosing exterior of something. For instance:

	Rule for disclosing exterior of tripod:
		say "[The tripod] is perched awkwardly on [the holder of the tripod]. "

Rules for disclosing exterior should ideally end with a period and a single space, in case the paragraph needs to continue thereafter.

The printing of an item's contents is managed by the disclosing contents activity. We can change the way this is handled by writing a new rule for disclosing contents of something. For instance:

	Rule for disclosing contents of the vase when at least two things are in the vase:
		say "[The list of things which are in the vase] are crammed together into [if the vase is mentioned][the vase][otherwise][a vase][end if]. "

Again, this rule should produce output ending in a period and space, allowing for further sentences to follow without pause.

Tailored Room Descriptions also excludes from TAKE ALL any items currently being concealed by our concealment rules.

Chapter: Extra and Related Features

Section: Ordering the descriptions and excluding items

Users of Tailored Room Description sometimes ask how they can prevent something entirely from appearing in a room description. The answer is that this functionality -- choosing items that should not appear in the room description at all -- can be manipulated using TRD's base extension, Room Description Control. That extension's documentation explains how to write ranking rules and description-concealing rules for a variety of situations.

Section: Change Log

Version 3 of Tailored Room Descriptions builds on previous versions by adding description for things carried or held by non-player characters and better handling for enterable containers.

Version 7 of Tailored Room descriptions moves to a new way of managing internal text: rules to construct paragraphs, instead of constructing sentences out of small snippets of text intermingled with code, refer to tables such as

	Table of Prementioned Containers
	disclosure
	"[The list of mentioned things which are in the current-subject] [mentioned-are] in [a current-subject][if current-subject contains something mentionable], which also [hold] [a list of mentionable things in the current-subject][end if]."

The disclosure entry here is a template used by the extension to create a viable sentence. One of these lines is selected at random from the table to use in each situation, which means that if we would like to diversify the range of sentence options, we can simply continue the table in our own code, as in

	Table of Prementioned Containers (continued)
	disclosure
	"[The list of mentioned things which are in the current-subject] [mentioned-are] in [a current-subject], together with [a list of mentionable things in the current-subject][end if]."

We may also swap these tables entirely for other tables of our own devising, as in

	When play begins:
		now the current-supporter-content-table is the Table of New Supporter Content.

The purpose of this change is to make the extension more flexible and more useful to authors working with alternative viewpoints (to recast the prose in first-person past tense, for instance) or in other languages. It also substantially reduces the number of individual rules and quantity of redundant code in the extension.
Changelog:

	Version 13.0.220524: Update for Inform 10.1.  Reformat Changelog.  (Modified by Nathanael Nerode.)
	Version 13/160601: Counterfeit Monkey version. Update for Inform 6M62. Fix tests. Remove dependency on Plurality.
	Version 8 tweaks the reporting of character possessions and worn items to appear more natural. It also adds section headings to the documentation.


Chapter: Change Log

Section: 3.1

Updated for I7 10.1 by Zed Lopez. Previous versions didn't have version numbers, so I capriciously gave it the version number 3.1.
The Standard Rules now have a Multiple Action Processing rulebook that's empty. So CMA now uses the Consolidated Multiple Actions rulebook instead.
Added a Modifying the multiple object list activity, documented below.

Section: Basic behavior

Normally, when the player issues a command such as "take knife and fork" or "drop all", Inform prints a series of messages, one for each object, preceded by the object name. This often results of a series of default messages, which we might rather see grouped into a single message. Consolidated Multiple Actions combines the reports of such multiple actions into a single message when the actions have standard results. The default behavior requires no additional work beyond including the extension.

Before printing any reports, the actions are tested and divided into three categories. "Standard" action results are those which succeed and print nothing when run silently, i.e., they print text only in report rules (parenthetical and bracketed output, such as "(first taking the...)" and debugging messages are ignored here). "Failed" action results are those which fail. "Noteworthy" action results are ones which either succeed but print text other than in a report rule (e.g., they use an "after" rule), or are explicitly marked as noteworthy. This can override standard and failed results. An action result can be marked as noteworthy by using the phrase:

		indicate noteworthy consolidation

This can be used anywhere in the rulebooks for the action except the "report" rules (which are not consulted during testing).

After the action results are determined, a single report message is printed for all of the objects which had standard results. Then the failed actions are run sequentially, with the usual reporting, followed by the noteworthy actions. By default, the object name is printed before failed action results (as in the ordinary behavior), but is omitted before noteworthy action results.

There is one use option: "Use strict action consolidation checking" will require that nothing at all be printed (not even parenthetical messages) in order for an action result to be considered standard. Finally, when using the "actions" debugging commands, messages will be printed showing the results of the consolidation tests.

Section: New rules and rulebooks

The extension adds a new rulebook, the consolidated multiple actions rules, which is run after Inform has determined that there are multiple objects but before the action is run on them. Actions can take multiple objects if they have grammar lines including the "[things]" token; the standard library allows this for the actions of taking, dropping, removing from, putting on, and inserting into. This rulebook contains one rule, "the consolidate multiple actions rule", which consolidates and reports the standard action results as described above. Other rules may be added to this rulebook for additional processing of multiple objects (such as reordering the multiple object list). After this rulebook finishes, the action is applied to the objects remaining in the multiple objects list in the normal fashion.

The consolidate multiple objects rule creates two lists of objects: "the consolidated objects list" which contains those objects whose reports have been consolidated, and "the noteworthy objects list" which contains those objects whose action results are noteworthy. These may be consulted for use in further customization.

The results of an action are categorized by a second rulebook, the action consolidation results rules. This rulebook has three possible outcomes: standard, failed, and noteworthy. New rules may be added here to change the default determination of which actions are standard.

Section: Handling the pronoun "them"

After printing the consolidated objects, these objects are stored in a list called "the stored consolidated objects" so that they may be referred to in input using the pronoun "them". This pronoun is also used by Inform to refer to plural-named objects, and so will be updated in the normal fashion (in which case it will no longer refer to the last list of consolidated objects). The usual testing command "pronouns" can be used to determine what the current interpretation is. It may be desirable to try to update this list when printing a list of objects in other places, but since there is no uniformly desirable behavior this task is left to authors. This may be done using the phrase:

	set pronouns from (L - a list of objects)

and we can test whether "them" currently refers to a list of objects with:

	if them refers to a list...

This feature is somewhat experimental, and authors who wish to disable it can do so by adding the lines:
	The update the pronoun them to consolidated objects rule is not listed in any rulebook.
	The replace them by stored consolidated objects rule is not listed in any rulebook.

Chapter: New activities

The extension introduces four new activities.

Section: Reporting consolidated actions

The Reporting consolidated actions activity prints the action report message for the consolidated objects. Any action which can take multiple objects needs to have a reporting consolidated actions rule or nothing will be printed for standard results. Rules are provided for the built-in actions which allow multiple nouns. Actions by NPCs are also consolidated and need reporting rules; these should have the preamble:

	Rule for reporting consolidated actions when asking someone to try (the action)

since multiple actions by an NPC will only be generated in response to the player issuing a command to the NPC.

The text substitution "[consolidated objects]" may be used in such report rules to list the objects whose reports are being consolidated; this will invoke the "printing consolidated objects" activity.

We should be careful not to write a rule like "Rule for reporting consolidated actions when taking the plate", since only the last object in the consolidated objects list will match here. Instead, we should phrase the rule as "Rule for reporting consolidated actions when taking and the plate is listed in the consolidated objects list".

Section: Printing consolidated objects

The Printing consolidated objects activity prints the actual list of the objects whose reports are consolidated. The default behavior of this activity makes use of Inform's list writing functions so that the "grouping together" activity may be applied to it. The following phrase may be used to print out a list using these abilities:

	list the elements of (L - a list of objects)...(options);

This phrase can take all of the same phrase options as "list the contents of" (as well as the option "with capitalized first article"). For convenience, the most common two uses of this phrase can be invoked with:

	say the grouped (L - a list of objects)
	say The capitalized grouped (L - a list of objects)

Section: Announcing a multiple occurrence of something

The Announcing a multiple occurrence of something activity prints the message which precedes an action for an object which has not been consolidated. By default, this prints the objects name followed by a colon for failed actions, and nothing for noteworthy actions. The variable

	the number of multiple actions so far this turn

can be used to tell how many such actions have occurred in order to vary such messages.

Section: Modifying the multiple object list

There isn't a "multiple object list" variable in Inform 7: there's a `To decide what list of objects is the multiple object list` phrase that returns a dynamically created I7 list based on the I6 multiple_object array. So the Modifying the multiple object list activity has a list of objects variable named the `multi-object list`. A `First before modifying the multiple object list` rule assigns the multiple object list phrase result to the multi-object list; a `Last after modifying the multiple object list` rule invokes the `alter the multiple object list to <list of objects>` phrase to write it back. By default, there are no `For modifying the multiple object list` rules; you can add your own, for instance:

	For modifying the multiple object list when smearing:
		if the number of entries in the multi-object list > 1 and the second noun is listed in the multi-object list, remove second noun in the multi-object list;

So now `>smear all with hot sauce` won't feature trying to smear the hot sauce with itself. You can't use the `for deciding whether all includes something activity` for this, because the `second noun` hasn't been assigned yet when it runs.

Note the `if the number of entries in the multi-object list > 1` condition. It's your responsibility to not allow the multi-object list to become empty. The results would be messy if it did.

Chapter: Examples


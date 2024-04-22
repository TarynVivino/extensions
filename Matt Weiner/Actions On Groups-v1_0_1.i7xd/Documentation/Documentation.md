PURPOSE OF EXTENSION

Ordinarily in Inform 7, once we have specified that "marry [things]" is to be understood as marrying, the command "MARRY DOMINIQUE AND DEVIN" would produce an output somewhat like this:
	
	Dominique: Married.
	Devin. Married.

If the player is officiating at a wedding ceremony rather than practicing plural marriage, we might want an output more like:
	
	You marry Dominique and Devin to each other.

And we would like the effects of this action to operate on Dominique and Devin as a pair rather than first on Dominique and then on Devin; they should wind up related by marriage, rather than each of them acquiring a separate "married" property.

Actions on Groups allows us to make certain actions apply to an entire player-specified group all at once, rather than applying serially to each member of the group. To do this we use a kind of action, groupable action, and a special rulebook, the Action on Groups rules. When groupable action is run on more than one object at once, the Action on Groups rules are checked. If any of the Action on Groups rules are run, then any further processing of the action is halted; the game will not print announcements such as "Dominique:" and will not run the normal Before-Instead-Check-Carry Out-After-Report rules for the action.

BASIC USE OF EXTENSION

To set up action on groups for an action, we must declare it as groupable action:
	
	Examining is groupable action.

We must create an Understand token to allow it to apply to multiple things, if it is not already so defined in the Standard Rules:

	Understand "examine [things]" as examining.

And we must create one or more Action on Groups rules for the action:
	
	Action on groups rule for examining:

The Action on Groups rulebook has default outcome success, so if one Action on Groups rule runs, no other such rules will run; unless we tell the rule to allow the rulebook to continue by invoking a "make no decision" phrase at the appropriate point. If the Action on Groups rulebook ends in success or failure, then the "multiple actions already taken" truth state will be set to true; this will suppress all further processing of actions that turn and will prevent the announcements of the individual items from the multiple object list from printing.

The list of items specified by the player is the multiple object list (see §21.6 of Writing with Inform). If we want to write rules that apply only when a given list has been specified, we can use the phrase "when dealing with"; "dealing with L" is true when L is a list that contains all and only the objects in the multiple object list. So a rule beginning:

	Action on groups rule for marrying when dealing with {Dominique, Devin}:

would fire in response to "MARRY DOMINIQUE AND DEVIN" but not in response to "MARRY DOMINIQUE, DEVIN AND ALEX." See Example C below for examples of "dealing with" rules.

We can also write rules that fire whenever the multiple object list contains anything meeting a certain description, so that:

	Action on groups rule for putting something on the table when dealing with a glass:

will fire when we put multiple things on the table, and at least one is a glass.

And we can write rules that fire whenever the multiple object list contains only items meeting a certain description, so that:

	Action on groups rule for putting something on the table when dealing only with glasses:

will fire when we put multiple glasses on the table, but nothing else. (The difference between this and "...when dealing with the list of glasses" is that this rule will fire even if we are not putting every glass on the table.)

It is important to write "Action on groups rule for putting something on the table when dealing with a glass" rather than "Action on groups rule for putting a glass on the table"; the latter rule will only fire if the first object in the multiple object rule is a glass. When you want a rule heading to specify something about the multiple objects being acted on, always use one of the "dealing with" phrases or something that directly refers to the multiple object list.

GROUP-ONLY ACTION

We can specify a groupable action as group-only action:

	Quizzing it about is group-only action.

The Action on Groups rulebook for group-only actions is backstopped by the can't use undesignated groups rule, which prints a refusal to act on multiple objects. The idea is that a group-only action does not work on arbitrary groups, but only when the group the player's command picks out is a group ithatf the author has written a rule for dealing with. If the player's command picks out a different group, so that none of the author's Action on Groups rules fires, then the extension will print a refusal to act on multiple objects and stop all further processing of the actions. See "Sword Talk" for an example of group-only action.

REDIRECTING ACTIONS

The multiple object list governs whether or not we are acting on groups, and what groups we are acting on. If we wish to invoke a group action from within another rule, we must first alter the multiple object list to the list we wish to act on, and then try the action we wish on some entry of that list. Example C below demonstrates this; when searching a supporter that supports multiple items, we redirect the action to examining the contents of the supporter.

If we wish to invoke a non-group action from within a group action, we must first empty out the multiple object list. Example A below demonstrates this; when quizzing the swordsmith about the list of swords, we redirect the action to quizzing the swordsmith about the ideal sword. We must first empty the multiple object list, or Inform will treat "try quizzing the swordsmith about the ideal sword" as if it were an action on the list of swords, and we will enter an infinite loop.

A custom phrase is provided for emptying the multiple object list:

	clear the multiple object list.
	
If we wish to modify the multiple object list and then continue processing the action using the normal multiple object machinery, we should do this:

	prepare to act on (whatever the new list is);
	continue the action.

The "prepare to act" phrase changes the multiple object list to the new list, and also changes the noun and the current item from the multiple object list to the first item of the new list, so that Inform is ready to begin processing the multiple actions normally. Simply changing the multiple object list would lead to undesirable behavior. Example C demonstrates these kinds of redirection.

If the multiple object list is in the second noun place (for instance, if we had written "SHOW JEWEL TO AISHA, BARRY, AND CLEON"), then we should use the phrase option "as second nouns":

	prepare to act on (new list), as second nouns;
	continue the action.

CAUTIONS

As mentioned above, do not try to write a rule beginning "Action on groups rule for taking a rock:"; write "Action on groups rule for taking when dealing with a rock:". The first rule would only apply when the first item in the multiple object list is a rock.

Do not use "stop the action" or "...instead" in an Action on Groups rule, unless you want to proceed with the standard way of processing the action serially for each object in the multiple object list; use "rule fails" instead. In order for the multiple actions already taken flag to be set, the Action on Groups rulebook must end in success or failure. "Stop the action" and "...instead" cause the specific rule that is running to end in failure, but terminate the rulebook with no decision. "Rule fails" ends both the specific rule and the rulebook in failure, which will cause the flag to be set properly and will terminate any further action processing that turn.

If you are trying another action from within an Action on Groups rule, be very careful to properly prepare the multiple object list! If your new action is an action on a single object, clear the multiple object list before trying it; otherwise the new action will be processed as a multiple action (which could well cause an infinite loop). If the new action is a multiple action, prepare to act on the new list; simply changing the multiple object list could have strange results if the action being tried gets out of sync with the multiple object list.

If you wish more than one Action on Groups rule to run in a turn, for instance to check the group action in one rule and carry it out in another rule, then the first rules must end in "make no decision" in order to allow the next rule to run. But some rule must end in a decision, or the multiple actions already taken flag will not be set and normal action processing will not be preempted. Since Action on Groups rules have default success, it should be enough to ensure that some rule that does not contain the "make no decision" phrase runs if the rulebook is not cut off earlier with "rule fails."

Some of the more complicated things that one might wish to try with Actions on Groups can require very delicate handling of the success and failure of the rulebooks. See the implementation of "The Facts Were These, Refactored" (at http://www.intfiction.org/forum/viewtopic.php?f=7&t=19285) for an example. Use with care. This is a reimplementation of the example "The Facts Were These" from the Inform documentation, using Actions on Groups to handle the new multiple actions.

ACKNOWLEDGMENTS

Thanks to Björn Paulsen, bg, and Daniel Stelzer for advice, suggestions, and encouragement, and to Björn and bg for some of the example code. Comments and suggestions can be sent to matt@mattweiner.net.

EXAMPLES

Example A, "Sword Talk," demonstrates a simple case of group only action. We would like the swordsmith to respond to "ask smith about swords" with chat about the ideal sword, but
	
	Understand "swords" as the ideal sword.

will not work; the parser will understand "swords" as the plural of sword anyway. We define quizzing as a groupable action, so that "ask smith about swords" will result in quizzing the smith about the list of swords, and write a rule for dealing with quizzing when dealing with the list of swords. (Note that we must clear the multiple object list so this action is not itself treated as multiple.) We also define quizzing as group-only action, so any other attempt to ask about multiple things will fail. (Since there is no "[any things]" token as of Inform 6L38, we have to engage in a bit of trickery to add the off-stage things to scope when quizzing; the "[any things]" token is planned for future releases.) Most of the code for "Sword Talk" is by Björn Paulsen.

Example B, "Matrimony," allows us to marry two people at a time to each other. We write a series of Action on Groups rules to check that we are only marrying people, that we are marrying exactly two people, and so on. As discussed above, the initial rules must invoke "rule fails" when they fail, and must end with "make no decision" in order to allow the rulebook to proceed to the next rule; but the final rule must not end in "make no decision." Every rule is marked "Last" to ensure that they run in source code order (which is the order we want).

Example C, "Glasses," demonstrates a way of consolidating some of the actions and processing the rest normally. The action on groups rule for dealing with a glass first puts all the glasses on the table, counts how many there were, and prints an appropriate message for them. Anything else in the multiple object list is collated in Extras. If there is one such item, we print the name of the item and then try putting it on the table (first clearing the multiple object list so it is not processed as a multiple action). If there is more than one such item, we invoke the phrase "prepare to act on Extras" before continuing the action, so the rest of the action will be processed as a normal multiple action on Extras. IMPORTANT: This style of example only works if there is no way to fail to put a glass on the table. If a glass could fail to be put on the table, then we would have to know the result of the action before we knew whether to report the glass as part of the original group or put it in Extras. This extension provides no facility for doing that.


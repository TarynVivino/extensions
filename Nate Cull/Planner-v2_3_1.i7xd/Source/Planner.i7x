Version 2.3.1 of Planner by Nate Cull begins here.

"A universal goal planner for self-directed NPCs."

Section - Definitions and Globals


Planning-token is a kind.

Planning-relation is a kind of planning-token.

Planning-action is a kind of planning-token.

No-action is a planning-action.
Success-action is a planning-action.

Planning-marker is a kind of planning-token.

No-plan is a planning-marker.
No-step is a planning-marker.
Plan-pending is a planning-marker.

No-object is a thing.

Table of Goals
Parent	Plan	Step	Token	Param1	Param2
0	0	0	no-plan	no-object	no-object
with 20 blank rows

The planning actor is a person that varies.

The requested relation is a planning-relation that varies.
The requested param1 is an object that varies.
The requested param2 is an object that varies.

The planned action is a planning-action that varies.
The planned param1 is an object that varies.
The planned param2 is an object that varies.

The desired plan is a number that varies.
The desired step is a number that varies.
The desired relation is a planning-relation that varies.
The desired param1 is an object that varies.
The desired param2 is an object that varies.

The suggested token is a planning-token that varies.
The suggested param1 is an object that varies.
The suggested param2 is an object that varies.

The working plan is a number that varies.
The working step is a number that varies.

Planner verbosity is a number that varies. Planner verbosity is 0.

The action success flag is a number that varies. 



Section - Main Routines

[This is the main entry point for calling Planner. It will find an action that satisfies the desired relation/object/object triad, and then attempt to execute that action.]

To have (A - a person) plan an action for (C - a planning-relation) with (P1 - an object) and (P2 - an object):
	if debugging planner, say "Planner: starting planning for [A].";
	if debugging planner, say "Planner: testing goal 1: [C] [P1] [P2]: [run paragraph on]";
	now the planning actor is A;
	now the requested relation is C;
	now the requested param1 is P1;
	now the requested param2 is P2;
	now the planned action is no-action;
	now the planned param1 is no-object;
	now the planned param2 is no-object;
	if goal C with P1 and P2 is true:
		now the planned action is success-action;
		if debugging planner, say "true, no work to do[line break]";
	otherwise:
		if debugging planner, say "false, generating plans [run paragraph on]";
		clear the goal table;
		choose row 1 in the Table of Goals;
		now the Token entry is the requested relation;
		now the Param1 entry is the requested param1;
		now the Param2 entry is the requested param2;
		now the Parent entry is 0;
		now the Plan entry is 0;
		now the Step entry is 0;
		expand goal 1;
		advance all goals;
	if debugging planner:
		if the planned action is no-action, say "Planner: no action chosen";
		otherwise say "Planner: choosing [the planned action] [the planned param1] [the planned param2]";
		say "[paragraph break]";
	execute the planned action;

[The core loop. Fill up the goal table line by line, reading goals as we come to them, considering each one, and if we can't satisfy it then spawning new subgoals and adding them to the end of the table. If we can fully satisfy a goal, then we end and return the action of that one as our chosen action.

My terminology is a little confusing as I sometimes use the words 'plan' and 'goal' apparently interchangeably. That's because of the way the data is stored. Let's have some definitions:

A Goal is a triad of Relation, Object, Object. (The Cat Is-on The Mat). It represents a piece of world state that we are actively trying to make true. Goals are related to one another in a tree structure. There is a top-level Goal which may have multiple child goals, and so on.

A Plan is a set of (Goal, Goal, Goal... Action). If every goal, evaluated in sequence from left to right, is true, then the actor should take the suggested Action.

So every Goal can have multiple Plans, and every Plan can have multiple Goals.

You'd think the best way to store this would be with a tree structure: Goals spawning Plans spawning Goals and so on. And you'd probably be right. But since we don't have dynamic memory allocation and can't easily do trees, we use a table instead. And each row of that table indicates *both* a Goal *and* a Plan, depending on context. Somewhat confusing. That is to say: 

* The top row indicates the top-level Goal.
* All new rows added to the table indicate separate Plans which are suggested as ways of satisfying outstanding Goals.
* We examine each Plan, checking each of its Goals, and eventually we either return an Action, or stop at a Goal which is blocking us. When that happens, we mark up the table row to now indicate a *Goal*, and continue on.

So as we go on, each line in the table that we've visited consists of a Goal. Lines that we've added but not yet visited indicate unevaluated Plans.

Each row has:
* Parent -the Goalrow which this is a plan or goal for
* Plan - the Plan number of the Parent goal which this is a plan for
* Step - (once we've turned from a Plan to a Goal) the Step number of this Plan at which we stopped evaluating because we found a not-currently-true Goal or an Action
* Token - either an Action or a Relation, or else a Marker (a kind of note-to-self used for internal communication between the Planner routines)
* Param1 - the first Object of the Action or Relation - only set once we have a Goal or Action
* Param2 - the second Object of the Action or Relation - only set once we have a Goal or Action

Adding new Plans for a Goal I have called Expanding. 
Scanning a Plan, checking each of its subgoals, I have called Advancing.

]

To advance all goals:
	repeat with G running from 2 to the number of filled rows in the Table of Goals begin;
		advance goal G;
		if an action was planned, now G is 9999;
	end repeat;



[Advancing a Goal: Here we're scanning through each item in the current plan, checking what we've got, and if it's a subgoal, testing if it's true or not. If it's false, then we check if it's unique (ie, not listed as one of our prior goals). This prevents endless recursive loops - we deal with each goal once and only once, regardless of how many parent goals need it. If it's an action, we return that as our choice - this means we pick the first action that we find, ie, the action with the smallest number of goal-expansion steps. This should generally mean we take the shortest path toward getting our way.

To read each Step, we call the 'planning' rulebook, passing the desired relation/object/object and the desired Plan and Step through the 'desired...' global variable block. We increment Step each time. We stop once we don't get a response from the rulebook. This means that plans need to use consecutive Step numbers starting from 1. The rulebook will be hit once for every Step, plus once for counting Steps, of every Plan, plus one more for counting Plans. So if a plan requires expensive calculations, it is a good idea to test that 'desired plan' is set to the plan number before you run the calculation, or you'll be running it lots of times and throwing the result away.

]

To advance goal (G - a number):
	choose row G in the Table of Goals;
	let our parent be the Parent entry;
	let our plan be the Plan entry;
	now the suggested token is the Token entry;
	now the suggested param1 is the Param1 entry;
	now the suggested param2 is the Param2 entry;
	choose row our parent in the Table of Goals;
	let our relation be the Token entry;
	let our param1 be the Param1 entry;
	let our param2 be the Param2 entry;
	let the final step be 0;
	if debugging planner, say "Planner: reading goal [G] (plan [our plan] for goal [our parent])[line break]";
	repeat with Sx running from 1 to 9 begin;
		suggest a goal for our relation with our param1 and our param2 for plan our plan at step Sx;
		if the suggested token is a planning-marker begin; 
			now Sx is 9999;
			choose row G in the Table of Goals;
			now the Token entry is no-plan;
			now the Param1 entry is no-object;
			now the Param2 entry is no-object;
		end if;
		if the suggested token is a planning-relation begin;
			if debugging planner, say "Planner: testing step [Sx]: [suggested token] [suggested param1] [suggested param2]: [run paragraph on]"; 
			if goal suggested token with suggested param1 and suggested param2 is false begin;
				if debugging planner, say "false ";
				if goal the suggested token with the suggested param1 and the suggested param2 is unique begin;
					if debugging planner, say "and unique, generating plans [run paragraph on]";
					choose row G in the Table of Goals;
					now the Token entry is the suggested token;
					now the Param1 entry is the suggested param1;	
					now the Param2 entry is the suggested param2;
					now the Step entry is Sx;
					now the final step is Sx;
					now Sx is 9999;
					expand goal G;						
				otherwise;
					if debugging planner, say "but duplicate, cancelling plan[line break]";
					choose row G in the Table of Goals;
					now the Token entry is no-plan;
					now the Param1 entry is no-object;	
					now the Param2 entry is no-object;
					now the Step entry is Sx;
					now the final step is Sx;
					now Sx is 9999;
				end if;
			otherwise;
				if debugging planner, say "true";
			end if;
		end if;
		if the suggested token is a planning-action begin;
			if debugging planner, say "Planner: testing step [Sx]: [the suggested token] [the suggested param1] [the suggested param2]: action[line break]";
			now the planned action is the suggested token;
			now the planned param1 is the suggested param1;
			now the planned param2 is the suggested param2;
			choose row G in the Table of Goals;
			now the Token entry is the suggested token;
			now the Param1 entry is the suggested param1;
			now the Param2 entry is the suggested param2;
			now the Step entry is Sx;
			now the final step is Sx;
			now Sx is 9999;
		end if; 
	end repeat;


[Expanding a Goal: Here we are just dropping new empty lines onto the goal table to indicate Plans we have yet to explore. About all the information we need is the Parent and Plan entries. The rest we will look up in the Parent row once we get there.]


To expand goal (G - a number):
	choose row G in the Table of Goals;
	let our relation be the Token entry;
	let our param1 be the Param1 entry;
	let our param2 be the Param2 entry;
	repeat with P running from 1 to 9 begin;
		suggest a goal for our relation with our param1 and our param2 for plan P at step 1;
		if the suggested token is no-plan begin;
			[we've run out of plans]
			now P is 9999;
		otherwise;
			[add new goal, checking for out of space]
			if the number of blank rows in the Table of Goals is greater than 0 begin;
				[add a new goal, as just a parent/plan/step entry]
				let the last row be the number of filled rows in the Table of Goals;
				increase the last row by 1;
				choose row the last row in the Table of Goals;
				now the Parent entry is G;
				now the Plan entry is P;
				now the Step entry is 1;
				now the Token entry is plan-pending;
				now the Param1 entry is no-object;
				now the Param2 entry is no-object;
				if debugging planner, say "[P] [run paragraph on]";
			otherwise;
				if debugging planner, say "Planner: goal table is full, ignoring new goal.";
			end if;
		end if;
	end repeat;
	if debugging planner, say "[line break]";




Section - Rulebooks


[This is where you put rules to generate plans. Sample rules for general situations are defined in 'Basic Plans'. You may need to use procedural rules to override basic rules with more specific ones for your game. IE, if there are particular objects that can only be obtained through solving a puzzle or manipulating a machine, you may need a specific plan for 'being-in' or 'being-touchable' for that object.]

Planning rules is a rulebook.


[This is where you put rules to test goals. Normally this would be a simple check against an I7 relation or property, and does not often need to be overridden.]

Planning-testing rules is a rulebook.


[This is where you put rules to execute actions. Normally this would be a simple call of 'try the planning actor trying <action>'. Then you would create 'report <actor> trying <action>' rules to have custom descriptions of what your particular actor is doing.]

Planning-acting rules is a rulebook.


[If the top-level goal tests as true, a 'success-action' action gets returned and this rulebook gets called. There is no more work for Planner to do, the actor has succeeded in their longest term goal. This might mean an actor needs to change their condition, or a scene change happens.]

Planning-success rules is a rulebook.


[If no action can be suggested toward the top-level goal, a 'no-action' action gets returned and this rulebook gets called. The actor is currently frustrated, blocked or baffled somehow. Generally this indicates that something the author didn't expect happened, and a new plan needs to be written to cover this situation.]

Planning-failure rules is a rulebook.


[If Planner returned an action, but when the actor tried to execute it (usually with 'trying...'), the I7 action failed. (Currently this condition happens if no 'Carry Out' rule ran.) This also generally indicates an incomplete set of plans, or an unexpected situation. ]

Planning-acting-failure rules is a rulebook.




Section - Planning Routines


To suggest a goal for (C - a planning-relation) with (P1 - an object) and (P2 - an object) for plan (P - a number) at step (Sx - a number):
	now the desired relation is C;
	now the desired param1 is P1;
	now the desired param2 is P2;
	now the desired plan is P;
	now the desired step is Sx;
	now the suggested token is no-plan;
	now the suggested param1 is no-object;
	now the suggested param2 is no-object;
	follow the planning rulebook;

To really suggest (T - a planning-token) with (P1 - an object) and (P2 - an object):
	now the suggested token is T;
	now the suggested param1 is P1;
	now the suggested param2 is P2;

To plan (P - a number):
	now the working plan is P;
	now the working step is 0;
	if the desired plan is the working plan, now the suggested token is no-step;

To suggest (T - a planning-token) with (P1 - an object) and (P2 - an object):
	increase the working step by 1;
	if the desired plan is the working plan and the desired step is the working step, really suggest T with P1 and P2;

To suggest (T - a planning-token) with (P1 - an object):
	suggest T with P1 and no-object;

To suggest (T - a planning-token):
	suggest T with no-object and no-object;




Section - Executing Actions

[Carry out someone trying doing something:
	now the action success flag is 1;]

The successful-action rule is listed after the check stage rule in the specific action-processing rules.

This is the successful-action rule: 
	if the actor is not the player, now the action success flag is 1.

To execute the planned action:
	if the planned action is no-action begin;
		follow the planning-failure rules;
	otherwise;
		if the planned action is success-action begin;
			follow the planning-success rules;
		otherwise;	
			now the action success flag is 0;
			follow the planning-acting rules;
			if the action success flag is 0, follow the planning-acting-failure rules;
		end if;
	end if;


Section - Utility Routines

		
To decide whether goal (C - a planning-relation) with (P1 - an object) and (P2 - an object) is unique:
	repeat through the Table of Goals begin;
		if the Token entry is C and the Param1 entry is P1 and the Param2 entry is P2, decide no;
	end repeat;
	decide yes;

To decide whether an action was planned:
	if the planned action is no-action, decide no;
	decide yes;

To decide whether a goal was suggested:
	if the suggested token is a planning-marker, decide no;
	decide yes;

To clear the goal table:
	repeat through the Table of Goals begin;
		blank out the whole row;
	end repeat;

To decide whether goal (C - a planning-relation) with (P1 - an object) and (P2 - an object) is true:
	now the desired relation is C;
	now the desired param1 is P1;
	now the desired param2 is P2;
	follow the planning-testing rules;
	if rule succeeded begin;
		decide yes;
	end if;
	decide no;

To decide whether goal (C - a planning-relation) with (P1 - an object) and (P2 - an object) is false:
	if goal C with P1 and P2 is true, decide no;
	decide yes;



Section - Debugging Verbs - Not for release

To decide if debugging planner:
	if planner verbosity is 1, decide yes;
	decide no;

Enabling the planner verbosity is an action out of world.
Understand "plans on" as enabling the planner verbosity.
Understand "plans" as enabling the planner verbosity.
Carry out enabling the planner verbosity:
	say "Planner will now show debugging messages. Type 'plans off' to run silently, or 'plans list' to show the current planning table.";
	now the planner verbosity is 1;

Disabling the planner verbosity is an action out of world.
Understand "plans off" as disabling the planner verbosity.
Carry out disabling the planner verbosity:
	say "Planner will now run silently.";
	now the planner verbosity is 0;

Dumping the planner table is an action out of world.
Understand "plans list" as dumping the planner table.
Carry out dumping the planner table:
	let G be 0;
	repeat through the Table of Goals begin;
		increase G by 1;
		say "Goal [G] (parent [the Parent entry] plan [the Plan entry] step [the Step entry]): [the Token entry] / [the Param1 entry] / [the Param2 entry][line break]";
	end repeat;

Planner ends here.

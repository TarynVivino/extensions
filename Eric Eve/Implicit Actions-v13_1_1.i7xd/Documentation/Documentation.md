Chapter: The Basics - A Set of Implicit Actions

Section: Introduction - Using Impicit Actions

The documentation of this extension may look quite long, but that's because it has quite a few features to explain, not because it's hard to use if we just want to use its functionality "out of the box". To do that, we just need the line:

	{*}Include Implicit Actions by Eric Eve

At the start of our code, and we'll get all (or most) of the benefits of this extension without further ado. The rest of this documentation explains what those benefits are how we can extend them.


Section: What's New in Version 10

Previously Implicit Actions used the before rules to trigger implicit actions. Version 10 implements a new rulebook, the precondition rules, for this purpose. The precondition rules run between the Before rules and the Instead rules, in fact just before the basic accessibility rule. This is both because they are the same kind of thing as other rules inserted at this point (for example the carrying requirements rule which the Standard Rules uses to perform some implicit takes is located around this stage), and also, more pragmatically, because it should make it easier to write Before rules that are certain to pre-empt implicit actions, which may sometimes be necessary.

Section: What's New in Version 11

Previous versions of Implicit Actions could not be used with Locksmith by Emily Short. Version 11 can be used with Locksmith, in which case it leaves Locksmith to do all the handling of locks and doors. On the other hand if Implicit Actions is used there should be no need for Locksmith, since if Locksmith is not present Implicit Actions will provide similar functionality in a manner more consistent with the rest of Implicit Actions.

Section: What's New in Version 12

Version 12 makes no change to the functionality of Implicit Actions, but makes several changes both to the extension code and to the examples to avoid using Inform features that became deprecated in release 6E59. This should help to ensure that Implicit Actions continues to be usable with whatever future release of Inform withdraws the deprecated features.

Release 6E59 of Inform introduced its own implicit action handling for inserting objects into containers, putting objects on supporters, and going through closed doors. The Implicit Actions extension replaces the Standard Library rules that carry out these implicit actions with its own versions to avoid clashes and duplications.

Section: Common Cases of Implicit Action

There are many common situations in Interactive Fiction where an action is annoyingly prevented because some other completely obvious action has not been carried out. We want to put the diamond in the jewel case, but we're told we have to be holding it first (even though it's right there in front of us). We want to leave to the north, but we're told we can't because the front door is in the way, even though the door isn't locked and it should be obvious that we want to open it in order to go through it. Interactive Fiction is a much smoother and less frustrating experience if these kinds of obvious action are carried out for us. Actions that are carried out in order to allow other actions to go ahead are called "implicit actions". The Implicit Actions extension defines a number of these, and all we have to do is to include the extension in our game to enjoy the benefit of them.

In particular, the extension provides implicit actions for the following cases:

1. If we want to search a container that's closed, the game will first try to open it for us.

2. If we want to put something in a container that's closed, the game will first try to open it for us.

3. If we want to go through a door that's closed, the game will first try to open it for us.

4. If we want to open a door or a container that's locked, the game will first try to unlock it for us.

5. If we want to put something we're not holding into or onto something, the game will first try to take it for us.

6. If we want to leave the room while we're in an enterable container or on an enterable supporter, the game will first try to take us out of it.

7. If we want to take something that's inside a closed transparent container, the game will first try to open the container for us.

8. If we want to use a key to lock or unlock something but we're not carrying the key (although it's within reach), the game will first try to take it for us.

Note that Inform release 6E59 increases the range of implicit actions carried out by the Standard Rules, which may reduce the need for the Implicit Actions extension in some cases. Implicit Actions nevertheless extends the range of implicit actions further than does the Standard Rules and provides for better reporting of implicit actions. It also provides a franework for creating further implicit actions.

Section: Chains of Actions

Sometimes more than one implicit action may need to be carried out before we can go ahead with the command the player actually ordered. For example, suppose we want to go north through a locked door, the key to which is lying in plain sight on the table. To go through the door we first need to open it, to open it we first need to unlock it, and to unlock it we first need to take the key. The design of this extension allows each implicit action to trigger a further implicit action in turn. When there's a chain of actions like this, where each is needed to allow the next to be performed, the extension also combines all the implicit action into a single report, so that what we'd see is something like:

	>n
	(first taking the key, then unlocking the door with the key, then opening the door)

	Front Garden
	The house lies to the south...

Note that although the extension can combine a chain of implicit actions (up to any practicable) length into a single report like this, it cannot do the same with a sequence of implicit actions that are mutually independent. For example, if the player character is in a chair and needs to go through a closed door in order to leave the room, both leaving the chair and opening the door are implicit actions that need to be carried out to let us leave the room, but neither depends on the other. So what we get in this case is:

	>n
	(first leaving the chair)
	(first opening the door)
	

Rather than the neater:

	>n
	(first leaving the chair, then opening the door)

Although it may have been possible to have made the extension do the latter, the gain in neatness would probably not justify the increase in complexity (for the user as much as the author!). Moreover, the present system does have the slight advantage of making it clear which implicit actions are chained (each dependent on the one before) as opposed to simply carried out in sequence (with no dependence between them).

Section: Success and Failure

We have so far assumed that all implicit actions succeed, but that's not necessarily the case. Suppose we try to go north through a closed door which is also locked, and the key needed to unlock it is nowhere in sight. With this extension we'd then get:

	>n
	(first trying to open the door)
	The door seems to be locked.

Notice the different wording of the implicit action report here. With this extension "(first trying to do something)" means that we need to do something to carry out the command we actually issued, so we tried to do it, but we didn't succeed. This is less misleading (and less jarring) than:

	>n
	(first opening the door)
	The door seems to be locked.

The most natural meaning of which is that we did actually manage to open the door (even though in fact we couldn't, because it was locked).

When a chain of implicit commands is being carried out, it is stopped as soon as one of them fails, with a message explaining why it failed at that point. So, going back to the earlier example where the key was available, we could (in principle) get either:

	>n
	(first trying to take the key)
	One look at the scorpion sitting on the key quickly changes your mind about trying to take it.

Or

	>n
	(first taking the key, then trying to unlock the door with the key)
	The lock proves too stiff; perhaps it needs oiling.

Or

	>n
	(first taking the key, then unlocking the door with the key, then trying to open the door)
	Something seems to be jamming the door, even though it's not locked.

Section: Changing the Implicit Action Reporting Style.

All the example we have seen so far have reported implicit actions in parentheses (the normal style). To see them reported more like normal actions, we can just chnage the global variable parenthesize implicit actions to false, then we'd see (for example):

	>n
	You take the key, then unlock the door with the key, then try to open the door.

	Something seems to be jamming the door, even though it's not locked.

This is done via a global variable rather than a use option, so that we can (should we wish) change the style during the course of the game. To switch off the parenthesized style of implicit action right from the start, include the following:

	{*}when play begins:
	now parenthesize implicit actions is false.

Section: Overriding or Preventing Implicit Actions

Once in a while an implicit action may not do what we want. For example, if the player encounters a red door marked DANGER it might be a bad idea to open it via an implicit action. To prevent the door being opening implicitly we need to write a special rule for implicitly opening it. This could simply take the form:

	rule for implicitly opening the red door:
	do nothing.

But this could easily cause the action to fail with no explanation at all:

	>north
	>

We could instead have our rule explicitly abort the implicit action, so that we get the standard failure report:

	rule for implicitly opening the red door:
	abort the implicit action.

This is fine provided opening the red door will only ever be a top-level implicit action (i.e. not one triggered by another implicit action higher up in the chain). If the aborted implicit action is generated by one higher up in the chain, however, the result can be be a bit messy. Suppose we have a transparent cabinet containing a brass key that we need to unlock a door that needs to be open if the player is to go north, but for some reason we don't want the cabinet to be open via an implicit action (perhaps because it's full of poison gas and we don't want to kill the player as an unintended side-effect of some other action). Stopping the implicit action with "abort the implicit action" would generate the following rather messy output:

	>n
	(first trying to take the brass key)
	The cabinet isn't open.

	The cabinet isn't open.

	It seems to be locked.

	You can't, since the oak door is in the way.

We can prevent this mess by having our custom rule print a failure message instead:

	rule for implicitly opening the cabinet:
	say "It may be dangerous to open the cabinet."

Or we can get the best of both worlds with:

	Rule for implicitly opening the cabinet:
	abort the implicit action with message  "It may be dangerous to open the cabinet."

This will then use a standard failure message in the implicit opening is generated by a top-level action (an explicit TAKE THE BRASS KEY), say, but will show our custom message if the implicit opening is triggered by another implicit action (such as implicitly taking the key to unlock the door).

A final technique is to tailor the failure message to the context by writing a rule that is specific to one implicit action taking place in the context of another:

	Rule for implicitly opening the cabinet while implicitly unlocking the oak door:
	say "You need the brass key to unlock the door, but the cabinet is closed."



Chapter: Locks, Keys and Doors

Section: Using Implicit Actions Can with Locksmith

Because the Implicit Actions extensions provides its own way of dealing with implicit actions, there is no need to use Emily Short's Locksmith extension at the same time. Locksmith carries out implicit actions for locks and doors, which Implicit Actions also does. On the other hand, if you want to use both extensions together you now can. The code in Implcit Actions that deals with keys and doors has all been marked "(for use without Locksmith by Emily Short)", so that if Locksmith and Implicit Actions are both included in the same game, the two shouldn't clash. If both extensions are included, the handling of implcit actions for Locks, Keys and Doors will thus be entirely left to Locksmith, and none of the rest of the present chapter will apply.

There's no particular reason for using both Implicit Actions and Locksmith in the same game. Implicit Actions does just about everything Locksmith does, but in a slightly different way, so using the two together in the same game will give a less consistent playing experience than using Implicit Actions alone. It has been made possible to use the two together in case (a) some authors prefer the way Locksmith handles doors and keys, but want to extend the range of impllcit actions available or (b) an author starts by using Locksmith and then wants to extend the range of implicit actions used without changing code already wrirtten.

The example games below can be made to work with Locksmith, with minor modifications. References to the "key" kind would need to be changed to "passkey", and "keyring" likewise changed to "keychain". In Example C "The known-key of the oak door is the brass key." needs to be replaced with "The brass key unbolts the oak door." and "Rule for implicitly opening the cabinet while implicitly unlocking the oak door" will need to be commented out or removed, since there's no "implicitly unlocking" activity when Locksmith is used. The examples can then be compiled and run, but don't work quite so smoothly.

In sum: Implicit Actions can now be used with Locksmith, but in most cases it's probably better to use it without.


Section: Remembering Keys

Whenever a key (which can be an ordinary thing, or can be of kind key) is successfully used to lock or unlock something, it is remembered as the known-key for that item (door or container). Thereafter that key will automatically be used to unlock or lock that item (door or container) whenever possible. Every door and container has a known-key property (as well as its matching key property) for this purpose. Thus, if there are doors or containers in the game for which the player character is already meant to know the matching key at the start of the game, we can simply define the known-key property on those doors or containers accordingly. Normally, of course, the known-key property should then contain the same object as the matching key property.

Section: Locking and Unlocking Without Keys

A door or container can be defined as not needing a key to be locked or unlocked by giving it a matching key property of no-key. It can then be locked with LOCK DOOR or unlocked with UNLOCK BOX. This can be used to model doors and containers locked with catches, bolts, paddles and the like.

The extension defines bolting and unbolting actions corresponding to the grammar LOCK WHATEVER and UNLOCK WHATEVER. If WHATEVER has a matching key of no-key then these commands simply lock and unlock the whatever object without further ado. Otherwise, if the whatever object has a known-key, and the known-key is to hand, these commands use the known-key to lock and unlock the object.

If we want to define an object that locks and unlocks without a key but is controlled by some other mechanism (such as a combination lock), then we should probably not define it as lockable.

Section: Keys and Passkeys

Like Locksmith, this extension defines a passkey kind. There is no need to use the passkey kind to get any of the functionality described above. The only thing a passkey does that a ordinary thing doesn't is to display a list of the objects it's known to lock and unlock when it is examined or listed in inventory. We don't need to use a passkey at all if we don't want this particular feature.

The extension also defines a key kind (to which passkey belongs). We don't need to use the key kind to make keys work (unless we want to put them on a keyring, see below), but defining keys to be of kind key can help the parser make a more intelligent choice of indirect object in locking and unlocking commands.

Section: Keyrings

Finally, the extension defines a keyring kind (equivalent to keychain in Locksmith). This may be used to carry keys around on (provided they are defined to be of kind key or passkey). Keys on a keyring can be used to lock and unlock things without being removed from the keyring.

Chapter: Defining New Implicit Actions

This extension makes it relatively easy to define further explicit actions that work within the same framework (this is illustrated in Example B). The steps involved are basically:

1. Define a new activity that actually carries out the implicit action.

2. Define one or more Before rules that make use of the activity.

It's not strictly necessary to use an activity at stage 1; a to phrase would do the job, for example; but using an acitivity keeps the new implicit action consistent with the implicit actions defined in this extension, and allows us to use conditions like "while implicitly dropping the priceless vase". But whether we use an activity or not (and from now on we'll assume we do), our definition should follow this pattern:

	initialize the implicit action;
	silently try opening the obstructor;
	finish the implicit action with participle "opening" infinitive "open" object "[the obstructor]" and condition (whether or not the obstructor is open).

That is we start our definition with the phrase "initialize the implicit action". We next write a phrase to silently try doing whatever the implicit action needs to attempt. We finally use the phrase "finish the implicit action" with a number of additional piece of information that facilitate the construction of the implicit action report:

- with participle "opening": this part of the phrase defines the verb form to use if the implicit action succeeds (e.g. in "opening the door" or "taking the key"). We just need the present participle here (e.g. "opening" or "taking").

- infinitive "open": this part of the phrase defines the verb form to use if the implicit action fails (e.g. in "trying to open the door" or "trying to take the key"). We just need the inifinitive (minus "to") here (e.g. "open" or "take").

- object: this part of the phrase is a string that will expand into the object or objects involved in the implicit action (e.g. "the door" or "the door with the brass key"). We'll probably need to use substitutions here so that this string will expand into the object or objects actually used.

- and condition: this final part of the phrase needs to define a truth state expression that evaluates to true if the implicit action succeeds and false if it fails. For example, in the case of an implicit opening action, the object we were trying to open (here called "the obstructor") will be open if the impicit opening succeeded, and closed if it did not, so we can use the expression (whether or not the obstructor is open) here.

We'd then normally wrap all this in an activity:

	Implicitly opening something is an activity.

	Rule for implicitly opening something (called the obstructor) (this is the implicit opening rule):
	initialize the implicit action;
	silently try opening the obstructor;
	finish the implicit action with participle "opening" infinitive "open" object "[the obstructor]" and condition (whether or not the obstructor is open).

Finally, we write a precondition rule to invoke the implicit activity when needed, e.g.:

	Precondition for going through a closed door (called the obstructor):
	carry out the implicitly opening activitity with the obstructor;
	if the obstructor is closed and implicit action attempted is true, stop the action.

We add the final test, stopping the action if the door remains closed after the implicit attempt to open it, because in that case the implicit action will already have printed its own failure message ("The door seems to be locked" or whatever), so we don't also want to see the failure message a later check rule would display.

The clause "and implicit action attempted is true" is added to allow for exceptions. If there's a particular door we don't want the implicit opening activity to apply to, for example the Very Dangerous Door, then we can write a special carry out implicitly opening rule for it that sets implicit action attemped to false. In that case the action can proceed to the normal check stage to display the normal failure message.

The implicitly opening action used as an example here is already defined in this extension. To see an illustration of a new implicit action that isn't, see Example B below.



Chapter: Limitations and Cautions

Section: Player Actions Only

Implicit Actions works only for actions carried out by the Player Character, not for Non-Player Characters. For many games, this will suffice, since the primary aim is to provide a smoother experience for players than to create more intelligent NPCs. Nevertheless, the framework provided here could be extended to work with NPCs, but the best way to do this would be to write a further extension (NPC Implicit Actions, say) that provides the relevant functionality for characters other than the player character. Such an extension would probably need to include this one, and then add a host of "Before someone going through a closed door" type rules.

A simple (and rather basic) NPC Implicit Actions extension is available from the official Inform Extensions page.


Section: Overflowing the Text Buffer

Implicit Actions makes use of the Text Capture extension to store the text that might be output during an implicit action to explain why an action failed (and then display it at the end of the implicit action report). The text capture buffer can hold a maximum of 256 characters, so it should be used only for fairly short pieces of text, not huge amounts of it all at once. Overrunning the buffer will cause a run-time error in Z-Code games, and the loss of all characters beyond the 256th in Glulx games. If a larger buffer is needed, because you want to display a very long failure message in the course of an implicit action, you need to change the text buffer size to something larger. You can do this with the option "Use maximum capture buffer length of at least 512" (or whatever other buffer size you want).


Section: Debugging Commands (Such as RULES)

Implicit Actions makes use of the Text Capture extension to suppress output until it is ready to display a summary of implicit actions. This can play havoc with some of the debugging commands, particularly RULES and RULES ALL, since if they're active when an implicit action is being carried out, their output will also be captured, with the probable result that the text capture buffer will overflow, the rule tracing won't be displayed, and the game output will consist of a huge number of error messages (or the game may hang altogether). Be very careful, then, in using RULES in a game that includes Implicit Actions.

Section: Redirecting Actions - Instead vs Before

It's not uncommon in Inform programming to use Instead rules to redirect one action to another, e.g.:

	Instead of opening the sliding door, try pulling the red lever.

This could cause problems if used in conjuction with Implicit Actions, however. Implicit Actions generates implicit actions in Precondition rules, which are run before Instead rules, so our redirection could be defeated in this case:

	>open the sliding door
	(first trying to unlock the sliding door)
	The sliding door seems to be locked.

The solution is to use before rather than instead to carry out the redirection:

	Before opening the sliding door, try pulling the red lever instead.

This also applies if we need to write code to carry out the effect of an action. For example the standard rules require an actor not to be in a container or on a supporter when travelling from a location, but if we want to prevent egress through a window unless the player character is on a ladder (for example), we need to code round that restriction. The following would work just fine:

	Before going through the window when the player is on a ladder:
	say "You clamber through the window.";
	if the location is the Short Narrow Alley then  move the player to the Private Office;
	otherwise move the player to the Short Narrow Alley;
	stop the action.

But it would not have worked if we'd put the same code in an instead rule; Implicit Actions would have carried out an implicit action to remove the player character from the ladder before the instead rule was reached, defeating the purpose of the ladder.



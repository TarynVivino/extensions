Chapter: The Basics

Section: What Limited Implicit Actions Is For

Limited Implicit Actions is a cut-down version of the Implicit Actions extension that may prove useful in either or both of the following circumstances:

(a)	We're writing a Z-Code game that's running short of space, and we want something less resource-hungry than the full Implicit Actions extension.

(b)	We want some implicit actions, but we also want to use Emily Short's Locksmith extension.

If neither of these conditions hold, then we may well do better to use the full Implicit Actions extension.

Note that some of the functionality of Limited Implicit Actions is now provided by the Standard Rules as from Inform release 6E59. Limited Implicit Actions does, however, handle a few more cases than the Standard Rules, as well as providing an extensible framework for simple implicit actions and slightly better reporting of implicit actions that fail.

Limited Implicit Actions uses less resources than the full Implicit Actions extensions because:

(a)	It makes no use of indexed texts or the Text Capture extension.
(b)  It does not supply implicit actions for doors and locks (though these can be added if required, see below).
(c)  It does not attempt to group implcit action announcements, e.g. "(first taking the brass key, then unlocking the oak door with the brass key, then opening the brass door)".

What Limited Implicit Actions (LIA) does do is:

(a)	Perform an implicit take if needed for PUT X IN Y or PUT X ON Y.
(b)	Perform an implicit open if needed for SEARCH X, PUT X IN Y (when Y is a closed container) or TAKE X (when X is in a closed transparent container).
(c)	Perform impliciit exiting if the player tries to go somewhere while on an enterable supporter or in an enterable container.


Addtionally, LIA tries to guess whether the implicit action will succeed or fail, and announce it accordingly, e.g. "(first taking the ball)" for a success and "(first trying to take the ball)" for a failure. These guesses are likely to be right most of the time so long as our game doesn't do anything out of the ordinary. The guesses will be wrong, however, when, for example, we use an Instead or Before rule to prevent an action that would otherwise have succeeded. This limitation is one of the prices we have to pay for using Limited Implicit Actions instead of the full Implicit Actions extensions, but it may be a limitation worth living with.

Section: How Limited Implicit Actions Works

To use Limited Implicit Actions we simply have to include it in our game. The appropriate implicit actions described above will then be performed for us automatically. We only need to know how it works in any more detail if we want to extend or customize its behaviour.

Limited Implicit Actions follows the same basic structure as the full Implicit Actions extensions. That is, it defines a new rulebook, the Precondition Rules, which operates between Before and Instead. It also defines a number of activities which actually carry out the preconditions specified for the precondition rules. For example, in order to put Object A on Object B we first need to be holding Object A, so Limited Implicit Actions defines the precondition rule:

	Precondition for putting something on something when the noun is not carried (this is the take object before putting it on rule):
		if the noun is on the second noun then
			say "[The noun] [are] already on [the second noun]." instead;
		carry out the implicitly taking activity with the noun;
		if the noun is not carried then stop the action.

Limited Implicit Actions then defines the corresponding activity. Although there's already an implicitly taking activity in the Standard Rules, LIA defines its own version:

	Rule for implicitly taking something (called the object desired) (this is the implicit taking rule):
		let actdesc be "trying to take";
		if the object desired is portable and the object desired is touchable, let actdesc be "taking";
		say "(first [actdesc] [the object desired])[command clarification break]";
		silently try taking the object desired.

The precondition is similar to the corresponding precondition in the full Implicit Actions extension. The corresponding activity is rather simpler. The example above illustrates how LIA guesses whether an implicit action is likely to suceed or fail (and thus choose the "first taking" or "first trying to take" form of the implicit action announcement). In the case of implicit taking, it assumes the implicit action will only fail if the object to be taken isn't portable or if it can't be touched. The implicitly opening action likewise assumes that it will fail if the object to be opened is locked (or unopenable or not touchable). This guessing is necessary because the implicit action announcement is displayed before the action is attempted (unlike the full Implicit Actions extensions, which constructs the implicit action announcement in the light of what actually happens).

We can also extend Limited Implicit Actions. The next chapter gives some examples that can be pasted into game code if required, or else adapted to create other types of implicit action. A game that requires anything much more sophisticated than Limited Implicit Actions can provide may, however, be better off using the full Implicit Actions extension.

Chapter: Extending Limited Implicit Actions

Section: General Notes

We can extend Limited Implicit Actions by adding new precondition rules and defining new implicit action activities for them to trigger. A precondition rule defines what implicit action may be required under particular circumstances (e.g. unlocking a locked door before trying to open it); the activity then defines how that implicit action is reported and carried out. Hopefully this will become clearer from the examples given below, all of which concern doors, locks and openable containers. If we're using Emily Short's Locksmith extension, we probably won't need much of this, but if we're not and we want auto-opening and auto-unlocking doors (without the full Implicit Actions extension), the following examples may be useful. Each section of code is provided with a paste button so it can easily be added to your own project.

Section: Auto-Opening Doors

To make a closed door automatically open when the player tries to go through it, we can add the following to our game code:

	{*}Precondition for going through a closed openable door (called the obstructor):
		carry out the implicitly opening activity with the obstructor;
		if the obstructor is closed, stop the action.

The implicitly opening activity is already defined in Limited Implicit Actions, so that's all we need to do.


Section: Auto-Unlocking

If we're not using Emily Short's Locksmith extension, and we want Limited Implicit Actions to handle the implicit unlocking of doors (and containers), then we need to do a little more work. We'll assume that anything lockable needs a key to lock and unlock it. We'll also assume that implicit unlocking shouldn't occur until the player knows which key to use for a given door or container, and that the player only finds this out by successfully locking or unlocking something with the correct key. When this happens, the door or container that's just been locked or unlocked will be given the key-tested property. We can then add automatic unlocking of key-tested doors and containers to our game with the following code:

	{*}A door can be key-tested. A door is usually not key-tested.
	A container can be key-tested. A container is usually not key-tested.

	Carry out unlocking something with something:
		now the noun is key-tested.

	Carry out locking something with something:
		now the noun is key-tested.

	Precondition for opening a closed locked key-tested thing when the matching key of the noun is touchable:
		carry out the implicitly unlocking activity with the noun;
		if the noun is locked, stop the action.

	implicitly unlocking something is an activity.

	Rule for implicitly unlocking something (called the obstructor):
		let my-key be the matching key of the obstructor;
		say "(first unlocking [the obstructor] with [the my-key])[command clarification break]" (A);
		silently try unlocking the obstructor with my-key.

Note that if we want the player to start out knowing which key unlocks a particular door or container (e.g. because it's the front door to his/her own house), we can just define that door or container as being key-tested from the outset, for example:

	The front door is a key-tested scenery door. The matching key is the large iron key.


Section: Smarter Auto-Unlocking

The foregoing code does the job, but its output can be slightly untidy, since it can typically produce output like:

	>e
	(first trying to open the oak door)
	(first unlocking the oak door with the brass key)

Since implicitly unlocking followed by implicitly opening is such a common case, we can improve this output by adding the following rule:

	{*}Rule for implicitly opening a closed locked openable key-tested thing (called the obstructor):
		let my-key be the matching key of the obstructor;
		if my-key is not carried, continue the activity;
		say "(first unlocking [the obstructor] with [the my-key], then opening [it-them of the obstructor])[command clarification break]" (A);
		silently try unlocking the obstructor with my-key;
		silently try opening the obstructor.

Which will change the output in this case to the rather neater:

	>e
	(first unlocking the oak door with the brass key, then opening it)

Section: Smarter Key Selection

Once the player knows which key is needed to lock or unlock something, it would be good if our game would automatically select the right key for the job in response to LOCK WHATEVER or UNLOCK WHATEVER. We can achieve this very simply by pasting the following code into our game;

	{*}Does the player mean locking a key-tested thing with the matching key of the noun: it is very likely.

	Does the player mean unlocking a key-tested thing with the matching key of the noun: it is very likely.

Section: Implicit Closing

Finally, it might be neat to have doors and containers implicitly closed when the player tries to close them. We can define the precondition so that it applies only when implicit closing would be sensible, and then the definition of the associated activity becomes very simple:

	{*}Precondition for locking an open openable lockable thing with something:
		carry out the implicitly closing activity with the noun;
		if the noun is open, stop the action.

	Implicitly closing something is an activity.

	The last for implicitly closing something (called the open-thing):
		say "(first closing [the open-thing])" (A);
		silently try closing the open-thing.

In this case defining a separate implicitly closing activity may be overkill, however. If we're only ever going to want implicit closing to operate with locking, we can remove the overhead of another activity by compressing our implementation to this:

	{*}Precondition for locking an open openable lockable thing with something:
			say "(first closing [the noun])" (A);
			silently try closing the noun;
			if the noun is open, stop the action.

This may be a better pattern to follow for similar cases.

Section: Conclusion - Implicit Actions and Limited Implicit Actions

It's relatively straightforward to extend Limited Implicit Actions to cover more situations. The examples shown above can be pasted straight into your code it your game has doors and locks but you're not using Emily Short's Locksmith. On the other hand, Limited Implicit Actions is meant to be limited (to keep it small); if you find yourself trying to reinvent too many wheels to get it to do what you want, you may be better off using the full Implicit Actions extensions.

Note that Implicit Actions and Limited Implicit Actions should never be both included in the same game. There should never be any reason for including both, and your game won't compile if you try. It should, however, be relatively easy to switch between them. If you find yourself running out of space in a Z-Code game, you can try including Limited Implicit Actions instead of Implicit Actions. Conversely, if you find that Limited Implicit Actions isn't giving you enough functionaliy, you can switch to Implicit Actions instead. If you've defined any Preconditions or implicit activities of your own, you'll need to make some adjustments to them. If you change from Limited Implicit Actions to Implicit Actions you'll need to strip out any of the above door and lock examples you've added to your code, since equivalent functionality is already supplied in Implicit Actions.


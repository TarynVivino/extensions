Ordinarily, if the player tries to speak to an inanimate object, he receives a response such as "You can only do that to something animate."

Sometimes, however, we'd like to have an item in the game that is not a person but still responds to queries -- much like the shipboard computer on Star Trek.

"Inanimate Listeners" allows us to declare any objects to be addressable, as in

	The computer is an addressable scenery thing in the Bridge.

Once this is done, the player can ask questions or make remarks to the computer, which we can then handle in the same way we might handle remarks made to a non-player character.

By default, a persuasion rule also prevents us from ordering inanimate objects to do a full range of actions; the player will receive a response like this:

	>computer, n
	The computer cannot do everything a person can.

If we wish to remove this, we need to use the following line:

	{*}The unsuccessful persuasion of inanimate objects rule is not listed in any rulebook.

We can then substitute our own persuasion rules allowing the inanimate item to do specific actions.


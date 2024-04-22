Behavior in interactive fiction is not pre-determined but instead chosen moment to moment.  There are three instances where we may wish to comment on a kind of behavior:  before the behavior is tried, after the behavior is done, and after the behavior was attempted but wasn't able to be done.  For example,

	Before an actor behaving ill-bred in the presence of the governess:
		say "'Don't you dare do that.  Please remember what happened to poor Lydia!'".
	
	After an actor behaving ill-bred in the presence of the governess:
		say "'You should be ashamed of yourself.  What if you had been seen?'".
	
	Unsuccessful attempt by an actor behaving ill-bred in the presence of the governess:
		say "'Well I suppose you feel very foolish now.  Jane and Elizabeth would never have tried such a thing.'".

Typically in Inform, our player's character has their failed attempts narrated by the Check rules, and our non-player characters' failed attempts are narrated by the Unsuccessful Attempt By rules.  However, this presents two problems.  First, how do we comment on our player failing to achieve a general kind of behavior, since we cannot write "Check behaving ill-bred"?  And secondly, in games with multiple possible player-characters, where do we put the failure messages for each of them?  In our example, neither Kitty's or Mary's messages are always approprate for the Check rules, because we don't know ahead of time if the player wishes to be the studious Mary or sociable Kitty.  We don't wish to be prejudiced.

This small extension runs the Unsuccessful Attempt By rules for the player's character, treating him or her no differently than anyone else.  So when we write a rule beginning with "Unsuccessful attempt by an actor", we really mean it.

By default, this extension silences the built-in library messages that Inform uses for check rules.  (Extensions will still print their messages, but most extensions are ready to have said messages replaced.)  The built-in library messages may be restored by:

	{*}When play begins: change silent checks to false.



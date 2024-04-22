I do not currently recommend using this, but I am uploading it as documentation of both the problems in the Standard Rules and the minimally invasive solutions.  It is probably better to use a more comprehensive replacement of the room description rules; but this will do the minimum fix.

Suppose you have an enterable supporter in a room: say, a bed or tabletop.
Suppose it has a "rule for writing a paragraph about", giving it a special description.
Suppose you also have an item intended to sit on the bed -- like sheets.
Suppose they also have a "rule for writing a paragraph about".

In the Standard Rules, the following problems arise:

1. If you're in the bed, the description of the bed won't be printed, whether or not you have a special paragraph for it.  Even if you eliminate the rule which appears to prevent it, which this extension does, it will still be suppressed.  This is because the bed is marked as "mentioned" when it's printed in the header, as follows:

Bedroom (in the bed)

This suppression may or may not be desirable.  (In the case of a bed with a special paragraph, probably not desirable!) This extension unmentions everything after printing the heading and before printing the room description, thus fixing this problem.

This behavior can be reverted to the Standard Rules behavior as follows:

	The unmention things mentioned in room heading rule is not listed in any rulebook.
	The don't mention player's supporter in room descriptions rule is listed before the don't mention scenery in room descriptions rule in the printing a locale paragraph about rulebook.
	
The second line is probably unnecessary, as that rule in Standard Rules is probably redundant.

2. Items on the bed will frequently be printed with an "On the bed are sheets." even if you have a special paragraph for them.  This is because the rule for printing the "On the bed are..." line may execute before the rule for printing special paragraphs.  This printing marks the items mentioned, suppressing the special paragraph.

This extension offers the items a chance to print their special paragraphs first, using the usual "write a paragraph about" activity.  Please note that it won't check concealment, mentionedness, etc.; if you want to, you should check

	if the item is locale-supportable and the tabletop does not conceal the item

Note that the Standard Rules define locale-supportable as follows:
	Definition: a thing (called the item) is locale-supportable if the item is not scenery and the item is not mentioned and the item is not undescribed.

This is hooked through the "items on supporters paragraph production" rulebook, so it can be disabled with:

	The offer items to writing a paragraph about rule is not listed in the items on supporters paragraph production rulebook

Unfortunately, things on the tabletop with special paragraphs will be listed before the tabletop itself.  This is a limitation of this architecture, which is why you may want to use Room Description Control by Emily Short instead.

3. The Standard Rules will sometimes print "On the bed is nothing."  Before printing the "On the bed are..." phrase, the standard rules check that something which is not scenery, not undescribed, and not already mentioned is on the bed.  But if that something is concealed, or gets mentioned mid-description, it won't be printed, ending up with the "nothing" result!  This extension fixes this by correctly counting the items to be listed before deciding whether to print a sentence.

Changelog:

	1.0.220523 - Update to Inform v10 version numbering.  No other changes.  Large Game Speedup had to be fixed, though.
	1/210315 - First version


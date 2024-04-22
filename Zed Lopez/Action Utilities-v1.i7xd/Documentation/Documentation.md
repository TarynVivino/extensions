Inform offers these phrases

	if action requires a touchable noun
	if action requires a touchable second noun
	if action requires a carried noun
	if action requires a carried second noun
	if action requires light

to get information about the current action, but doesn't provide a way to get that information about an arbitrary action or action name. This extension does.




[
Include (-
[ ActionNameHasFlag ac flag at;
!ac = BlkValueRead(stored, STORA_ACTION_F);
at = FindAction(ac);
if (at == 0) rfalse;
if (ActionData-->(at+AD_REQUIREMENTS) & flag) rtrue;
rfalse;
];
-)
]
[Definition: an action (called ac) is in need of a touchable noun if I6 condition "ActionHasFlag(BlkValueRead({ac}, STORA_ACTION_F), TOUCH_NOUN_ABIT)" says so (it needs a touchable noun).]



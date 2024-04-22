Version 1 of Action Utilities by Zed Lopez begins here.

"Get metadata for actions and action names"

To decide what text is the command text of (ac - action):
 (- BlkValueRead(stored, STORA_COMMAND_TEXT_F) -).

[ if at == 0, that means ac is an action name.
  if at is non-zero, that means ac is an action and so
  we overwrite ac with that action's action name ]

Include (-
[ ActionHasFlag ac flag at;
if (at) ac = BlkValueRead(ac, STORA_ACTION_F);
at = FindAction(ac);
if (at == 0) rfalse;
return ~~(ActionData-->(at+AD_REQUIREMENTS) & flag);
];

[ ActionBitmask ac at;
if (at) ac = BlkValueRead(ac, STORA_ACTION_F);
at = FindAction(ac);
if (at == 0) return 0;
return ActionData-->(at+AD_REQUIREMENTS);
];

Global AnyNounMask;

-)

Definition: an action is out-of-world rather than in-world if I6 condition "ActionHasFlag(*1, OUT_OF_WORLD_ABIT, 1)" says so (it is out of world).

Definition: an action name is out-of-world rather than in-world if I6 condition "ActionHasFlag(*1, OUT_OF_WORLD_ABIT)" says so (it is out of world).

Definition: an action is act-requested rather than act-unrequested if I6 condition "BlkValueRead(stored, STORA_REQUEST_F)" says so (it is requested).

To initialize AnyNounMask: (- AnyNounMask = NEED_NOUN_ABIT | TOUCH_NOUN_ABIT | TOUCH_SECOND_ABIT | CARRY_NOUN_ABIT | CARRY_SECOND_ABIT; -)

after starting the virtual machine: initialize AnyNounMask.

To decide what number is the bitmask of (ac - action name): (- ActionBitmask({ac}) -).

To decide what number is the bitmask of (ac - action): (- ActionBitmask({ac},1) -).

To decide if (ac - action name) applies to nothing: (- ~~(ActionHasFlag({ac}, AnyNounMask) -).

To decide if (ac - action) applies to nothing: (- ~~(ActionHasFlag({ac}, AnyNounMask, 1) -).

To decide if (ac - an action) requires a/-- noun:
(- ActionHasFlag(BlkValueRead({ac}, STORA_ACTION_F), NEED_NOUN_ABIT, 1) -)

To decide if (ac - an action) requires a/-- touchable noun:
(- ActionHasFlag(BlkValueRead({ac}, STORA_ACTION_F), TOUCH_NOUN_ABIT, 1) -)

To decide if (ac - an action) requires a/-- touchable second noun:
(- ActionHasFlag(BlkValueRead({ac}, STORA_ACTION_F), TOUCH_SECOND_ABIT, 1) -)

To decide if (ac - an action) requires a/-- carried noun:
(- ActionHasFlag(BlkValueRead({ac}, STORA_ACTION_F), CARRY_NOUN_ABIT, 1) -)

To decide if (ac - an action) requires a/-- carried second noun:
(- ActionHasFlag(BlkValueRead({ac}, STORA_ACTION_F), CARRY_SECOND_ABIT, 1) -)

To decide if (ac - an action) requires light:
(- ActionHasFlag(BlkValueRead({ac}, STORA_ACTION_F), LIGHT_ABIT) -)

To decide if (ac - an action name) requires a/-- noun:
(- ActionHasFlag(BlkValueRead({ac}, STORA_ACTION_F), NEED_NOUN_ABIT) -)

To decide if (ac - an action name) requires a/-- touchable noun:
(- ActionHasFlag({ac}, TOUCH_NOUN_ABIT) -)

To decide if (ac - an action name) requires a/-- touchable second noun:
(- ActionHasFlag({ac}, TOUCH_SECOND_ABIT) -)

To decide if (ac - an action name) requires a/-- carried noun:
(- ActionHasFlag({ac}, CARRY_NOUN_ABIT) -)

To decide if (ac - an action name) requires a/-- carried second noun:
(- ActionHasFlag({ac}, CARRY_SECOND_ABIT) -)

To decide if (ac - an action name) requires light:
(- ActionHasFlag({ac}, LIGHT_ABIT) -)

Action Utilities ends here.

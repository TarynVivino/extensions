Version 2.2.1 of Extended Debugging by Erik Temple begins here.

"Provides a way for the author to release a build of a game while retaining both custom and built-in debugging commands. Also wraps Inform's debug tracing routines in phrases that authors can use to trigger rule-tracing from the source text rather than from the command prompt and provides other debugging features."


Use authorial modesty.

Include (- constant DEBUG; constant STRICT_MODE; -) after "Definitions.i6t".

Section - Phrases for immediate tracing

Use initial intensive debug tracing translates as (- Constant INIT_ALL_TRACE; -).
Use initial brief debug tracing translates as (- Constant INIT_RULE_TRACE; -).

Before starting the virtual machine:
	If the initial intensive debug tracing option is active:
		turn on intensive rule-tracing;
		turn on actions-tracing;
		turn on scenes-tracing;
	otherwise if the initial brief debug tracing option is active:
		turn on brief rule-tracing;
		turn on actions-tracing;
		turn on scenes-tracing.


Section - Wrappers for actions commands

To turn on actions-tracing:
	(- ActionsOnSub(); -)

To turn off actions-tracing:
	(- ActionsOffSub(); -)


Section - Wrappers for rule-tracing commands

To turn on intensive rule-tracing:
	(- RulesAllSub(); -)
	
To turn on brief rule-tracing:
	(- RulesOnSub(); -)
	
To turn off rule-tracing:
	(- RulesOffSub(); -)


Section - Wrappers for scene-tracing commands

To turn on scenes-tracing:
	(- ScenesOnSub(); -)

To turn off scenes-tracing:
	(- ScenesOffSub(); -)


Section - Wrapper for the glklist command

To show the/-- glk/glklist list/--:
	(- GlkListSub(); -)


Chapter - Custom rule-tracing (Ron Newcomb)

[Thanks to Ron Newcomb for providing the custom rule-tracing code.]

To enable brief/-- rule-tracing for (R - a rule):
	(- if (debug_rules) DB_Rule({R}, {R}); -).

To enable intensive rule-tracing only/-- for (R - a rule):
	(- if (debug_rules >= 2) DB_Rule({R}, {R}); -).

Include (- Global save_debug_rules; -) after "Definitions.i6t".

To suspend rule-tracing:
	(- save_debug_rules = debug_rules; debug_rules = 0; -).

To re-enable rule-tracing:
	(- debug_rules = save_debug_rules; -).


Extended Debugging ends here.


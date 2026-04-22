Version 2.0 of Trace Output by Taryn Michelle begins here.

"Implements granular trace messages (for debugging) that can be categorized and turned on or off from the command line during development, and produce no output in a release build"

Part - Implement Trace Output Stubs (for release only)

[IMPORTANT: Though we define the trace-token type for release, we DO NOT add or any of the trace-related properties to the "thing" or "room" classes. 
 What this means, in practice, is that authors of stories or extensions who choose to enable tracing for specific objects (things or rooms) in their story, 
 must do so within a section similarly marked "for release only".]

A trace-token is a kind of thing. A trace token can be traceable or untraceable. A trace-token has a text called the trace-tag. A trace-token is usually traceable.

[We DO provide release build stubs for any of the public phrases an author might incorporate throughout their code]

verbose_trace is an object. priority_trace is an object.

To trace (T - text) as/with (subject - an object): do nothing. [Rooms and things both derive from objects now]
[To trace (T - text) as (subject - a room): do nothing.]
To trace (T - text): do nothing.
To priority trace (T - text): do nothing;
To verbose trace (T - text): do nothing;

To decide whether we're tracing (subject - an object): decide no.
[To decide whether we're tracing (subject - a room): decide no.]
To decide whether we're tracing: decide no.

trace-prefix is a text that varies. trace-prefix is "".
trace-suffix is a text that varies. trace-suffix is "". 

To say trace-tag: do nothing.

Section - Release build stubs for in-line segmented substitutions (for use with Nested Text Capture by Taryn Michelle)

[ The debug versions of these only exist if Nested Text Capture is in use, hence we only define the do-nothing stubs under the same circumstances ]
[ Capture all trace message text between trace and /trace tags and just throw it away ]
To say trace -- beginning say_suppress_inline_trace_for_release -- running on: begin text capture. 
To say trace (subject - an object) -- beginning say_suppress_inline_trace_for_release -- running on: begin text capture.
To say /trace -- beginning say_suppress_inline_trace_for_release: end text capture. 
[ Priority and verbose inline versions ]
To say priority trace -- beginning say_suppress_inline_trace_for_release -- running on: begin text capture. 
To say priority trace (subject - an object) -- beginning say_suppress_inline_trace_for_release -- running on: begin text capture. 
To say verbose trace -- beginning say_suppress_inline_trace_for_release -- running on: begin text capture. 
To say verbose trace (subject - an object) -- beginning say_suppress_inline_trace_for_release -- running on: begin text capture. 

Part - Implement Debug Trace Output (not for release)

Section - Enabling trace output for in-world objects (things and rooms)

A thing can be traceable or untraceable. A thing is usually untraceable.  
A thing can be traced or untraced. A thing is usually untraced.
A thing has a text called the trace-tag. 

A room can be traceable or untraceable. A room is usually untraceable. 
A room can be traced or untraced. A room is usually untraced.
A room has a text called the trace-tag. 

When play begins:
	repeat with subject running through traceable things:
		if the trace-tag of the subject is empty and the subject is not default_trace_output:
			now the trace-tag of the subject is the printed name of the subject.

Trace-output-active is a truth state that varies. [Default value is false]

A trace-token is a kind of thing. A trace-token is usually traceable. A trace-token is always scenery. [NOT "privately named", because we want to reference them in commands to control trace output]

default_trace_output is a trace-token. The trace-tag is "DBG". The description is "Generic trace messages". 

[][ // Priority traceAdd generic tokens for higher-priority messages (if used, can allow us to turn off all but the highest-priority debug output)]
priority_trace is a trace-token. The trace-tag is "PRI". The description is "High priority trace messages. Always printed unless explicitly turned off".
[ // Generic token for lower-priority messages (so can have this off, while default and priority messages are on ]
verbose_trace is a trace-token. The trace-tag is "INF". The description is "Low-level trace output. Not printed unless explicitly turned on". ]

trace-active-subject is an object that varies. [Will always be either a thing, a room, or nothing]

Section - Phrases to test when tracing is active

To decide whether we're tracing:
	decide on whether or not trace-output-active is true;

To decide whether we're tracing (subject - a thing):
	if we're tracing:
		decide on whether or not the subject is traced;
	decide no. 
	
To decide what number is the number of traceable objects:
	decide on the number of traceable things + the number of traceable rooms.
	
Section - Phrases to print trace output
	
To trace (T - text) as (subject - a thing), inline:
	if we're tracing the subject:
		now trace-active-subject is the subject;
		let spacing be "[line break]";
		if inline:
			now spacing is " ";
		[say "[spacing][trace][T][/trace][spacing]";]
		[say " [trace-prefix][T][trace-suffix][spacing]";]
		say " ", trace-prefix, T, trace-suffix, spacing; [Slightly faster?]
		now trace-active-subject is nothing. 
		
To trace (T - text), inline:
	if inline:
		trace T as default_trace_output, inline;
	otherwise:
		trace T as default_trace_output;

To priority trace (T - text), inline:
	if inline:
		priority trace T as default_trace_output, inline;
	otherwise:
		priority trace T as default_trace_output, inline;

To priority trace (T - text) as (subject - a thing):
	now _priority_trace is true;
	if inline:
		trace T as priority_trace, inline;
	otherwise:
		trace T as priority_trace;
	now _priority_trace is false;

To verbose trace (T - text), inline:
	if inline:
		verbose trace T as default_trace_output, inline;
	otherwise:
		verbose trace T as default_trace_output, inline;

To verbose trace (T - text) as (subject - a thing):
	now _verbose_trace is true;
	if inline:
		trace T as priority_trace, inline;
	otherwise:
		trace T as priority_trace;
	now _verbose_trace is false;
	
Section - Text substitutions
	
trace-prefix is a text that varies. trace-prefix is "//[trace-tag] ".
trace-suffix is a text that varies. trace-suffix is " //". 
_trace_output_level is a text that varies. [Empty (default), "+" for priority, "-" for verbose, prefaces the trace-tag in trace messages]

[To say trace: say trace-prefix.
To say /trace: say trace-suffix.]

To say trace-tag: 
	if trace-active-subject is not nothing:
		let C be the trace-tag of the trace-active-subject;
		if C is not empty:
			say " [_trace_output_level][C]:".


Section - Inline tracing (for use with Nested Text Capture by Taryn Michelle)

[ // Rather than require it's use, allow inline text-substitution form of trace messages only when Nested Text Capture is present ]
_inline_trace_subject is an object that varies.

To say trace -- beginning say_inline_trace -- running on:
	now _inline_trace_subject is default_trace_output;
	begin text capture;

To say trace (subject - a thing) -- beginning say_inline_trace -- running on:
	now _inline_trace_subject is subject;
	begin text capture; 

To say /trace -- ending say_inline_trace -- running on:
	end text capture;
	trace captured text as _inline_trace_subject, inline;
	
			
Section - Trace Commands 

Managing trace output is an action out of world applying to one thing.
Querying trace output is an action out of world applying to one topic.
Managing global trace output is an action out of world applying to one topic.

Understand "trace [something]" as managing trace output.
Understand "trace [any room]" as managing trace output.
Understand "trace [text]" as querying trace output.
Understand "trace" as a mistake("[trace-status]").

To say trace-status:
	show trace command usage.

Carry out querying trace output:
	if "[the topic understood]" is:
		-- "on":
			now trace-output-active is true;
			if the number of traced things is zero and the number of traced rooms is zero:
				enable trace output for default_trace_output;
			report trace status of nothing as true;
		-- "off":
			now trace-output-active is false;
			report trace status of nothing as false;
		-- "all":
			enable all trace output;
			report trace all status as true;
		-- "all on": [duplicate form of 'TRACE ALL']
			enable all trace output;
			report trace all status as true;
		-- "all off":
			disable all trace output;
			report trace all status as false;
		-- otherwise:
			if "[the topic understood]" is not "status":
				say "('[the topic understood]' is not a valid option.)[line break]";
			show trace command usage;

Carry out managing trace output: 
	if the noun is untraceable:
		say "[The noun] doesn't support trace output.";	
		rule fails;
	say "Trace output for [the noun] is currently [if the noun is traced]ON[otherwise]OFF[end if]. Would you like to turn it [if the noun is traced]OFF[otherwise]ON[end if]?";
	if the player consents:
		if the noun is traced:
			disable trace output for the noun;
			report trace status of the noun as false;
		otherwise:
			enable trace output for the noun;
			report trace status of the noun as true;
			
To report trace status of (O - an object) as (active - a truth state):
	if O is nothing or the number of traceable objects <= 1:
		say "Trace output turned [if active is true]ON[otherwise]OFF[end if].";
	otherwise:
		say "Trace output turned [if active is true]ON[otherwise]OFF[end if] for [O]. ([for more trace detail])[line break]".
		
To report trace all status as (active - a truth state):
	if the number of traceable objects <= 1:
		report trace status of nothing as active;
	otherwise:
		say "Trace output turned [if active is true]ON[otherwise]OFF[end if] for all trace categories. ([for more trace detail])[line break]".

To say for more trace detail:
	say "Type 'TRACE' or 'TRACE status' for more detailed information.";
			

To show trace command usage:
	say "Trace output is currently turned [if we're tracing]ON[otherwise]OFF[end if].[line break]";
	if the number of traceable objects > 1:
		say "[line break]Trace output can be managed independently for each of the categories below:[line break]";
		repeat with subject running through traceable things:
			say "[subject] - [if the subject is traced]ON[otherwise]OFF[end if] ([description of subject])[line break]";	
		repeat with subject running through traceable rooms:	
			say "[subject] - [if the subject is traced]ON[otherwise]OFF[end if]";	
		say "[line break]The following commands are available: [line break]";
		say "  'TRACE ON|OFF for <category>' turns trace output on or off for the specified category.";
		say "  'TRACE ALL' turns trace output on for all categories at once.";
		say "  'TRACE ALL OFF' turns trace output off for all categories at once.";
		say "  'TRACE ON' activates trace output for the current set of enabled categories. (If no categories are enabled, the trace-default category will be automatically enabled.)[line break]";
		say "  'TRACE OFF' turns trace output off without changing the set of enabled categories (so that typing 'TRACE ON' will resume trace output for those same categories).";
	otherwise:
		say "The command 'TRACE ON|OFF can be used to turn trace output on or off.";


[Place traceable items in scope for trace output management]			
Before deciding the scope of the player when managing trace output:
	repeat with subject running through traceable things:
		place the subject in scope;
	repeat with subject running through traceable rooms:
		place the subject in scope;
	
Section - Phrases to enable/disable trace output

[Phases to control trace output from within code.]

To enable [default] trace output:
	[if the number of traced things <= 0 and the number of traced rooms <= 0:]
	enable trace output for default_trace_output;
	now trace-output-active is true;

		
To enable trace output for (t - a thing):
	now t is traced;
	now trace-output-active is true;
	
To enable all trace output:
	repeat with subject running through traceable things:
		now the subject is traced;
	repeat with subject running through traceable rooms:
		now the subject is traced;
	now trace-output-active is true;
	
To disable trace output:
	now trace-output-active is false;

To disable trace output for (t - a thing):
	now t is untraced;
	if the number of traced things <= 0 and the number of traced rooms <= 0:
		now trace-output-active is false;

To disable all trace output:
	repeat with subject running through traceable things:
		now the subject is untraced;
	repeat with subject running through traceable rooms:
		now the subject is untraced;
	now trace-output-active is false;

Trace Output ends here.



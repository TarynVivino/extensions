Version 1.1 of Semantic Markup by Taryn Michelle begins here.

"Support for semantic markup"

Markup-mode is a kind of value. The Markup-modes are Markup-None, Markup-Dev and Markup-IF.
The current markup-mode is a markup-mode that varies. The current markup-mode is Markup-IF. 

[ // Here are all of the semantic elements (so far) that we believe we'll need ...]


[ // Story Elements: Title, Subtitle, Chapter Title, Narrative, Dialogue]



[ // Highlights: Location Name, Object Name, Person Name, ...]

[ // TMV - These are easier, as the "Printing the name of something" activity can be used to place the markup]
Semantic style is a kind of value. The semantic styles are story-narrative, story-object, story-location, story-markup,  pc-dialogue, npc-dialogue, stage-directive, player-prompt, player-input, story-alert.

To say story-markup (T - text):
	if the current markup-mode is markup-IF:
		set story-markup style;
		say "<story: [T]>";
		unset style;
		
To say /story-markup (T - text):
	if the current markup-mode is markup-IF:
		set story-markup style;
		say "</story: [T]>";
		unset style;

To say player-prompt:
	say story-markup "prompt";
	set player-prompt style;
To say /player-prompt:
	unset style;
	say /story-markup "prompt";

To say story-object: 
	say story-markup "object";
	set story-object style;
To say /story-object:
	unset style;
	say /story-markup "object";

To say story-location:
	say story-markup "location";
	set story-location style;
To say /story-location:
	unset style;
	say /story-markup "location";
	
To say player-input:
	say story-markup "input";
	set player-prompt style;
To say /player-input:
	unset style;
	say /story-markup "input";
	
To say story-alert:
	say story-markup "alert";
	set story-alert style;
To say /story-alert:
	unset style;
	say /story-markup "alert";
	
First before reading a command: say "[player-input]";
Last after reading a command: say "[/player-input]";	
When play begins: now the command prompt is "[special-style-1]([player command count])>";

The currently-voiced speaker is an object that varies. 	The last-voiced speaker is an object that varies.
To say ' / (char - a person)': 
	if char is the last-voiced speaker:
		say "[-']";
		stop;
	if char is the player:
		set pc-dialogue style;
	otherwise:
		set npc-dialogue style;
	now the currently-voiced speaker is char;
	if the current markup-mode is markup-IF:
		say "<story: dialogue [char]>";
To say /':
	if the currently-voiced speaker is nothing:
		say "[']";
	otherwise:
		if the current markup-mode is markup-IF:
			say "</story: dialogue>";
		unset style;
	now the last-voiced speaker is the currently-voiced speaker;
	now the currently-voiced speaker is nothing.
To say -': [continuation of dialogue by the same speaker]
	if the last-voiced speaker is nothing:
		say "[']";
	otherwise:
		now the currently-voiced speaker is the last-voiced speaker;
		if the currently-voiced speaker is the player:
			set pc-dialogue style;
		otherwise:
			set npc-dialogue style;
		say "<story: dialogue>";

A last every turn rule:
	now the last-voiced speaker is nothing. [clear this so that on subsequent turns, new dialogue opens with a new identification of the speaker, regardless of who last spoke on a prior turn]

The semantic style stack is a list of semantic styles that varies. 

__story_markup_style is a text that varies. __story_markup_style is "[note style]".
__story_narrative_style is a text that varies. __story_narrative_style is "[roman type]".
__story_object_style is a text that varies. __story_object_style is "[fixed letter spacing]".
__story_location_style is a text that varies. __story_location_style is "[fixed letter spacing]".
__pc_dialogue_style is a text that varies. __pc_dialogue_style is "[special-style-1]".
__npc_dialogue_style is a text that varies. __npc_dialogue_style is "[special-style-2]".
__stage_directive_style is a text that varies. __stage_directive_style is "[blockquote style]".
__player_input_style is a text that varies. __player_input_style is "[special-style-1]".
__player_prompt_style is a text that varies. __player_prompt_style is "[special-style-1]".
__story_alert_style is a text that varies. __story_alert_style is "[alert style]".

To set the/-- (ss - semantic style) style, directly:
	[trace "Setting style [ss]", inline;]
	[if not directly:
		trace "Pushing style [ss] onto the stack. There are now [number of entries in the semantic style stack] nested entries.", inline;
		add ss to the semantic style stack; [at the end]]
	if ss is:
		-- story-markup:
			say __story_markup_style; [ // "[note style]";]
		-- story-narrative:
			say __story_narrative_style; [ // "[roman type]"; ]
		-- story-object:
			say __story_object_style; [ //"[fixed letter spacing]"; ]
		-- story-location:
			say __story_location_style; [ "[fixed letter spacing]"; ]
		-- pc-dialogue:
			say __pc_dialogue_style; [ "[special-style-1]"; ]
		-- npc-dialogue:
			say __npc_dialogue_style; [ "[special-style-2]";]
		-- stage-directive:
			say __stage_directive_style; ["[blockquote style]";]
		-- player-input:
			say __player_input_style; ["[special-style-1]";]
		-- player-prompt:
			say __player_prompt_style; ["[special-style-1]";]
		-- story-alert:
			say __story_alert_style; ["[alert style]";]
			
Color-black is always "#000000".
Color-red is always "#FF0000".
Color-green is always "#00FF00".
Color-blue is always "#0000FF".
Color-white is always "#FFFFFF".
Color-gray is always "#888888".
Color-purple is always "#FF00FF".

[ // TODO: two issues:
	(1) use a subdued style for the display of semantic markup tags (yes, this steals a style from our already limited list)
	(2) figure out a way to grab the leading article (when present) as part of the "printing the name of something" activity.
	Possibly the easiest way is to watch the output buffer (using text capture? is there a more efficient way??) and if the captured buffer ends with "the", "a" or "an", set the article in a (new?) activity variable, and delete it from the captured text. Then either reprint it, or if we are doing some other form of manipulation that requires a change, change it.
	(3) No, it's worse than that. The article ("a", "an" or "the") appears to only be decided AFTER the printing the name activity completes. For example, using that activity to insert markup causes "an iron-barred gate", to be printed up instead as "a <tag>iron-barred gate</tag>". UGH!!!! Other things might insert adjectives (like "an open <tag>iron-barred gate</tag>", as for an open door. It may be instructional to have a look at how that's done ... ]


Last before starting the virtual machine (this is the directly set glulx styles rule):
	[ // Using fixed-letter style slot for object names (story-object and story-location)] 
	set fixed width for fixed-letter-spacing-style to false;
	[ // set the font weight for fixed-letter-spacing-style to bold-weight; ]
	set the color for fixed-letter-spacing-style to color-blue;
	[ // Using the note-style slot for markup (and other things we want unobtrusive?)]
	set the color for note-style to color-gray;
	set the font weight for note-style to light-weight;
	set the relative size for note-style to -1;
	[ // Using the blockquote style for stage directions]
	set the justification for blockquote-style to left-right-justified;
	set the indentation for blockquote-style to 15;
	set the color for blockquote-style to color-gray;
	set the relative size for blockquote-style to -1;
	[ // Using special-style-1 for player prompt/input ]
	set the color for special-style-1 to "#BB00BB";
	set the font weight for special-style-1 to light-weight;
	set the relative size for special-style-1 to -1;
	[ // Using alert-style for warnings and other bolded/centered "alerts" (should be rare)]
	set the color for alert-style to color-red; [OR ... "#550099"]
	set the font weight for alert-style to bold-weight;
	[set the justification for alert-style to center-justified;] [This causes issues ... everything remains center-justified once this is invoked even one time]
			
First before printing the name of something (called the subject) (this is the begin markup of object names rule):
	if the print-stage is name-printing:
		if the subject is a room, say "[story-location]";
		otherwise say "[story-object]". 
	
Last after printing the name of something (called the subject) (this is the end markup of object names rule):
	if the print-stage is name-printing:
		if the subject is a room, say "[/story-location]";
		otherwise say "[/story-object]". 
		
First before printing the name of a room (called the place) (this is the begin markup of room names rule):
	if the print-stage is name-printing:
		say "[story-location]";

Last after printing the name of a room (called the place) (this is the end markup of room names rule):
	if the print-stage is name-printing:
		say "[/story-location]";
			
	
To unset style:
	if the semantic style stack is empty:
		set the story-narrative style;
	otherwise:
		let n be the number of entries in the semantic style stack;
		let ss be entry n of the semantic style stack;
		trace  "About to reset style to [ss]", inline;
		set the ss style, directly;
		remove entry n from the semantic style stack;
		set the story-narrative style; [it ain't workin', so just do this for now]
	
To warn that/-- (T - text):
	say "[story-alert]*** WARNING: [T] ***[/story-alert]";
	
[ // Out-of-Story Elements: Staging, Redundancy Avoidance, Errors, Help systems -- different styling for each?]

Semantic Markup ends here.

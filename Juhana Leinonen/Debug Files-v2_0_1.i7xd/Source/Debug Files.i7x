Version 2.0.1 of Debug Files (for Glulx only) by Juhana Leinonen begins here.

"A development tool for saving debugging information to an external text file during beta testing."

The file of debug information is called "debug".

The prompt count is a number that varies. The PSIN is a number that varies. 

Use debug files translates as (- Constant USE_FILE_DEBUGGING; -).
	
When play begins (this is the initialize the Debug Files extension rule):
	if the debug files option is active:
		now PSIN is a random number from 10000 to 99999;
		now the command prompt is "[bracket][the advanced prompt count][close bracket] >";
		append "[paragraph break]---[paragraph break][banner text][paragraph break]" to the file of debug information.
	
After printing the banner text when the debug files option is active (this is the print PSIN after the banner rule):
	say "Play session identifier number: [PSIN][line break]" (A).

To say the advanced prompt count:
	increase the prompt count by 1;
	say prompt count.
	
To debug (txt - indexed text):
	if the debug files option is active:
		append "[bracket][prompt count][close bracket]: [txt][paragraph break]" to the file of debug information.

Debug Files ends here.

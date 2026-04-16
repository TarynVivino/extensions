Version 2.0.241012 of Text Basics by Taryn Michelle begins here.

"A variety of definitions and phrases to help with routine text manipulation and display"

[ // TODO: (low priority) Have a look at indenting, a regx-based approach REALLY ought to work, and more quickly!]
[ // TODO: (mid priority) Look into why built-in "empty" test for strings doesn't always work?! -- See (modified) Unsuccessful PC Attempt code, the issue occurred testing the "described rejection" text property, where neither "empty" nor "not empty" were true
        but maybe easiest is just to use the check <= "" instead?]

Part - Notes on Inform Default Behavior

[Some of Inform's behavior with respect to text can be puzzling. A number of methods developed here (and their implementations) came about because of a need to work around these quirks and/or limitations. 

(1) Working with lines of text. 

Inform has a number of built-in routines to manipulate text that is formatted into lines. This can be handy, particulary when reading/writing files, for example. 

Unfortunately, the method "line number N in TEXT" strips leading and trailing whitespace (and indeed, appears to strip whitespace even beyond the line break at the end of a line of text). This leads to puzzling behavior if you were expecting spacing to be preserved (as might well be the case, for example, if outputting JSON to a file). 

The regular expression format also does not appear to work as expected with newlines. While the expression "<^<^\n>*\n" SHOULD in theory be capable of managing what "line number N in TEXT" does not -- capturing the start of the first line of text up to and including the ending line break, it does not in practice appear to match anything.]

Part - Text Helpers

Section - Substitutions

To say \q: say "'".
To say \': say "[']". 

Section - Forcing Evaluation of Text Substitutions

[Just a convenient shorthand, for a more consistent style of usage]
To decide which text is (T - some text) substituted:
	decide on the substituted form of T.

Section - Escaping text

[Escaping quote marks is necessary for embedding a string within a quoted string, e.g., for JSON files]
To decide which text is (T - some text) escaped:
	replace the text "\" in T with "\\";
	replace the text "[\n]" in T with "\n";
	replace the text "[\q]" in T with "\[\q]";
	decide on T.

Section - Quoting text

[Wrap text in quote marks]	
To decide which text is (T - some text) quoted:
	decide on "[\q]" & T & "[\q]";
	
Section - Repetition
	
To decide which text is (T - some text) repeated (repeats - number) times:
	if repeats < 1:
		decide on "";
	let result be T;
	repeat with N running from 2 to repeats:
		now result is result & T;
	decide on result. 

Section - Tabs & Indenting

tab-stop-size is a number that varies. tab-stop-size is 4;

To say \t: say " " repeated tab-stop-size times. [A "tab" expanded to spaces]
To say \n: say "[line break]";

[Indent EACH LINE of a multi-line text (used in JSON formatting)]	
[*** Note: this would be SO much easier if "line number N in text" returned UNTRIMMED strings. Other methods (e.g., attempts to use regular expression matching) also fail -- possibly the reason line extraction is implemented as it is. In any case, performance of the following on all but fairly small amounts of text becomes prohibitive in terms of performance. We therefore impose a limit (semi-arbitrary) of 1Kb -- on texts larger than that, we DO NOT attempt to indent each line of a multi-line text]
To decide which text is (T - text) indented:
	let result be "";
	[ // Save time on LARGE texts ... just indent first line and move on]
	if number of characters in T is greater than 1024:
		now result is result & " " repeated tab-stop-size times & T; [Several variations on this DO NOT work. Weird.]
		decide on result;
	let lines be number of lines in T;
	let line be "";
	let line be ""; 
	let pos be 1; 
	let c be character number 1 in T;
	while c is not empty:
		now line is line & c; 
		increment pos;
		if c is "[\n]":
			now result is result & "[\t]" & line;
			now line is "";
		now c is character number pos in T;
	if line is not empty:
		now result is result & "[\t]" & line;
	decide on result.

Section - Concatenation

[Surprisingly powerful - allows chaining concatenation. 
If there are any downsides -- as in unwanted side effects with regard to other operations -- I have not found them yet.]
To decide which text is (T1 - text) & (T2 - text):
	decide on "[T1][T2]";

Section - Trimming strings

[Usage:   
	let T be | say "<some text>" trimmed|right-trimmed|left-trimmed [of "<chars>"]
By default whitespace is trimmed (including line and paragraph breaks), but that can be overriden by specificying 
the <chars> to trim as a regular expression.]
	  
To decide which text is (T - text) trimmed: decide on T trimmed using pattern "<\s\n>" with flag "LR".
To decide which text is (T - text) left-trimmed: decide on T trimmed using pattern "<\s\n>" with flag "L".
To decide which text is (T - text) right-trimmed: decide on T trimmed using pattern "<\s\n>" with flag "R".
To decide which text is (T - text) trimmed of (regx - text): decide on T trimmed using pattern regx with flag "LR".
To decide which text is (T - text) left-trimmed of (regx - text): decide on T trimmed using pattern regx with flag "L".
To decide which text is (T - text) right-trimmed of (regx - text): decide on T trimmed using pattern regx with flag "R".

[Remove leading and trailing white space (including line feeds) from text]
To decide which text is (T - text) trimmed using pattern (regx - text) with flag (flag - text):
	let len be the number of characters in T;
	if flag matches the text "L":
		repeat with N running from 1 to len:
			[ // Note we always check character 1 -- the length of the string is changing with each truncation!]
			if character number 1 in T exactly matches the regular expression regx:
				replace character number 1 in T with "";
			otherwise:
				break;
	if flag matches the text "R":
		repeat with N running from 1 to number of characters in T:
			if character number (number of characters in T) in T exactly matches the regular expression "<\s\n>":
				replace character number (number of characters in T) in T with "";
			otherwise:
				break;
	decide on T.
	
Text Basics ends here.

---- DOCUMENTATION ----

A variety of definitions and phrases to help with routine text manipulation and display

Section - Overview

For a language as focused on presenting text as Inform, it's surprising that many standard operations for manipulating text strings one might expect to be built into the language simply aren't. 

This extension collects a variety of useful supporting phrases and definitions. Some are especially useful when dealing with reading and writing files in specific formats, such as JSON (and indeed, the JSON Support extension was the motivating force behind much of the work here). 

Section - Substitutions

First, a few handy text substitutions are defined:
	
	say "[\q]" produces a double quote (''). 
	say "[\']" produces a single quote and perhaps stands out ot the eye slightly better than "[']"
	say "[\n]" is rather handy shorthand for "[line break]"
	
Another substitution supports indentation, though perhaps not quite as expected.

	say "[\t]" does NOT insert an actual tab character. In fact, Inform does not give us any high-level (Inform 7) way to even produce a tab character, nor would it properly display one. 

	Instead the substitution inserts a number of spaces (defined by the global number variable "tab-stop-size"). The default tab-stop-size value is 4. 
	
Section - Concatenation, Repetition and Trimming of Strings

	This extension defines the & symbol for concatenation of strings, such that:
		
		"Some text" & " concatenated with some other text " & "and yet more text" ... 
		
        will return any arbitrary number of strings pasted together, just as expected. 

	Another usful utility (used in the implementation of tab stops, e.g.) is the ability to repeat a character or string. This is accomplished with the utility: 
	
		"Some text" repeated N times
		
	Finally, trimming strings is supported as follows:
		
		"<some text>" trimmed|right-trimmed|left-trimmed - returns the supplied text trimmed of all leading and trailing whitespace, all trailing whitespace, or all leading whitespace, respectively 
		
		"<some text>" trimmed|right-trimmed|left-trimmed of "regxp" - behaves similarly, but trims the supplied string of characters matchng the supplied regular expression instead. 
		
Section - Quoting text, Escaping quoted text

	While it's not difficult to quote text by appending "[\q]" (or "'") to each end, the helper phrase:
		
		"<some text>" quoted
		
        is more direct in expressing the intent (and perhaps slightly less error-prone)

	If outputting double-quoted strings (e.g., to a file, say, to be read by Javascript), double quotes within that string must be escaped with a backslash character. This is the purpose of the helper phrase:
		
		"<some text>" escaped
		
Section - Indenting

	To indent a single line of text, prepending "[\t]" is sufficient. 
	
	When indenting multi-line text, however, the above will only indent the first line. In some cases (e.g., as with certain types of paragraph formatting) this might be the desired result. However, it might be that what we really want is to indent EACH line of the text. The phrase:
		
		"<some possibly multi-line text>" indented
		
	does just that, with a few caveats. (1) If the supplied text is very long (more than 1,024 bytes), then only the first line is indented. This is for performance reasons (see the comments in the extension code for the specifics). (2) This does nothing with regard to Inform's DISPLAY of wrapped text -- in fact, it's not really meant as a display formatter at all, though for reasonably short lines of text, it absolutely can work as such. Rather, it's meant to support formatting of output meant for consumption by other programs (such as writing output to a JSON file). 
	

Example: * Texualize - An exploration of text manipulation

Here we use the selection feature to describe which doors are open out of a group. Different rooms have different numbers of doors that could be open or closed, and we want our description to be as succinct as possible.

	*: "Textualize" by Taryn Michelle
	
	Include Text Basics by Taryn Michelle.
	
	When play begins, say "It's a lovely day for a (test) drive (of the Text Basics extension). Let's head out to ... ".

	The Driving Range is a room. "It's just you, the club in your hands, and the ball on the tee. Let's give this a go, shall we?"

	instead of doing something:
		say "Wow!" & "[\n]" & "It looks like this concatenation thing works," quoted & " said Bob." & "[\n]";
		let reply be "               I know, right?        ";
		say reply & "[\n]" & "This makes me very happy," quoted & " replied Mary." & "[\n]";
		say "You should have quoted and trimmed your reply," quoted & " chided Bob." & "[\n]";
		say "Mary nodded sheepishly. " & "You mean like this:" quoted & "[\n]";
		now reply is reply trimmed quoted & "[\n]" & "This makes me very happy," quoted & " replied Mary.";
		say reply indented & "[\n]" & "Well done," quoted & " exclaimed Bob. " & "And neatly indented to boot!" quoted & "[\n]";

	test me with "look".
        
	
	
		


 

	


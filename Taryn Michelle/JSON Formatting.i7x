Version 9/230407 of JSON Formatting by Taryn Michelle begins here.

"Helper functions to format output for JSON format data exchange"

Section - Dependencies

Include Text Basics by Taryn Michelle. 

Section - Constructing String Elements, Objects and Arrays

to say \json-brace: say "\u007B"; [ to put a curly brace at the start of a JSON-value, so it's not interpreted as an object ]
to say \json-bracket: say "\u005B;" [ to put an opening square bracket at the start of a JSON-value, so it's not interpreted as an array ]

To decide which text is the/-- JSON-element (name - text) -> (value - text):
	let c be character number 1 in (value left-trimmed);
	if (c is "{") or (c is "[bracket]"): [element value is an (already encoded) array or object, don't quote or escape]
		decide on name quoted & " : " & value;
	decide on name quoted & " : " & value escaped quoted;
	
To decide which text is the/-- JSON-object [(name - text) ->] (elements - list of texts):
	if elements is empty:
		decide on "{ }";  [Empty object]
	let T be "{";
	let N be 1;
	repeat with element running through elements:
		now T is T & "[line break]" & element indented;
		if N < the number of entries in elements:
			now T is T & ",";
		increment N;
	Let T be T & "[line break]}";
	decide on T. 
	
To decide which text is the/-- JSON-array [(name - text) ->] (elements - list of texts):
	if elements is empty:
		decide on "[bracket] [close bracket]";  [Empty array - Include it]
	let T be "[bracket]";
	let N be 1;
	repeat with element running through elements:
		now T is T & "[line break]" & element indented;
		if N < the number of entries in elements:
			now T is T & ",";
		increment N;
	Let T be T & "[line break][close bracket]";
	decide on T. 
	
Section - Constructing other types of JSON Elements (non-string values)

[All of the non-string value types are guaranteed to be scalar elements (not objects or arrays)]

To decide which text is the/-- JSON-element (name - text) -> (value - number):
	decide on name quoted & " : " & "[value]".
	
To decide which text is the/-- JSON-element (name - text) -> (value - real number):
	decide on name quoted & " : " & "[value]".
	
To decide which text is the/-- JSON-element (name - text) -> (value - truth state):
	decide on name quoted & " : " & value ? "true" / "false".
	
To decide which text is the/-- JSON-element (name - text) -> null:
	decide on name quoted & " : null".

JSON Formatting ends here.

---- DOCUMENTATION ----

"Helper functions to format output for JSON format data exchange"

Section - Usage

To output data in JSON notation we need to be able to do three things:
	
(1) Format a name/value pair (which we call a JSON 'element')

	* let element be the JSON-element "name" -> "value";
	   say element;
	
	[produces the output:  "name" :  "value"]
	
The quotation marks above are part of the text, of course, and if the value is itself contins any double-quotes, they are properly exscaped, as so:
	
	* let element be the JSON-element "conversation" -> "'I'm not so sure that's a good idea,' said Frankel."
	   say element: 
	
	[produces the output: "conversation" : "\"I'm not so sure that's a good idea,\" said Frankel."]

(2) To combine elements in a JSON object. 

      To accomplish this, we must first create a list of the JSON elements we want inside the object. As the formatted elements are nothing more than texts, we use a list of texts.

	* let L be a list of texts;
	   add JSON-element "name1" -> "value 1" to L;
	   add JSON-element "name2" -> "value 2" to L;
	   let object-element be the JSON-object L;
	   say object-element;
	
	[produces the output: {
	     "name1" : "value 1",
	     "name2" : "value 2"
	}]
	
(3) To construct an array of elements/objects

	Once again, we use a list of texts to collect the elements of the array. 
	
        * let obj be a list of texts:
	   add JSON-element "name1" -> "value 1" to obj;
	   add JSON-element "name2" -> "value 2" to obj;
	   let array be a list of texts:
	   add obj to array;
	   add obj to array;
	   say JSON-array array;
	
	[produces the output: [
			{
				"name1" : "value 1",
				"name2" : "value 2
			},
			{
				"name1" : "value 1",
				"name2" : "value 2
			}
		]
	]
	   

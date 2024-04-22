This is a very simple extension that defines only two conditions: "unicode {X} is supported" and "unicode {X} is supported exactly".  It is employed with code like this:

	When play begins: if unicode 913 is supported, say "Your interpreter supports Greek!"

Because Z-Code interpreters that predate version 1.0 will crash if asked to print or even check the availability of a given Unicode character, this extension will immediately return "not supported" without checking if it detects that the story file is running on an interpreter that predates 1.0.

Also, only Glulx is capable of distinguishing between "supported" and "supported exactly."


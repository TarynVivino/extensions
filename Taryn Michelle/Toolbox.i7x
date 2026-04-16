Version 1.0 of Toolbox by Taryn Michelle begins here.

"Toolbox contains a collection of useful miscellany for my personal projects"

Part - Minimal Framework (for use without Framework by Taryn Michelle)

[Minimal set of includes for every project]
Include Nested Text Capture by Taryn Michelle. 

Section - Inline Text Comments and Blocking (for use without Narrative Support by Taryn Michelle)

[If we use no other bits of Narrative support, this feature is too useful not to have ]

[Supress text output between // and -// markers! This allows us to better block out conditional text, e.g., see the (revised) description text for the Drawbridge in the (new) chapter "Introduction".]
To say // -- beginning say_slash_slash -- running on: begin text capture. 
To say //* -- beginning say_slash_slash -- running on: begin text capture.
To say -// -- ending say_slash_slash -- running on: end text capture.
To say *// -- ending say_slash_slash -- running on: end text capture. 

Part - Tools

Section - Loop over items in scope (for use without Room Description Control by Emily Short)

[Lifted from Room Description Control by Emily Short]



Include (-
  Global processing_rule = 0;

  [ Process_single_item o;
	 FollowRulebook(processing_rule, o, true);
  ];
-) [after "Definitions.i6t"].

[Used to be: "To call (RL - an objects based rule) on everything in scope:",  but 6M62 will only have it this way]
To call (RL - a rule) on everything in scope:
(-
   processing_rule = {RL};
   LoopOverScope(Process_single_item);
-)

The scope processing rules are an object-based rulebook.
A scope processing rule for a thing (called n) (this is the swift rule): now n is marked for listing. 

Toolbox ends here.

---- DOCUMENTATION ----
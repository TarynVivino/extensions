Version 1.0.0 of Narrative Support by Taryn Michelle begins here.

"Tools to help IF authors focus on the narrative"

Section 1 - Dependencies

Include Nested Text Capture by Taryn Michelle.

Section 2 - In-Line Text Comments and Blocking

[Supressing text output between //* and *// markers allows us to embed short inline "comments" within strings, for example, to clarify conditional behavior]
To say //* -- beginning say_slash_slash -- running on: begin text capture.
To say *// -- ending say_slash_slash -- running on: end text capture. 

[An alternate form to accomplish the same thing. This form just "feels" a bit better to me when using it for clarifying large blocks of text (see the documented example), but the forms are, of course, interchangeable]
To say // -- beginning say_slash_slash -- running on: begin text capture. 
To say -// -- ending say_slash_slash -- running on: end text capture.


Section 3 - Second Person forms for Adaptive Text

[An author inclined to write in 2nd person should not be forced to switch to the third person plural when writing text that needs to be adaptive.]

To say You: say "[We]". 
To say you: say "[we]". 
[// The issue with writing in second person is obviously distinguishing between objective and subjective forms of "you" in order to properly adapt the text. We arbitrarily decide on "at you" as an adequate mnemonic for the objective. Note, however, that we need the @ here to be trailing, not leading, else Inform's built-in "case-sensitivity ONLY in the leading letter of 'To Say' phrases" won't distinguish between the two phrases below and we'll only ever invoke the first one.]
To say You@: say "[Us]". 
To say you@: say "[us]".
To say Your: say "[Our]".
To say your: say "[our]".
To say Yours: say "[Ours]".
To say yours: say "[ours]".
To say Yourself: say "[Ourselves]".
To say yourself: say "[ourselves]".

Narrative Support ends here.

---- DOCUMENTATION ----

An assortment of tools to help maintain focus on the story narrative.

Maintaining clarity in the source text for a work of IF can be challenging. Complex structures are often necessary to allow for desired flexibility and responsiveness of the story text. But lengthy text, especially text containing numerous in-line conditional expressions and other substitutions, can work against clarity, making it difficult to come back later on and see the STORY in the story text. 

Chapter 1 - Adding comments in-line with text, and imroved blocking of alternative text

Consider the following snippet, wherein examining a letter multiple times provides a bit of extra color:
	
	The player carries a folded acceptance letter. 
	The description of the letter is "[one of]'The Royal Thaumaturgical Society Academy for the Practical Application of Magics is pleased to inform you ... ' 

A broad smile crosses your face, as it does every time you read that opening sentence. Your mum would have been so proud to know you were accepted into her alma mater. 

Your dad was ecstatic to see the letter as well, but only because letters from the school were enchanted to convey only whatever news the first non-magically inclined relative to read them most wanted to hear. As far as he knows, you are off to Liverpool for an intensive master class covering all the nuances of the plumbing trade. On scholarship, no less, so at no cost to him. He'll be expecting you to return at years-end to ply your newfound expertise working under his grubby thumb, for half the wages he'd pay any other apprentice, at that. 

Fat chance of that now. You've far better prospects ahead.[or]The most pertinent details were: (1) first of all, that you'd been accepted for study at the Academy, obviously; (2) where and when to arrive for your mandatory, pre-term orientation (3) how to catch the shuttle bus from the train station back in town.[if Arrival is happening]

The letter also advised checking in promptly at the registrar's office upon arrival. Best to get a move on.[end if][or]You've read the letter through enough times to have it memorized by now. You've been accepted into the academy, and now, here you are! [if Arrival is happening]Best to stop dawdling and get yourself checked in.[end if][stopping]". 

There are other ways to implement this sort of thing -- tables, for example -- but they, too tend to suffer from blocking issues that diminish readability. 

In-line comments allow us to write the same instruction as above as follows:

	The description of the letter is "[one of][//]
[-//]'The Royal Thaumaturgical Society Academy for the Practical Application of Magics is pleased to inform you ... ' 

A broad smile crosses your face, as it does every time you read that opening sentence. Your mum would have been so proud to know you were accepted into her alma mater. 

Your dad was ecstatic to see the letter as well, but only because letters from the school were enchanted to convey only whatever news the first non-magically inclined relative to read them most wanted to hear. As far as he knows, you are off to Liverpool for an intensive master class covering all the nuances of the plumbing trade. On scholarship, no less, so at no cost to him. He'll be expecting you to return at years-end to ply your newfound expertise working under his grubby thumb, for half the wages he'd pay any other apprentice, at that. 

Fat chance of that now. You've far better prospects ahead.[//]
		----------------------------------------
[-//][or]The most pertinent details were: (1) first of all, that you'd been accepted for study at the Academy, obviously; (2) where and when to arrive for your mandatory, pre-term orientation (3) how to catch the shuttle bus [//]aka the scary death shuttle[-//]from the train station back in town.[if Arrival is happening][//*]when the player examines the letter during the opening scene prior to entering the office[*//]

The letter also advised checking in promptly at the registrar's office upon arrival. Best to get a move on.[end if][or][//]
		----------------------------------------
[-//]You've read the letter through enough times to have it memorized by now. You've been accepted into the academy, and now, here you are! [if Arrival is happening]Best to stop dawdling and get yourself checked in.[end if][stopping]". 
	
Both versions will produce exactly the same output, but in the second, it's far easier to see at a glance exactly what is meant to be written out at each stage. Note also the addition of a clarifying comment regarding the conditional text related to the Arrival scene.  
	

Chapter 2 - Writing Adaptive Text in the Second Person 

Tbd

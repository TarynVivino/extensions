Version 0.1 of Staging by Taryn Michelle begins here.

"A new approach to Visual and Audio effects in Interactive Fiction"

Chapter 0 - Simulated Stage Directives

Include Glulx Text Effects by Emily Short.

[For now, we show directives in-line with story text. If the results are sane, translating these into directives our (newly designed) front end can use to implement the desired effects is within reach.]

directives-active is a number that varies.

To begin staging:
	if directives-active is 0:
		say "[blockquote style]";
		say "[line break] ----------------- STAGE DIRECTIONS ---------------";
		now directives-active is 1.
		
To end staging:
	if directives-active > 0:
		say "[line break] --------------- END STAGE DIRECTIONS -------------[paragraph break]";
		now directives-active is 0;
		say "[roman type]";

To say music: begin staging; say "[line break]** MUSIC: [run paragraph on]". 
To say sound: begin staging; say "[line break]** SOUND: [run paragraph on]". 
To say effect: begin staging; say "[line break]** EFFECT: [run paragraph on]". 
To say background: begin staging; say "[line break]** BACKGROUND: [run paragraph on]". 
To say image: begin staging; say "[line break]** IMAGE: [run paragraph on]". 
To say /music: end staging. 
To say /sound: end staging. 
To say /effect: end staging. 
To say staging: begin staging. 
To say /staging: end staging. 

Staging ends here.

---- DOCUMENTATION ----

Staging brings an entirely new approach to incorporating Visual and Audio effects in Interactive Fiction.  The core of the concept revolves around completely separating the UI (front end) from the story engine (Inform -- or perhaps other -- back end). A Staging-enabled front end UI will essentially free authors from sweating the many pesky and often complex details currently entailed in trying to incorporate even the most rudimentary of such effects into any of the existing interpreters -- while simultaneously affording much greater flexibility and power. 
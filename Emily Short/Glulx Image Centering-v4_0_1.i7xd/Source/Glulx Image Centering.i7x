Version 4.0.1 of Glulx Image Centering (for Glulx only) by Emily Short begins here.

"Glulx Image Centering adds the ability to display an image that is centered (left/right) on the screen."

Include Glulx Text Effects by Emily Short.

Table of User Styles (continued)
style name	background color	color	first line indentation	fixed width	font weight	indentation	italic	justification	relative size	reversed
special-style-1	--	--	--	--	--	--	--	center-justified	--	--


To display (chosen figure - a figure-name) centered:
	say first custom style; say " ";
	display chosen figure inline;
	say " [line break]"; 
	say roman type; 
	
To display (chosen figure - a figure-name) inline:
	(- DrawInline({chosen figure}); -)

Include (-

[ DrawInline N;
	glk_image_draw(gg_mainwin, ResourceIDsOfFigures-->N,  imagealign_InlineUp, 0);
]; 

-)

Glulx Image Centering ends here.

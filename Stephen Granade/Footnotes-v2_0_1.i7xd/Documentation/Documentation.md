This extension lets you add footnotes to your game, similar to those in the Infocom game Hitchhiker's Guide to the Galaxy. Footnotes are numbered beginning with 1, and are only assigned numbers as they are referenced.

Footnotes are stored in the Table of Footnotes. This extension defines the table; you merely need to continue it:

	Table of Footnotes (continued)
	Name	Note
	hdtv-footnote	"The TV is actually HDTV-ready, not fully HDTV capable."

"Name" is the name of the footnote, while "Note" is the text of the footnote.

This extension adds the to say phrase

	note NAME

to give a footnote number. Here NAME is the name of the footnote as given in the Table of Footnotes.

Footnotes can be given only once or given repeatedly. By default, the footnotes are given only until that note has been read.

	>x laser
	It utilizes a flowing gas approach rather than a closed tube and is specially designed to be extremely stable(1).
	
	>note 1
	K. M. O'Hara, S. R. Granade, M. E. Gehm, T. A. Savard, S. Bali, C. Freed, and J.E. Thomas, Ultrastable CO2 laser trapping of lithium fermions, Phys. Rev. Lett., vol. 82 (1999), pp. 4204.
	
	>x laser
	It utilizes a flowing gas approach rather than a closed tube and is specially designed to be extremely stable.

(Note that footnote numbers are printed inside square brackets rather than parentheses. They are given as parentheses here due to a limitation of extension documentation.) To change this behavior so that footnotes are given over and over, add the line

	Footnotes are given repeatedly.

to your game. Also by default, the game begins with footnotes turned off. To have them displayed from the beginning of the game, add the line

	Footnotes are on.

to your game.

This extension adds four player commands. FOOTNOTES ON or NOTES ON turns on the display of footnotes, while FOOTNOTES OFF or NOTES OFF turns them off again. FOOTNOTE # or NOTE # reads a numbered footnote, while FOOTNOTES or NOTES reports whether or not footnotes are being displayed.


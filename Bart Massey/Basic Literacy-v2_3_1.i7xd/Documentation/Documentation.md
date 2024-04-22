This module extends Inform 7 by providing some basic actions and types that allow the player to read, write and erase text. This is implemented by giving every thing an indexed text called the "read text". With this module loaded, the "read" command no longer invokes the "examining" action. Instead, "read [thing]" shows the read text of the thing read.
Allowing the player to write arbitrary text on things is also allowed. The thing to be written on must have the "writable" property, and the player must have access to a "writing tool". Subsequent writes will append new paragraphs to the read text of the thing written.
Allowing the player to erase the text on things is also allowed. The thing to be erased on must have the "erasable" property, and the player must have access to an "erasing tool". A writable thing is also erasable unless stated otherwise.
Writable-Erasable things: A notebook, a whiteboard, a graffiti
Writable-only things: An engraving, a legal document.


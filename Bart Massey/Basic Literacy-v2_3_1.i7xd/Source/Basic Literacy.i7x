Version 2.3.1 of Basic Literacy by Bart Massey begins here.

"Provides objects and actions for (proper) reading, writing and erasing."

[ Copyright © 2012 Bart Massey]
[ Released under the Creative Commons Attribution 3.0 United States license: http://creativecommons.org/licenses/by/3.0/us/ ]
[ updated version number to a legitimate one -- Zed Lopez ]

Chapter - Reading

[Bart: IMHO this should eventually rolled into the Standard Rules in some form. Having "read" be a synonym for "examine" is bizarre.]
A thing can be readable. A thing is rarely readable.
Reading is an action applying to one visible thing and requiring light.
Every thing has an indexed text called the read text. The read text is usually "".
Understand "read [thing]" as reading.

To say error (the thing read - a thing) has no read text (this is the say error no read text rule): say "[The thing read] has no text written on it."
Check an actor reading a thing (called the thing read) (this is the check reading a thing rule): if the read text of the thing read is empty, instead say "[error the thing read has no read text]" (A).
To say the read text of (the thing read - a thing) (this is the say the read text rule): Say "[command clarification break][read text of the thing read][paragraph break][command clarification break]".

Carry out an actor reading a thing (called the thing read) (this is the read rule): say "[the read text of the thing read]" (A).

Chapter - Writing

A thing can be writable. A thing is rarely writable.
A writing tool is a kind of thing.

To say error too many writables (this is say error several things to write on rule): say "There are several things to write on."
To say error no writables (this is the say error nothing to write on rule): say "There is nothing to write on."

Writing it on is an action applying to one topic and one touchable thing and requiring light. Understand "write [text]" or "write [text] on [thing]" as writing it on. Understand "write on [thing]" or "write [thing]" or "write" as a mistake ("You must specify what text you want to write.")

Rule for supplying a missing second noun when writing (this is the supply a writable thing rule): let N be the number of touchable writable things; if N is greater than one, instead say error too many writables; if N is zero, instead say error no writables; now the second noun is a random touchable writable thing.

To say error (T - a thing) is not for writing on (this is say error not for writing on rule): say "[The T] is not for writing on."
To say implicitly taking (T - a thing) (this is the say implicitly taking a thing for basic literacy rule): say "(taking [the T])[command clarification break]".
To say error missing writing tool: say "You need something to write with."

Before writing when the player does not carry a writing tool and a writing tool is touchable (this is the obtain a writing tool rule): let M be a random touchable writing tool; say implicitly taking M; silently try taking M.

Check an actor writing (this is the check writing rule): unless the second noun is writable, instead say "[error the second noun is not for writing on]"; unless the player carries a writing tool, instead say "[error missing writing tool]".

The text written is an indexed text which varies.

Carry out an actor writing (this is the carry out writing rule): let T be an indexed text; let T be the topic understood; now the text written is T; if the read text of the second noun is "",  now the read text of the second noun is T; otherwise now the read text of the second noun is "[read text of the second noun][paragraph break][T]".

Report writing (this is the report writing rule): say  "You write on [the second noun]."


Chapter - Erasing

A thing can be erasable. An erasing tool is a kind of thing. 
To say error too many erasables (this is the say error several erasables rule): say "There are several things to erase."
To say error no erasables (this is the say error no erasables rule): say "There is nothing to erase."
Erasing is an action applying to one touchable thing and requiring light. Understand "erase" or "erase [thing]" as erasing.

Rule for supplying a missing noun when erasing (this is the choose an erasable rule): let N be the number of touchable writable things; if N is greater than one, instead say error too many erasables; if N is zero, instead say error no erasables; now the noun is a random touchable writable thing.

To say error (T - a thing) need not be erased (this is the say error no writing rule): say "There is no writing on [the T] to erase."
To say error (T - a thing) cannot be erased (this is the say error not erasable rule): say "[The T] is not erasable."
To say error no erasing tool (this is the say error no erasing tool rule): say "You need something to erase with."
To say error failed to obtain an erasing tool (this is the say error failed to obtain an erasing tool rule): say "You fail to find anything usable to erase with."

Before erasing when the player does not carry an erasing tool and an erasing tool is touchable (this is the obtain an erasing tool rule):
	repeat with E running through touchable erasing tools:
		say implicitly taking E;
		silently try taking E;
		if rule succeeded:
			continue the action;
	say error failed to obtain an erasing tool;
	rule fails.

Check an actor erasing (this is the check erasing rule): unless the noun is erasable, instead say "[error the noun cannot be erased]" (A); unless the read text of the noun is not empty, instead say "[error the noun need not be erased]" (B); unless the player carries an erasing tool, instead say "[error no erasing tool]" (C).

Carry out an actor erasing (this is the carry out erasing rule): now the read text of the noun is "" (A).
Report erasing (this is the report erasing rule): say "You erase [the noun]."

Basic Literacy ends here.

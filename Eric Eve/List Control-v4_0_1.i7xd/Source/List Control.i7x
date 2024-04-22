Version 4.0.1 of List Control by Eric Eve begins here.

"Provides a means of using tables as shuffled, cyclic or stop lists."

A table-type is a kind of value. The table-types are stop-list, cyclic-list, and shuffled-list


Table of Table Types
tabname (a table-name)		index (a number)	tabtype (a table-type)
with 1 blank row
	

To decide which number is the relevant row of (tab - a table-name):
  choose row with a tabname of tab in the Table of Table Types;
  let idx be the index entry;
  let ttype be the tabtype entry;
  increase idx by 1;
  if idx > the number of rows in tab begin;
    if ttype is shuffled-list, sort tab in random order;
    if ttype is stop-list, now idx is the number of rows in tab;
    otherwise now idx is 1;
  end if;
  now the index entry is idx;
  decide on idx.

To show the next response from  (tab - a table-name):
  let r be the relevant row of tab;
  choose row r in tab;
  say "[response entry][paragraph break]"

[The following is needed to allow a game including this file to compile even without any defining any tables containing a response column]

Table of Dummy
response
"dummy"


List Control ends here.

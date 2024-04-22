Version 4.0.1 of List Controller by Eric Eve begins here.

"Provides a means of using tables as shuffled, cyclic or stoping lists. This is an alternative to List Control that uses list controller objects instead of a Table of Table Types."

A list controller is a kind of thing.
A list controller can be stopping, cyclic, or shuffled.
A list controller has a number called cur_state.
A list controller has a table-name called associated list.

To show the next response of/in/from (lc - a list controller), with newlines, with paragraph break or with run on:
  let cur be the next row to use in lc; 
  choose row cur in the associated list of lc;
  if there is an event entry, follow the event entry;
  if there is an response entry, say "[response entry][if with newlines][line break][end if][if with run on][run paragraph on][end if][if with paragraph break][paragraph break][end if]".


To decide which number is the next row to use in/of/from (lc - a list controller):
  let cur be the cur_state of lc plus 1;
   let tab be the associated list of lc;
   let len be the number of rows in tab;
   if cur > len begin;
      if lc is shuffled, sort tab in random order;
      if lc is shuffled or lc is cyclic, now cur is 1;
      otherwise now cur is len;
  end if;
  now the cur_state of lc is cur;
  decide on cur.



[The following is needed to allow a game including this file to compile even without any defining any tables containing an response or event column]

Table of DummyXYZ
response		event (a rule)
"dummy"	       --


List Controller ends here.

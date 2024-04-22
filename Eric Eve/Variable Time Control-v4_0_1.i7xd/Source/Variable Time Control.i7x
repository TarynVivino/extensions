Version 4.0.1 of Variable Time Control by Eric Eve begins here.

"Allows individual actions to take a different number of seconds, or no time at all. Also allows the standard time taken per turn to be defined as so many seconds, which can be varied during the course of play".

Part 1 - Time Control Mechanism

Chapter - Time Control Variables

time-reset is a truth state that varies. time-reset is false.
seconds_used is a truth state that varies.
seconds_used is false.
previous_seconds is a number that varies. previous_seconds is 0.
seconds_per_turn is a number that varies. 
seconds_per_turn is 60.
seconds is a number that varies. seconds is 0.


Chapter 2 - The Variable Advance Time Rule

This is the variable advance time rule:
    if time-reset is true begin;
      now time-reset is false;
      stop;
   end if;
   if seconds_used is false, 
       now seconds is previous_seconds + seconds_per_turn;
   let mins be seconds / 60;
   now seconds is remainder after dividing seconds by 60;
   now the time of day is mins minutes after the time of day;
   increase turn count by 1;
   now seconds_used is false;
   now previous_seconds is seconds.


The variable advance time rule is listed instead of the advance time rule in the turn sequence rules.


Chapter 3 - Time Control Phrases

[ Take no time consumes neither time nor turns ]

To take no time:  
   now time-reset is true;
   now seconds is previous_seconds;
   now seconds_used is false.


To say take/-- no-time: take no time.
To say take/-- no time: take no time.

To take (n - a number) sec/secs/second/seconds:
   increase seconds by n;
   now time-reset is false;
   now seconds_used is true.

To say take/-- (n - a number) sec/secs/second/seconds: take n secs.

To take (n - a number) sec/secs/second/seconds in/-- all/total/only:
  now seconds is previous_seconds + n;
  now time-reset is false;
  now seconds_used is true.

To say take/-- (n - a number) sec/secs/second/seconds in/-- all/total/only: take n secs in all. 


Chapter 4 - Displaying Time with Seconds

[ This can be used to display the time of day in the format hh:mm:ss am/pm ]

To say sec-time:  
  let sec_tim be "[time of day]";
  let x be word number 2 in sec_tim;
  if seconds > 9, let x be "[x]:[seconds]";
  otherwise let x be "[x]:0[seconds]";
  replace word number 2 in sec_tim with x;
  say "[sec_tim]";


Variable Time Control ends here.

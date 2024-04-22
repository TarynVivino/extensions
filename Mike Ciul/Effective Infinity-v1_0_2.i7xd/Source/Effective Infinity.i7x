Version 1.0.2 of Effective Infinity by Mike Ciul begins here.

"Provides a system of counting numbers which never go below 0 or above a specified maximum value. Any numbers above the maximum are considered infinite."

Book - Quantities

Chapter - Effective Infinity

[todo: allow quantities to be represented as numerals or spelled out, using use options]

Use maximum counting number of at least 4 translates as the configuration value MAX_FINITE_INT.

[To decide which number is maximum counting number: (- (MAX_FINITE_INT_CFGV) -).]

To decide which number is effective infinity: decide on numerical value of maximum counting number option plus one.

Definition: a number is effectively infinite rather than effectively finite if it is greater than numerical value of maximum counting number option.

Chapter - Keeping Numbers Within Bounds

To decide what number is the counting number after (N - a number):
	decide on N increased by 1 within counting range;

To decide what number is the counting number before (N - a number):
	decide on N decreased by 1 within counting range;

To decide what number is (N - a number) decreased by (M - a number) within counting range:
	decide on N increased by (M * -1) within counting range;

To decide what number is (N - a number) increased by (M - a number) within counting range:
	if N is effectively infinite, decide on effective infinity;
	Let the result be N + M;
	if the result is effectively infinite, decide on numerical value of maximum counting number option;
	if the result is less than zero, decide on zero;
	decide on the result;

Chapter - Printing an Approximate Number

Printing an approximate number of something is an activity on numbers.

To say (N - a number) as an approximate number:
	if N is zero, say "no";
	otherwise carry out the printing an approximate number activity with N.

For printing an approximate number for a number (called N):
	[watch out for the 0 bug: if this activity is called with 0, N could have any value at all!]
	if N is effectively infinite:
		say "a great many";
	otherwise if N is zero:
		say "no";
	otherwise if N is one:
		say "a";
	otherwise if N is two:
		say "a couple";
	otherwise if N is three:
		say "a few";
	otherwise:
		say "several";

Effective Infinity ends here.

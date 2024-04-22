Effective Infinity allows us to assign a particular integer to represent an infinite number of things. The greatest number that we can then represent will be one less than "effective infinity," and there is an option to set this number:

	Use maximum multiplicity of at least 100.

In this case "effective infinity" will be represented by the number 101.

	Use maximum multiplicity of at least 100.

	Change the number of gravel in the Quarry to maximum multiplicity.

	Add some gravel to the Quarry.

The Quarry will still have 100 pieces of gravel. But we can always do this:

	Fill the Quarry with gravel.

And now we'll have an unlimited supply.

Note for old-schoolers: Though it may be tempting to set maximum multiplicity to 69,105, that number is outside the range of numbers in the Z-machine, and it will wrap around to 3569.

Section: Printing an Approximate Number for a Number

The printing an approximate number activity is an activity on numbers. This is the one we might want to override if we'd prefer our numbers written a different way:

	rule for printing an approximate number for (N - a number):
		say "[N in words]";

	rule for printing an approximate number for (N - a number) when the writing style is totally wild:
		if N is 0:
			say "zilch";
		if N is 1:
			say "an all-a-lonely";
		if N is 2:
			say "a coupla";
		if N is at least 3 and N is less than 10:
			say "not a whole lotta";
		otherwise:
			say "a really freakin whole big bunch of"

The "N as an approximate number" phrase uses the "printing an approximate number" activity:

	say "[3 as an approximate number]"

would output:
	
	a few

Chapter: Change Log

1.0.1 updated for 10.2 -- ZL


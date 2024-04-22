Version 2.2.1 of Randomness by Mikael Segercrantz begins here.

"Random number generation using a simple seedable pseudorandom number generator."

Section 1 - The pseudorandom number generator kind

A pseudorandom number generator is a kind.
A pseudorandom number generator has a number called previous value.
A pseudorandom number generator has a number called multiplier.
A pseudorandom number generator has a number called adder.


Section 2 - Seeding the generator

To seed the random number generator (prng - a pseudorandom number generator) with (n - a number):
	now the previous value of prng is n.

To set the multiplier of (prng - a pseudorandom number generator) to (n - a number):
	now the multiplier of prng is n.

To set the adder of (prng - a pseudorandom number generator) to (n - a number):
	now the adder of prng is n.


Section 3 - Initialize the generators

To initialize the random number generators:
	let seed be 1234;
	repeat with prng running through pseudorandom number generators:
		now the multiplier of prng is 13;
		now the adder of prng is 4399;
		seed the random number generator prng with seed;
		now the seed is seed + 1234.

When play begins:
	initialize the random number generators.


Section 4 - Getting a random number

To decide what number is the next random number of (prng - a pseudorandom number generator):
	let current value be the previous value of prng;
	let current value be current value * multiplier of prng;
	let current value be current value + adder of prng;
	now the previous value of prng is the current value;
	decide on current value.

To decide what number is the previous random number of (prng - a pseudorandom number generator):
	decide on previous value of prng.

To decide what number is the next random number:
	decide on the next random number of the main pseudorandom number generator.

To decide what number is the previous random number:
	decide on the previous random number of the main pseudorandom number generator.


Section 5 - The main pseudorandom number generator

The main pseudorandom number generator is a pseudorandom number generator.


Randomness ends here.

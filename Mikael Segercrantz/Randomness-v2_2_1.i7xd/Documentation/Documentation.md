Section: Information on the Pseudorandom number generator

The Randomness extension creates a pseudorandom number generator kind, which has a few properties in it:

	the previous value - the latest calculated random number
	the multiplier - the multiplier used to create random numbers
	the adder - the adder used to create random numbers

The pseudorandom number generator of the Randomness extension is of the most basic kind, utilizing the formula SEED = (SEED * MULT) + ADD to generate random numbers.

Section: The main pseudorandom number generator

This extension automatically creates one pseudorandom number generator called the main pseudorandom number generator. If your project requires multiple generators, you are free to create more of them, e.g. with

	The skeleton in the closet pseudorandom number generator is a pseudorandom number generator.

Section: Seeding the PRNG

To seed the pseudorandom number generator created by the Randomness extension, you can use the following phrases:

	seed the random number generator (name of generator) with (the seed value).
	set the multiplier of (name of generator) to (the multiplier value).
	set the adder of (name of generator) to (the adder value).

It is highly recommended that the multiplier be a prime number; the same can be said of the adder, although the extension does not require this.

Section: Reading values from the PRNG

You can read any pseudorandom number generator using the following syntax:

	the next random number of (name of generator)

However, accessing the main pseudorandom number generator is somewhat easier:

	the next random number

is enough to access it.

If you wish to read the last random number generated, you can use

	the previous random number of (name of generator)

and

	the previous random number

to access them.


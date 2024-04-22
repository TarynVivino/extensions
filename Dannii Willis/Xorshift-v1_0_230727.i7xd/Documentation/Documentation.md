Inform allows you to seed the random number generator so that if you use the same seed the same sequence of 'random' numbers will be generated. Unfortunately it isn't consistent when you change interpreters or computers. This extension replaces Inform's built in random number generator with another one called xorshift, which is consistent across all interpreters and computers. (Though not if you switch from the Z-Machine to Glulx or vice versa.) Unlike the other extensions for randomness, this extension will affect every part of Inform that has random behaviour.

The xorshift generator is controlled by the "xorshift seed" variable. To turn it on, set the variable to any number other than 0. To turn it off, set it to 0. If you like, you can use the "seed the xorshift generator randomly" phrase, which sets the seed using a random number from the built in generator. The seed variable is continually updated as random numbers are generated, so if you want to reuse a seed, you should store it in another variable. Once you have set the seed variable no other code changes are needed.

	After starting the virtual machine:
		[ set the seed to a specific number ]
		now the xorshift seed is 1000;
		[ set the seed to a random number ]
		seed the xorshift generator randomly;
		say the xorshift seed;
		[ turn off the xorshift generator ]
		now the xorshift seed is 0;

All psuedo random number generators have flaws, but considering its speed, the xorshift algorithm is one of the most reliable generators known. It is slower than the VM's built in random function, but it's unlikely to ever be noticably slower. For more information about xorshift generators see <http://en.wikipedia.org/wiki/Xorshift>.

The latest version of this extension can be found at <https://github.com/i7/extensions>. This extension is released under the Creative Commons Attribution licence. Bug reports, feature requests or questions should be made at <https://github.com/i7/extensions/issues>.


This extension tries to fix spelling errors in misunderstood input by looking for words in the "printed name" of nearby objects that start with the first three letters of the first misunderstood word in the player's input. While a simple approach, this still catches about 40% of IF typos, including common cases where the player uses an abbreviated form or a unimplemented plural or singular form of a noun.

The extension requires version 12 or higher of Smarter Parser by Aaron Reed, which includes much more functionality for recognizing misunderstood input. If you want to disable this and use mistype correction alone, simply add the following line to your source:

	Use empty Smarter Parser rulebook.


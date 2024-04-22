
Section: Introduction

Benchmarking Core provides a general purpose benchmarking test framework which produces statistically significant results. Benchmarking refers to carefully timing how long some task takes to run. This extension has two types of users in mind:

1. Story and extension authors can use Benchmarking to compare alternatives for some slow programming task. The examples below shows how you might use Benchmarking to compare alternative ways to test for a container's emptiness.

2. Interpreter authors can use Benchmarking to compare their interpreter with others, as well as to compare interpreter updates to see whether they have a performance benefit or deficit.

The most accurate results will be obtained with a release build, as Inform's debug code will slow down some algorithms considerably, so be aware that simply using the Go! button will give different results than a release build would. (And if you want to run the tests with Inform's built-in interpreter on Windows you will need to install the 2012 6G60 re-release, as the original 6G60 release did not have all the necessarily functionality.)

Benchmarking is based on the Javascript library Benchmark.js. http://benchmarkjs.com

Benchmarking depends on Real-Time Delays by Erik Temple

The latest version of this extension can be found at <https://github.com/i7/extensions>. This extension is released under the Creative Commons Attribution licence. Bug reports, feature requests or questions should be made at <https://github.com/i7/extensions/issues>.

Section: Writing test cases

A test case should be added for each task or algorithm you wish to test. Each test case must be provided with a run phrase, which is what will be benchmarked. Unfortunately the Inform 7 syntax for attaching the run phrase is a little clunky. You must first give the phrase a name, and then attach it to the test case.

	My test case is a test case.
	To run my test case (this is running my test case):
		...
	The run phrase of my test case is running my test case.

If you are comparing algorithms for the same task it is important that they all do actually do the same thing. This extension does not and cannot compare whether test case algorithms are equivalent, so you should first test your algorithms thoroughly. If you are not comparing equivalent algorithms, use this option to prevent the final test comparisons:

	Use nonequivalent tests.

It is also important that test cases run the same each time through, so if your test case changes the world state in some way you must reset what it changes as part of your run phrase.

Test cases are a kind of thing, so like all things they can have descriptions. They can also be given an author, as shown in the example.

Some test cases might require recent or optional interpreter features. If so then you can add an initialisation rule, in which you can check if that interpreter feature is supported, and disable the test case if not.

	To decide whether unicode is supported: (- (unicode_gestalt_ok) -).
	Rule for initialising my test case:
		unless unicode is supported:
			now my test case is deactivated.

Benchmarking is currently only designed for testing Glulx functionality, and it may not work well for testing Glk functionality. If you have potential Glk test cases please contact the author.

Section: Change log

2.2: updated for 10.2 -- ZL

Version 2/210914:
	Updated for 6M62 by Zed Lopez:
	- ripped out the homebrew real number implementation, replacing with I7 native reals
	- updated appropriately for Flexible Windows 10.
	- the previous example no longer compiles; replaced it with When One Stares into the Void

Version 1/120610:
	Added a version action
	Added a nonequivalent tests use option
	The final results are now scaled

Version 1/120218:
	Initial (non-beta) release

Section: Example


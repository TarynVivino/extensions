Chapter Introduction

This is a unit test extension. There are many like it, but this one is mine.

Note: because this extension declares a unit test variable, if you include Unit
Tests, your code *must* create at least one unit test, or it will fail to compile.

The entire extension is marked "not for release".

Chapter Use case

To test your game as a whole, I recommend using Andrew Plotkin's [RegTest](https://eblong.com/zarf/plotex/regtest.html).
The latest is available in [the plotex Github repo](https://github.com/erkyrath/plotex/blob/master/regtest.html).

But if you're testing code in isolation that isn't about accepting player commands
or producing player-visible output, RegTest isn't the most natural fit. This
extension was written for those cases.

Chapter Unit Test kind

A unit test is a kind of object, with a text description property, which should
be populated for the test to identify itself. (It *can* be left blank, in which
case the test falls back on the object name itself.) Because the property is
"description" it can be specified with just a stand-alone string immediately
following the object definition.

	Math-still-works is a unit test. "Whether math still works".

``Testing`` is an activity on unit tests. For the test to do anything useful,
you must define a corresponding ``For testing`` rule:

	For testing math-still-works:
		for "Add 2 + 2" assert 2 + 2 is 4;

(More about assert statements later.)

If you have setup to do, a ``Before testing`` rule is a good place for it. But you may
need to establish global variables or activity variables for the ``For testing`` and/or
``After testing`` rules to have access to information set up in the Before rule.

If there's more reporting you want, you might use an ``After testing`` rule. But you shouldn't
need to do any teardown: unit tests are idempotent. They save the game state before they
start, and restore when they're finished. (On glulx one can protect memory from being
clobbered by a restore, so make that *mostly* idempotent, but it should be fairly difficult
for one test to screw up the environment for another.)

This means that you also can't share context between different tests... but you can make the
same Before rule apply to more than one test. (You could have multiple ``for testing`` rules
for the same unit test, using ``continue the activity``, but assertions/refutations spread
among multiple rules in that fashion would be equivalent to them all being in the same rule.)

	Before testing a unit test (called ut) when ut is test1 or ut is test2:

And don't have one test invoke another: the save-state in the inner test's Before testing
rule would clobber the outer test's state, so when the outer test restored state, it would
restore state as of the beginning of the inner test, not the outer test.

Chapter Assertions and Refutations

assert/refute statements are the heart of testing. This documentation will refer to assertions
and refutations collectively as "test statements".

It technically doesn't matter where they occur in the activity, but the intent is that they be
used in For Testing rules. There are several varieties:

Equality with ``is`` or ``==``

	for <label> assert <value> is <value>;
	for <label> refute <value> is <value>;

The values must be of compatible kinds. For texts, == is a special case that means the same as
``exactly matches the text``; ``is`` is the same as in conventional I7. See Text Comparisons
below.

Less than or greater than:

	for <label> assert <value> < <value>;
	for <label> refute <value> < <value>;
	for <label> assert <value> > <value>;
	for <label> refute <value> > <value>;

Any arbitrary condition:

	for <label> assert <condition>
	for <label> refute <condition>

And, if you've included If True by Zed Lopez, a plain truth state value.

	for <label> assert <truth state value>
	for <label> refute <truth state value>

Operators for !=, <=, => aren't provided; just refute ==, >, <, respectively.

If you create a unit test object, you should write a corresponding For testing activity rule
which should include at least one test statement. This isn't enforced: if you don't
have any test statements, the test will run and report 0/0 Passed.

Chapter Instantly passing or failing

You can say either of:

	for <label> pass;
	for <label> fail;

As to why you'd want to, say you had a test whose setup relied upon a phrase invocation that
could return an invalid value, or a case where you wanted the output to include something extra
or both. You might do something like:

	For testing dark-rooms:
		let r be a random dark room;
		let label be "dark room has a container";
		if r is nowhere, for "[label] (got nowhere)" fail;
		for label assert r encloses a container.

Chapter Testing printed output, including errors

If you want to test phrases' output, use the ``test`` say-phrase. It can be passed a phrase invocation or a complete conditional, but it cannot be passed just a value. Any variables local to your For testing rule won't be available; don't make assignments in your phrase. For example:

for "inv-test" assert "[test follow the the print standard inventory rule]" rmatches "the rubber ducky";

For sayable values, you don't need to use ``test``.

for "entry 0 error" assert "[entry 0 of empty-l]" reports an error;

``<text> reports an error`` is true if the text includes a newline character followed by three asterisks and a space.

Chapter Output Result

The output for the results is determined by the ``output result`` phrase property on the relevant unit test.
You can see simple-output-result and original-output-result in the code for working examples. The following
values and say phrases provide the ingredients to build your own:

Values:
- ut-assert (truth state) true if it was an assertion; false if it was a refutation
- ut-truth-state (truth state) true if it was a conditional or boolean; false if it was a comparison
- ut-result (truth state) true if passed; false if failed

Suppose that ``say foo 123`` produces ``123 out of range for foo``.

	for "foo 123" assert "[foo 123]" exactly matches "123";
	for "foo 123 error" assert previous reported error;

*Both* of these will fail. ``"[foo 123]"`` was never actually said, so it didn't
end up captured so that ut-test-output could find it. In this case:

	for "foo 123 error" assert "[foo 123]" rmatches "^\*\*";

would be better.
	
Say phrases:
- ut-expected:
- for comparisons: the expected (right hand side of the comparison) value
- for conditional/booleans: if it was a refutation, false; if it was an assertion, true.
- ut-found:
- if using the test say-phrase, all output
- otherwise:
	- for comparisons, the found (left hand side of the comparison) value
	- for conditional/booleans, the same as ut-expected if the test passed;
	the opposite of ut-expected if the test failed
- ut-how-tested: the text "Asserted" or "Refuted".
- ut-operator: if it was a comparison, a textual representation of the operator
- ut-opposite: if it was a comparison, a textual representation of the opposite of the operator
(i.e., instead of <, ==, >, it would be >=, <>, <=, respectively)

It's a phrase text -> nothing; it automatically receives as a parameter the text value
specified in ``for <label>``.

You can set a custom phrase as the default for all unit tests:

	The output result of a unit test is usually custom-output-result.

Or create subkinds of unit tests that have different defaults:

	Verbose unit test is a kind of unit test.
	The output result of a verbose unit test is usually verbose-output-result.
	Terse unit test is a kind of unit test.
	The output result of a terse unit test is usually terse-output-result.

Or set a custom phrase on a per unit test basis:

	Complicated phrase trial is a unit test.
	The output result of complicated phrase trial is complicated-output-result.

Since the granularity is at the unit test level, all test statements in rules
associated with some given unit test must all use the same output result phrase.
If you find you want different output result phrases for some of them, move them
to a different unit test with a different output result phrase.

Chapter Test commands

Otherwise you can enter the command ``test suite`` or ``utest``.

The ``utest`` command can also take an argument. It will run all unit tests whose object
names begin with the argument given, so if you choose common prefixes for the names of
related unit tests, you can easily run those together, e.g.,

	person-wearing is a unit test. [...]
	person-carrying is a unit test. [...]

	[...]

	> utest person

Chapter Use Options

Section Less Verbose

You can omit details about successful tests with:

	Use don't report passing tests.

Section Test Automatically

There is a "test automatically" use option. You can include:

	Use test automatically.

and all tests will be run on startup.

Section Quit after autotesting

	Use quit after autotesting.

Quits the game after testing. It does nothing unless test automatically is also active.

Section Test quietly (for use with Text Capture by Eric Eve)
	Use test quietly.
Suppresses any text output the assertions' and refutations' operations would normally produce.
If Text Capture is not included, this Use option doesn't get defined and mention of it would
cause a compilation error.

Chapter Text comparisons

If you have this:

To say ab: say "x";
To say cd: say "x";
To say xx: say "xx";

all of these are false:

if "[ab]" is "[cd]" [...]
let t be "[ab]";
if t is "[ab]" [...]
if "[ab]" is "[ab]" [...]

but the following are true:

if "x" is "[ab]" [...]
if "[cd]" is "x" [...]
if the substituted form of "[ab]" is the substituted form of "[cd]" [...]
if "[ab]" exactly matches the text "[cd]" [...]
if "[ab]" matches the text "x" [...]
if "[ab]" matches the text "[ab]" [...]
if "[ab]" matches the text "[cd]" [...]
if "[xx]" matches the text "[ab]" [...]
if "[ab]" matches the regular expression "[cd]" [...]

In old versions of I7, text and indexed text were separate types. Only texts
could include substitutions; indexed texts were some particular static string.
Subsequently, they were collapsed together (you can still use "indexed text"
as a synonym for "text") but they continue to have different underlying representations.

When you test whether a text containing substitutions *is* a text that doesn't,
I7 automatically takes the substituted form of the text containing substitutions.
But when you test whether a text containing a substitution *is* a text containing
another substitution, the answer doesn't depend on whether the evaluations of the
two texts are the same, but on whether the underlying function representing it is
the same. Outside of contrived circumstances, this will be false. That's why we
have the ``substituted form of`` and ``exactly matches the text`` phrases. (I avoid
using "is" in text comparisons unless there's a text literal on one side.)

Additionally, if a text T contains a substitution, ``if T is empty`` is always
false, whether or not the substituted form of T is empty.

All of ``exactly matches the text``, ``matches the text``, and ``matches the
regular expression`` automatically take the substituted forms of the texts.

But to make writing tests easier, you can use ``if T1 == T2`` and it acts like
``if T1 exactly matches the text T2``. And you can use ``if T1 is blank`` and
that acts like ``if T1 exactly matches the text ""``.

The phrase

if <text1> matches the text <text2>

is true if text2 occurs anywhere within text 1. So these are all true:

If "banana" matches the text "b"
If "banana" matches the text "an"
If "banana" matches the text "anana"

This is awkwardly non-parallel to similar phrases to compare snippets and topics,
where

if <snippet> matches <topic>

is true only if it's an exact match, and

if <snippet> includes <topic> is true if the topic occurs anywhere within the
snippet, like the behavior of ``matches the text``.

So this extension includes the following phrases, that correspond to the behavior
of snippets and topics:

if <text1> exactly matches <text2>
if <text1> includes <text2>

(There are also ``does not exactly match`` and ``does not include``.) This allows you
to forget about ``matches the text`` and to always use ``exactly matches`` and ``includes``
and to get the same behavior.

Existing phrases are unchanged.

Further, it includes the following just to reduce the verbosity of regular expression
usage:

if <text> rmatches <text of a regexp> [ = if <text> matches the regular expression <text of a regexp> ]
let t1 be match 1 [ = text matching subexpression 1 ]
let t0 be match 0 [ = text matching the regular expression ]

Beware that the values of the matches only persist until the next regular expression operation, so store
the results of a regexp match before trying to use ``exactly matches`` to test them.

Chapter Prior art

Section Other unit testing extensions

[Unit Testing by Nathanael Marion](https://gitlab.com/Natrium729/extensions-inform-7/-/blob/master/Unit%20Testing.i7x)
[Unit Testing by Peter Orme](https://github.com/i7/extensions/blob/master/Peter%20Orme/Unit%20Testing.i7x)
[Checkpoints by Peter Orme](https://github.com/i7/extensions/blob/master/Peter%20Orme/Checkpoints.i7x) (includes Unit Testing by Peter Orme)
[Command Unit Testing by Xavid](https://github.com/i7/extensions/blob/master/Xavid/Command%20Unit%20Testing.i7x)
[I7Spec by Jeff Nyman](https://github.com/jeffnyman/exploring-testing/blob/master/Learning.materials/Extensions/Jeff%20Nyman/i7Spec.i7x)

Section of related interest

[Object Response Tests by Juhana Leinonen](https://github.com/i7/extensions/blob/master/Juhana%20Leinonen/Object%20Response%20Tests.i7x)
[Benchmarking by Dannii Willis](https://github.com/i7/extensions/blob/master/Dannii%20Willis/Benchmarking.i7x)
[profile-analyze.py](https://github.com/erkyrath/glulxe/blob/master/profile-analyze.py)

Section for 6G60

[Simple Unit Tests by Dannii Willis](https://github.com/i7/extensions/blob/master/Dannii%20Willis/Simple%20Unit%20Tests.i7x)
[Automated Testing by Kerkerkruip](https://github.com/i7/kerkerkruip/blob/master/Kerkerkruip.materials/Extensions/Kerkerkruip/Automated%20Testing.i7x)
[Automated Testing by Roger Carbol](https://github.com/i7/archive/blob/master/Roger%20Carbol/Automated%20Testing.i7x)

The fundamental mechanism at the heart of Simple Unit Tests ceased working after 6G60, and Kerkerkruip's
Automated Testing depends on Simple Unit Tests. (Despite the names, it and Automated Testing by Roger Carbol
don't appear to be related.)

The design of this extension's interface owes most to Simple Unit Tests and Benchmarking.

Chapter Changelog

v7: put back enough support for Text Capture to reinstate Use test quietly.
	Introduced special-case for texts of == meaning exactly matches and
	``is blank`` meaning ``is ""``.

v6: ripped out text capture support and the unit test operator value kind of value
	added ``test`` say-phrases and ``reports an error`` phrase.

v5: added heap tracking unit tests, per a contribution by Dannii Willis
	fixed bug by which output was written to the file of results twice
	renamed phrases for saving, restoring state
	eliminated utest rulebook; incorporated functionality into To say test results

v4: support for Text Capture by Eric Eve

v3: Output now done in I7 via output result phrase text -> nothing on unit tests.

v2: Renamed "unit-test" -> "unit test"; completely changed how assertions and refutations
are formed. Incorporated some suggestions and code by Dannii Willis.

Chapter Examples


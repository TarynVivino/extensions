Version 7.0.2 of Unit Tests by Zed Lopez begins here.

"For unit testing."

[ relies on the interpreter supporting save/undo ]

Volume Unit Tests (not for release)

Part Output file

The file of results is called "utresults".

Part Constants

Chapter Improbable

To decide what number is improbable number: (- IMPROBABLE_VALUE -).

Chapter maximum int

To decide what number is max/maximum positive/-- number/integer: (- MAX_POSITIVE_NUMBER -).

Chapter minimum int

To decide what number is min/minimum negative/-- number/integer: (- MIN_NEGATIVE_NUMBER -).

Part Use Option

Chapter Test Automatically

Use test automatically translates as (- Constant TEST_AUTOMATICALLY; -).

Last when play begins (this is the test all unit tests automatically rule):
  if test automatically option is active, test all unit tests.

Section Quit Afterwards

Use quit after autotesting translates as (- Constant QUIT_AFTER_AUTOTESTING; -).

Chapter Write to file

Use write test results to file translates as (- Constant WRITE_TEST_RESULTS_TO_FILE; -).

First when play begins when write test results to file option is active (this is the unit test create or empty results file rule):
  write "" to file of results.

Chapter Don't Report passing tests

Use don't report passing tests translates as (- Constant DONT_REPORT_PASSING_TESTS; -).

Part what VM?

To decide if in/on a/-- Zmachine/Z-machine/zcode/z-code: (- (WORDSIZE == 2) -).

To decide if in/on a/-- glulx machine/--: (- (WORDSIZE == 4) -).

[To decide what number is word size: (- WORDSIZE -).

To decide if in/on a/-- Zmachine/Z-machine/zcode/z-code: decide on whether or not word size is 2.

To decide if in/on a/-- glulx machine/--: decide on whether or not word size is 4.
]
Part Undo

[ VM_Save_Undo, z5+
Z-machine:
-1 terp doesn't support
0 failure
1 save succeeded
2 back from restoration
]



To decide what number is the save-restore state: (- VM_Save_Undo() -).

Back from restoration is always 2.

To restore state: (- VM_Undo(); -).

Part unit test object

A unit test is a kind of object.
A unit test has a text called the description.
A unit test can be heap tracking.

The current unit test is a unit test that varies.

A unit test has a phrase text -> nothing called the output result.

To say ut-how-tested: if ut-assert is true, say "Asserted";
else say "Refuted".

To verbosely output result with (T - a text) (this is original-output-result):
  say "[ut-how-tested] [T]: expected ";
  if ut-truth-state is true begin;
    if ut-result is true, say "and found true";
    else say "true, found false";
  else;
    if ut-assert is true, say ut-operator;
    else say ut-opposite;
    say " [ut-expected], found: [ut-found]";
  end if;
  if ut-result is true, say " (pass)";
  else say " (fail)";
  say line break;

To decide what number is text-type: (- TEXT_TY -).

To simple output result with (T - a text) (this is simple-output-result):
  if ut-result is false or don't report passing tests option is not active begin;
    say "[ut-how-tested] [T]: ";
    if ut-truth-state is true, say "[ut-found]";
    else say "tested [ut-found] [ut-operator] [ut-expected]";
    if ut-result is true, say " (pass)";
    else say " (fail)";
    say line break;
  end if;
  
The output result of a unit test is usually simple-output-result.

The description of a unit test is usually "".


Chapter Saying unit test

To say (ut - a unit test):
  if the description of ut is "", say "[printed name of ut]";
  else say description of ut.

Part Success and failure counting

[ For ease of sharing info between I7 and I6 these are globals.
  Only one test should be occurring at a time, so their globality
  shouldn't pose any problem. ]
Include (-
Global unit_test_success;
Global unit_test_failure;
Global ut_expected; ! LHS for comparative ; true/false for conditional
Global ut_found; ! RHS for comparative ; true/false for conditional
Global ut_kind; ! strong kind of operands for comparative; irrelevant for conditional
Global ut_truth_state; ! 0: comparative ; 1 : conditional
Global ut_operator; ! -1: < ; 0: == ; 1: >
Global ut_result; ! 0: fail ; 1: pass
Global ut_assert; ! 0: refutation ; 1: assertion
Global ut_test_output;
! an operator constant xor-ed with 7 produces its opposite
Constant EQ_OK = 1;
Constant LT_OK = 2;
Constant GT_OK = 4;
Global GE_OK;
Global LE_OK;
Global NE_OK;
!Constant GE_OK = EQ_OK | GT_OK;
!Constant LE_OK = (EQ_OK | LT_OK);
!Constant NE_OK = (LT_OK & GT_OK); ! literally <> !

[ AssignCmpPseudoConstants;
  GE_OK = EQ_OK | GT_OK;
LE_OK = (EQ_OK | LT_OK);
NE_OK = (LT_OK & GT_OK);
];
-) after "Definitions.i6t".

to assign comparison pseudoconstants: (- AssignCmpPseudoConstants(); -)

after starting the virtual machine: assign comparison pseudoconstants.


ut-assert is a truth state variable.
ut-assert variable translates into I6 as "ut_assert".

ut-truth-state is a truth state variable.
ut-truth-state variable translates into I6 as "ut_truth_state".

ut-op is a number variable.
ut-op variable translates into I6 as "ut_operator".

ut-kind is a number variable.
ut-kind variable translates into I6 as "ut_kind".

ut-result is a truth state variable.
ut-result variable translates into I6 as "ut_result".

ut-test-output is a truth state variable.
ut-test-output variable translates into I6 as "ut_test_output".

Unit test success is a number variable.
Unit test success variable translates into I6 as "unit_test_success".

Unit test failure is a number variable.
Unit test failure variable translates into I6 as "unit_test_failure".

to say ut-operator: (- print (utop) ut_operator; -)

To say ut-expected: (- if (ut_truth_state) { utTruth(ut_expected); } else {
if (ut_kind == TEXT_TY) print "~";
PrintKindValuePair(ut_kind, ut_expected);
if (ut_kind == TEXT_TY) print "~";
 } -).
To say ut-found: (- if (ut_kind) {
if (ut_kind == TEXT_TY) print "~";
PrintKindValuePair(ut_kind, ut_found);
if (ut_kind == TEXT_TY) print "~";
} else { utTruth(ut_found); } -)

to say ut-opposite: (- print (utop) bitxor(ut_operator, 7); -)

Part Actions

Chapter unit testing

unit testing is an action out of world.
Understand "utest" as unit testing.

Check unit testing (this is the check for unit tests rule): unless there are unit tests, instead say "No unit tests have been defined.";

Carry out unit testing (this is the test all unit tests rule): test all unit tests.

Chapter Test all unit tests to-phrase

To test all unit tests: test all unit tests matching "".

Section test all unit tests matching

To say test results for (ut - a unit test):
  now unit test success is 0;
  now unit test failure is 0;
  if the save-restore state is back from restoration, stop;
  carry out the testing activity with ut;
  let total test count be unit test success + unit test failure;
  let summary be "[if unit test failure > 0]***[else]   [end if] [unit test success]/[total test count] passed[if unit test failure is 0].[else]; [unit test failure]/[total test count] failed.[end if][line break]";
  output summary;
  restore state;
  
To test all unit tests matching (T - a text):
  let matching-unit-tests-count be 0;
  repeat with ut running through the unit tests begin;
  if T is empty or printed name of ut rmatches "^[T]", case insensitively begin;
      let result be the substituted form of "[test results for ut]";
      output result;
      increment matching-unit-tests-count;
    end if;
  end repeat;
  if the test automatically option is active and the quit after autotesting option is active, follow the immediately quit rule;
  if matching-unit-tests-count is 0, say "No unit tests began with '[T]'.";
  
Chapter Stash (for use with Text Capture by Eric Eve)

To stash unit test output (this is ut-stash):
  unless the test quietly option is active, output "[captured text]";

Chapter Fake Stash (for use without Text Capture by Eric Eve)

To stash unit test output (this is ut-stash):
  do nothing.

Chapter say test

To say test (ph - phrase): (- ut_test_output = 1; if (0==0) {ph} -).

To say test (C - a condition):
  (- ut_test_output = 1; if ({C}) { print ""; } -).

To decide if (T - a text) reports an/-- error:
  decide on whether or not T rmatches "(.*\n)*\*\*\* ".

Chapter Test command

[ ``> test suite`` can be used instead of ``> utest`` ]
Test suite with "utest".

Chapter Specific-utesting

Specific-utesting is an action out of world applying to one topic.
Understand "utest [text]" as specific-utesting.

Section Carry out specific-utesting

Carry out specific-utesting (this is the carry out unit testing via utest command rule):
  test all unit tests matching "[the topic understood]"

Part Assertions

Part Testing something activity

Testing something is an activity on unit tests.
The testing activity has a number called the initial heap usage.

To decide what number is the current heap usage:
  (- ((MEMORY_HEAP_SIZE + 16) - HeapNetFreeSpace(false)) -).

First before testing a heap tracking unit test (called ut) (this is the unit test say your name rule):
  now the initial heap usage is the current heap usage;

First before testing a unit test (called ut) (this is the unit test mark not ready to read rule):
  if write test results to file option is active, mark the file of results as not ready to read;
  output "[line break]Testing [ut][line break]";

After testing a heap tracking unit test (called ut) (this is the unit test heap usage reporting rule):
  let heap-usage be the current heap usage;
  if heap-usage is not initial heap usage, output "*** Test [ut] altered heap usage: was [initial heap usage], now [current heap usage].[line break]" 

Last after testing when write test results to file option is active (this is the unit test mark ready to read rule):
  mark the file of results as ready to read;

The for testing rules have default no outcome.

Include (-

[ bitxor n1 n2 result;
  return (n1 | n2) & (~(n1 & n2));
];

[ utTruth x;
  if (x) print "true";
  else print "false";
  ];

[ utAssertPlain x assert txt;
  EndCapture();
  ((+ ut-stash +)-->1)();
  ut_truth_state = 1;
  ut_found = x;
  ut_result = 0;
  if ((~~x) == (~~assert)) ut_result = 1;
  ut_assert = assert;
  utFinish(txt);
];

[ utTextCompare t1 t2 s1 s2 result;
  s1 = BlkValueCreate(TEXT_TY);
  s2 = BlkValueCreate(TEXT_TY);
  BlkValueCopy(s1, t1);
  BlkValueCopy(s2, t2);
  TEXT_TY_Transmute(s1);
  TEXT_TY_Transmute(s2);
  result = TEXT_TY_Compare(s1, s2);
  BlkValueFree(s1);  
  BlkValueFree(s2);
  return result;
];

[ utAssert x y k cmp_target assert txt equal_op cmp cmp_result;
  EndCapture();
  ((+ ut-stash +)-->1)();
  ut_result = 0;
  ut_operator = cmp_target;
  if (k == NUMBER_TY) cmp = utSignedCompare;
  else if ((k == TEXT_TY) && equal_op) { cmp = utTextCompare; }
  else cmp = KOVComparisonFunction(k);
  cmp_result = cmp(x,y);
  if (assert == (((cmp_result == 0) && (cmp_target & EQ_OK)) || ((cmp_result < 0) && (cmp_target & LT_OK)) || ((cmp_result > 0) && (cmp_target & GT_OK)))) ut_result = 1;
  ut_truth_state = 0;
  ut_kind = k;
  ut_expected = y;
  ut_found = x;
  ut_assert = assert;
  utFinish(txt);
];

[ utFinish txt;
  if (ut_truth_state) ut_kind = 0;
  if (ut_result) {
    unit_test_success++;
#ifndef DONT_REPORT_PASSING_TESTS;
    ((+ output-result +)-->1)(txt);
#endif;
  }
  else {
    unit_test_failure++;
    ((+ output-result +)-->1)(txt);
  }
  StartCapture();
];

[ utSignedCompare x y;
if (x > y) return 1;
if (x < y) return -1;
return 0;
];

[ utop op;
if (op & LT_OK) print "<";
if (op & GT_OK) print ">";
if (op & EQ_OK) print "=";
if (op & EQ_OK) print "="; ! yes, it's supposed to be there twice
];
-)

To output (T - a text):
  say T;
  if write test results to file option is active begin;
    unless ready to read file of results begin;
      append T to file of results;
      mark the file of results as not ready to read;
    end unless;
  end if;

To say captured output of current test statement result for (T - a text): 
  apply output result of current unit test to T.

To report current test statement result for (T - a text) (this is output-result):
  let result be "[if ut-result is true]   [else]***[end if] [captured output of current test statement result for T]";
  output result;
  if ut-test-output is true, now ut-test-output is false;

Book Assertions and Refutations

Part or neither

Chapter instant

To for (txt - a text) pass:
  (- utAssertPlain(1,1,{txt}); -).

To for (txt - a text) fail:
  (- utAssertPlain(0,1,{txt}); -).

Part Assertions

Chapter boolean (for use with If True by Zed Lopez)

To for (txt - a text) assert (X - value of kind K):
  (- utAssertPlain({X},1,{txt}); -).

Chapter conditional

To for (txt - a text) assert (C - a condition):
  (- utAssertPlain({C},1,{txt}); -).

Chapter equality

To for (txt - a text) assert (X - value of kind K) is (Y - K):
  (- utAssert({X},{Y},{-strong-kind:K},EQ_OK,1,{txt}); -)

To for (txt - a text) assert (X - a text) is blank:
  (- utAssert({X},(+ empty-string +),{-strong-kind:text},EQ_OK,1,{txt}); -)

To for (txt - a text) assert (X - value of kind K) == (Y - K):
  (- utAssert({X},{Y},{-strong-kind:K},EQ_OK,1,{txt}, 1); -)

Chapter greater than
  
To for (txt - a text) assert (X - value of kind K) > (Y - K):
  (- utAssert({X},{Y},{-strong-kind:K},GT_OK,1,{txt}); -).

Chapter less than
  
To for (txt - a text) assert (X - value of kind K) < (Y - K):
  (- utAssert({X},{Y},{-strong-kind:K},LT_OK,1,{txt}); -).

Chapter <=

To for (txt - a text) refute (X - value of kind K) <= (Y - K):
  (- utAssert({X},{Y},{-strong-kind:K},LE_OK,1,{txt}); -).

Chapter <=

To for (txt - a text) refute (X - value of kind K) >= (Y - K):
  (- utAssert({X},{Y},{-strong-kind:K},GE_OK,1,{txt}); -).

Part Refutations

Chapter boolean (for use with If True by Zed Lopez)

To for (txt - a text) refute (X - value of kind K):
  (- utAssertPlain({X},{-strong-kind:K},0,{txt}); -).

Chapter conditional

To for (txt - a text) refute (C - a condition):
  (- {-my:1} = 0; if ({C}) {-my:1} = 1; utAssertPlain({-my:1},0,{txt}); -).

Chapter equality

To for (txt - a text) refute (X - value of kind K) is (Y - K):
  (- utAssert({X},{Y},{-strong-kind:K},EQ_OK,0,{txt}); -)

To for (txt - a text) refute (X - a text) is blank:
  (- utAssert({X},(+ empty-string +),{-strong-kind:K},EQ_OK,0,{txt}); -)

To for (txt - a text) refute (X - value of kind K) == (Y - K):
  (- utAssert({X},{Y},{-strong-kind:K},EQ_OK,0,{txt},1); -)

Chapter greater than
  
To for (txt - a text) refute (X - value of kind K) > (Y - K):
  (- utAssert({X},{Y},{-strong-kind:K},GT_OK,0,{txt}); -).

Chapter less than
  
To for (txt - a text) refute (X - value of kind K) < (Y - K):
  (- utAssert({X},{Y},{-strong-kind:K},LT_OK,0,{txt}); -).

Chapter <=

To for (txt - a text) refute (X - value of kind K) <= (Y - K):
  (- utAssert({X},{Y},{-strong-kind:K},LE_OK,0,{txt}); -).

Chapter <=

To for (txt - a text) refute (X - value of kind K) >= (Y - K):
  (- utAssert({X},{Y},{-strong-kind:K},GE_OK,0,{txt}); -).

Book Other interactions

Chapter text comparisons (For use without Textile by Zed Lopez)

To decide what text is an/-- expanded (T - a text):
    (- TEXT_TY_SubstitutedForm({-new:text}, {-by-reference:T}) -).

To decide if a/an/-- (S - text) exactly matches a/an/-- (T - text): decide on whether or not S exactly matches the text T;
To decide if a/an/-- (S - text) does not exactly match a/an/-- (T - text): if S exactly matches T, no; yes.
To decide if a/an/-- (S - text) includes a/an/-- (T - text): decide on whether or not S matches the text T;
To decide if a/an/-- (S - text) does not include a/an/-- (T - text): if S includes T, no; yes.

To rmatch a/an/-- (V - a text) by a/an/-- (R - a text), case insensitively:
  (- TEXT_TY_Replace_RE(REGEXP_BLOB,{-by-reference:V},{-by-reference:R},0,{phrase options}); -).

To decide if (V - a text) rmatches a/an/-- (R - a text), case insensitively:
  (- TEXT_TY_Replace_RE(REGEXP_BLOB,{-by-reference:V},{-by-reference:R},0,{phrase options}) -).

[ unfortunate ambiguity if we add case insensitively here ]
To decide if (V - a text) does not rmatch a/an/-- (R - a text), case insensitively:
  (- (~~(TEXT_TY_Replace_RE(REGEXP_BLOB,{-by-reference:V},{-by-reference:R},0,{phrase options}))) -).

To decide what text is the/a/-- match (N - a number):
  (- TEXT_TY_RE_GetMatchVar({N}) -).

To rmatch (V - a text) by/with/against a/an/-- (R - a text), case insensitively:
  (- TEXT_TY_Replace_RE(REGEXP_BLOB,{-by-reference:V},{-by-reference:R},0,{phrase options}); -).

To decide what text is a/an/-- (T - a text) trimmed:
  rmatch T against "^\s*(.*?)\s*$";
  decide on match 1;

Book Text Capture (for use with Text Capture by Eric Eve)

Use maximum capture buffer length of at least 8192;

Use test quietly translates as (- Constant TEST_QUIETLY; -).

This is the unit test text capture rule: start capturing text.

The unit test text capture rule is listed after the the unit test say your name rule in the before testing rules.

First after testing a unit test: stop capturing text;

Book Fake I6 Stubs (for use without Text Capture by Eric Eve)

Include (-
[ EndCapture;
  rfalse;
];
[ StartCapture;
  rfalse;
];
-)


Unit Tests ends here.

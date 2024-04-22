Version 2.2.1 of Unit Testing by Peter Orme begins here.

"A developer extension that lets you write unit tests (asserts) in Inform 7."

Include Developer Framework by Peter Orme.

Chapter 1 - Asserter

Section 1 - The Asserter proper 

[The Asserter is currently not implemented as a kind, just a single object]

The asserter is an object. 
The asserter has a number called _numsucceeded.
The asserter has a number called _numfailed.
The asserter has a verbosity. It is normal verbosity.
The asserter has a halting behavior. It is halt on summary.

Section 2 - Stopping abruptly (for use without Basic Screen Effects by Emily Short)

To stop the/-- game abruptly:
	(- quit; -)

Chapter 2 - Asserter methods

Section 1 - Asserting A is B

to assert that/-- (actual - a value) is (expected - a value):
	assert actual is expected saying only "Expected [expected], was [actual]"

[
	Asserts that a given value is an expected value, with a descriptive message.
]
to assert that/-- (actual - a value) is (expected - a value) saying (msg - a text):
	assert actual is expected saying only "[msg], expected [expected], was [actual]"
		
[
	Asserts that a given value is an expected value, with a descriptive message.
]
to assert that/-- (actual - a value) is (expected - a value) saying only (msg - a text):
	if actual is expected:
		assert_ok "[msg][line break]";
	otherwise:
		assert_fail "[msg][line break]";	

Section 2 - Asserting A is not B

to assert that/-- (actual - a value) is not (expected - a value):
	assert that actual is not expected saying only "Expected anything but [expected], was [actual]"

[
	Asserts that a given value is different from some other value, with a descriptive message.
]
to assert that/-- (actual - a value) is not (expected - a value) saying (msg - a text):
	assert that actual is not expected saying only "[msg], expected anything but [expected], was [actual]"
		
to assert that/-- (actual - a value) is not (expected - a value) saying only (msg - a text):
	if actual is not expected:
		assert_ok "[msg][line break]";
	otherwise:
		assert_fail "[msg][line break]";

Section 3 - Asserting some value is greater than some other value

[
	Asserts that a given value is greater than some expected value, with a descriptive message.
]
to assert that/-- (actual - a number) is greater than (min - a number):
	assert actual is greater than min saying only "Expected minimum [min], was [actual]".

[
	Asserts that a given value is greater than some expected value, with a descriptive message.
]
to assert that/-- (actual - a number) is greater than (min - a number) saying (msg - a text):
	assert actual is greater than min saying only "[msg], expected minimum [min], was [actual]".

to assert that/-- (actual - a number) is greater than (min - a number) saying only (msg - a text):
	if actual is greater than min:
		assert_ok "[msg][line break]";
	otherwise:
		assert_fail "[msg][line break]";
		
Section 4 - Asserting some text is empty

[
	Asserts that a text is empty, with a descriptive message.
]
to assert that/-- (actual - a text) is empty:
	if actual is empty:
		assert_ok "Expected an empty text, ok.[line break]";
	otherwise:
		assert_fail "Expected an empty text, was [actual].[line break]";	

[
	Asserts that a text is empty, with a descriptive message.
]
to assert that/-- (actual - a text) is empty saying (msg - a text):
	if actual is empty:
		assert_ok "[msg] - expected an empty text, ok.[line break]";
	otherwise:
		assert_fail "[msg] - '[actual]' is not an empty text[line break]";	

[
	This is like assert (text) is empty saying (message) except this will not 
	append the "'[actual]' is not empty" in the message.
]
to assert that/-- (actual - a text) is empty saying only (msg - a text):
	if actual is empty:
		assert_ok "[msg][line break]";
	otherwise:
		assert_fail "[msg][line break]";	

Chapter 3 - Other things the asserter does 

Section 1 - halting execution 

to halt execution saying (msg - a text):
	say paragraph break; 
	say msg;
	say paragraph break; 
	stop the game abruptly; [using a phrase from Basic Screen Effects by Emily Short]

Section 2 - Recording a succesful test

[
	Records a successful test and increments the _numsucceeded counter. 
]		
to assert_ok (msg - a text):
	if the verbosity of the asserter is high verbosity:
		say "OK: [msg]";
	increase the _numsucceeded of the asserter by 1;	

Section 3 - Recording a failed test

[
	Records a failed test and increments the _numfailed counter. 
]	
to assert_fail (msg - an indexed text):
	unless the verbosity of the asserter is low verbosity, say "FAIL: [msg]";
	increase the _numfailed of the asserter by 1;
	if the halting behavior of the asserter is halt on failure:
		halt execution saying "Halting on failure - [msg]";

Section 4 - Deciding whether the asserter is happy

[
	Checks if the Asserter is "happy", which it is only if it has no failed tests.
]	
to decide whether the asserter is happy:
	if the _numfailed of asserter is 0, decide yes;
	decide no.	

Section 5 - Counting the total
	
[
	Returns the total number of tests run (failed and successful).
]
to decide which number is tested of asserter:
	decide on the _numfailed of asserter + the _numsucceeded of asserter;
	

Section 6 - Resetting the asserter 

[
	Resetting the asserter means setting its counters to zero.
]
to reset the/-- asserter: 
	now the _numfailed of asserter is 0;
	now the _numsucceeded of asserter is 0;

Section 7 - Reporting asserts 

[
	Prints a summary of the assertions already carried out, possibly halting the execution. 
	You can specifify the verbosity: with silent, nothing is printed at all, with conversational only failures are printed, with verbose both failures and successes are printed. 
	
	Note that the halting behavior of the asserter comes into play. If the halting behavior is "halt on summary", and there indeed have been failures recorded by the asserter (since the last asserter reset), execution will stop. 
	
	Warning: The combination "halt on summary" and "silent" is perhaps not a very good choice, as it will indeed stop, but without telling you that much about why it stopped. 
] 
to report asserts using (V - a verbosity) set to (H - a halting behavior):
	if asserter is happy:
		if V is high verbosity:
			say "*** Assertions OK ***[line break]";
			say "Tested [tested of asserter] assertions without failures.";
	otherwise:
		say "*** ASSERTIONS FAILED ***[line break]";
		say "Tested [tested of asserter] assertions with [_numfailed of asserter] failures.";
	unless the asserter is happy:
		unless H is halt never:
			halt execution saying "There were [_numfailed of asserter] failures.";

to report asserts using (V - a verbosity):
	report asserts using V set to halt never;


[
	prints a summary of the assertions already carried out, possibly halting the execution, using the verbosity of the asserter (rather than having to pass it in).
]
to report asserts:
	report asserts using the verbosity of the asserter set to the halting behavior of the asserter.


Unit Testing ends here.

This is an extension aimed at software developer-type Inform 7 authors. It allows you to write "asserts" in the code.

The main idea is to make a bunch of assertions, and then check the results, as a way of grouping asserts together.

Chapter: Testing

The typical usage involves writing some code that runs a number of "assert" tests. The assert calls all have the form "assert" (actual) something (expected) saying (message) where actual is the actual value, expected some expected value, and message is the message that is used if the assertion fails (or succeeeds, in verbose mode). Finally the "something" is one of "is", "is not" or "is greater than".

There are some versions on this. First, there is an optional "that", if we think that reads more fluently: "assert that 1 + 2 is 3 saying 'adding numbers'". Second, if we don't want to include a message (the "saying" part) we can just leave that out, but adding a message makes it easier for us too recognize where the test is in the code. Finally there is a "saying only" version. The "saying (message)" version prepends that message to whatever text the test naturally logs, typically the expected and actual parameters. If we want to be in complete control we can use the "saying only" version which does not append any such additional texts. In fact, the other two versions use the "saying only" version internally.


Section: asserting two values are the same

assert (actual - a value) is (expected - a value) saying (msg - a text)

Section: asserting two values are different

assert (actual - a value) is not (expected - a value) saying (msg - a text)

Section: asserting one value is greater than the other

assert (actual - a value) is greater than (expected - a value) saying (msg - a text)

Section: asserting a text is empty

assert (actual - a text) is empty saying (msg - a text)

There is a special form that does not append the value to the message:

assert (actual - a text) is empty saying only (msg - a text)


Chapter: Reporting

While you run asserts, the asserter object gathers information about the number of failed and succesful tests. The "report asserts" action will print out a summary of the results. Setting the verbosity affects how much output this produces, and for the "report asserts" action you may also pass in a verbosity using the "report asserts using verbose" phrase.

The use of "report asserts using silent" may seem a silly thing to do, but if the halting behavior is set to "halt on summary", which is the default, it still does do something: if halts the execution of the entire game if there have been failures. However, it does that without really providing much of a clue to what went wrong, so the combination of "silent" and "halt on summary" really is rather unhelpful.

Chapter: Settings

There are two settings that that modify the behavior of the asserter.

Section: Setting the verbosity

To set the verbosity, use a phrase like "now the verbosity of the asserter is high verbosity".  Setting to to high verbosity will make it say more,
setting it to low verbosity will make it quiet. The default is normal verbosity.

Section: Setting the halting behavior

There are also three values for the "halting behavior". Setting it to "halt on failure" will make it halt (stop the execution of the entire game) as soon as an assertion fails. Setting it to "halt never" will, not surprisingly, make it never halt. The default is "halt on summary", which will make it halt in the "report asserts" action, but only if there were any failures.

Chapter: Version History

Section: Version 2

Introduces an optional "that" so you can use either "assert that 1 + 1 is 2 saying 'adding numbers'" or "assert that 1 + 1 is 2 saying 'adding numbers'". Also makes the "saying" part optional, so you can use just "assert that 1 + 1 is 2".

Chapter: Examples


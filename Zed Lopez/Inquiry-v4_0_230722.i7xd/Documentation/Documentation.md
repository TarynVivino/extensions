Chapter Warnings

If you include this module, you won't be able to compile without defining at least one inquiry.
That could be a dummy, if for whatever reason you'd rather do that than comment out the Include.

	dummy-inquiry is an answered inquiry.

Chapter Inquiries

Use of this extension is driven by creating inquiries. (I didn't use "question" just because I
figure "inquiry" had somewhat less chance of name collision.) The actual text of the inquiry
is defined by its description field, so it can be assigned with a plain text following the
initial inquiry assertion:

	Name-q is an inquiry. "What is your name?"

(It's not an error condition to leave the description blank, but it's also not useful.)

One of inquiries' properties is answered vs. unanswered. If there are any unanswered
inquiries, they're asked in a loop that doesn't end until there are no unanswered
inquiries. The rule triggering this loop comes between the action rulebooks and the
(first) scene changing rules in the turn sequence, and before the start in the correct
scenes rule in the After starting the virtual machine rules.

If you want inquiries to be asked later in the game, create them as initially answered
and change them to unanswered (or change a previously asked and answered inquiry back
to unanswered) during play. You could carry out the Inquiry handling activity manually
if you want, but otherwise it'll be asked immediately after the end of the next action.

Inquiries can be key-input or line-input. Key-input inquiries are answered with
a single keystroke.

Section Ask Y/N Inquiry

An ask y/n inquiry is a subkind of inquiry that is always key-input (well,
technically it's *usually* key-input but don't change that). It's answered
when the users hits Y or N (case-insensitive). There's a specific pair of
adjectives to test whether an ask y/n inquiry has been answered in the
positive: confirmed vs. unconfirmed. Unonfirmed is false if the inquiry is
either unanswered or was answered in the negative.

Section Multiple-choice Inquiry

Another subkind of inquiry is the multiple-choice inquiry. It can be key-input
or line-input. Choices are specified in a multiple-choice-list list of texts.

	Survey is a line-input multiple-choice inquiry. "What's your favorite beverage?"
	
	The multiple-choice-list of survey is
	{ "Tea", "Coffee", "OJ", "water", "zima", "Dr. Pepper",
		"root beer", "vanilla cream soda", "beer", "wine" }.

It can be numbered or lettered, depending on whether you want the choices'
labels to begin with numerals or the alphabet, but either way it will
continue with the other if a numbered multiple-choice inquiry has more than 9
choices or a lettered one has more than 26. There's thus a limit of 36 choices.
It's not an error condition to exceed that, but choices in excess of that won't
be offered. An answer must be supplied, so include a "Skip" or "n/a" choice
as desired.

The big difference between line-input and key-input is that with line-input,
the user will have to hit enter after their selection, and they'll get an
error message if they entered something that isn't a choice; whereas with
key-input it'll just sit there if they enter wrong choices.

There is an Inquiry handling activity that controls the whole loop,
and a separate Inquiring activity, which is an activity on inquiries.

Displaying the inquiry text goes in  Before inquiring rules; For inquiring
rules cover receiving the input and validation; After inquiring rules cover
either error messages or actually storing the result and marking the inquiry
answered.

Y/n inquiries don't output "Y/N" by default, but the activity makes this
easy to set up:

	Last before inquiring a y/n inquiry: say "Y/N ".

The Inquiring activity itself doesn't take any steps to ask again if an inquiry
is unanswered at the end. When the activity is over, we're still in the
Inquiry handling loop and since there's still at least an unanswered inquiry,
the Inquiring activity is carried out again.

An optional inquiry is the final sub-kind of inquiry. It's always line-input and
thus gets a free-form text answer, but the game will accept a blank answer for
an optional inquiry; in every other case, an answer is required. You may wish
to add a response for the case of a user entering a blank response for an
optional question or it looks a lot like nothing happened.

When there are multiple unanswered inquiries to be made, they are always made
in the inquiries' order of definition in the source.

Chapter restart y/n

Just to cater to my own personal preference, there's a provided use option
that will convert the restart command's question to a Y/N inquiry.

	Use restart y/n.

Chapter Changelog

4.0.230721 updated for 10.2

v4: Having abandoned the turn sequence hijacking, there was no point left
to having a scene control question asking, so introduced the inquiry
handling activity. Also added the restart y/n use option.

v3: substantial rewrite to use KeyboardPrimitive for line-input, which
turns out to be far less intrusive than hijacking the turn sequence. Who knew?

Chapter Examples

Section Screenreader


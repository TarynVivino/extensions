This extension allows us to suspend normal parser input to enable questions to be asked and the answers to be processed.

Chapter: About questions

Section: Introduction

During the normal course of a game, the parser responds to commands given by the player.  If we type look, the parser interprets the command and displays a description of the current room; if we type N, the player heads North (if that exit is available, and so on.

Occasionally, we may want to ask specific questions and process the answers.  Examples may be asking the player's name or age or displaying a menu of options from which the player selects a choice.   Answers to these types of questions fall outside the range of the normal parser functions.  Therefore we need to intercept the player's answers to these types of questions and respond to them separately.

This extension provides a framework that can be used to ask different types of questions.  The mechanics are hidden behind the scenes to allow us to concentrate on asking and responding to a question without having to implement the framework ourselves.

Section: What's new?

Version 1

The first public release of Questions.

Version 2

- Punctuation removal in text questions is now optional.

- Questions can now be used in conjunction with the Fixed Point Maths extension to allow questions that requires a real number to be asked.

- To decide phrase added to determine if we are asking a question.

Many thanks are due to Erik Temple for suggesting the changes implemented in version 2.

Version 3

The variable "current menu" has been changed to "current question menu" to avoid a namespace clash with Emily Short's Menu extension.

Version 4

Deprecated phases have been removed from the extension and the examples.

Version 5

- Updated for version 6L02 and above.
- Links to fixed point maths removed.
- Real numbers are questions are supported.
- Requires Glulx.

Chapter: Types of questions

Section: Overview

The extension allow us to ask questions that require different types of answers.  The following questions types are allowed:

- Questions that require a number as an answer.

- Questions that require a real number as an answer.

- Questions that require an item from a menu to be chosen.

- Questions that require a Yes or No answer.

- Questions that require a gender selection (Male, Female or Neuter).

- Questions that require a text answer.

Section: Open and closed questions

The extension makes a distinction between "open" and "closed" questions.  The difference between the two is that closed questions will not allow the game to proceed unless and until we specify that a correct answer has been given to a question.  With open questions, if an 'incorrect 'reply is given, the game proceeds and tries to parse the player's command using the normal parser rules.  For example, if we ask the question "How old are you?" expecting a number answer, the extension will deal with replies differently depending on whether we ask an open or a closed question.

Open questions:

If player answered "inv" to a number question, the extension will exit question mode and proceed to parse the answer normally.  In this case, the player's inventory will be displayed.
If the player answered 12, we determine whether this is an acceptable answer.  If the answer is acceptable, the extension exits question mode and the play resumes.  If the answer is unacceptable, for example the player enters 234 when asked his or her age, we can specify whether the question needs to asked again or whether play should proceed without an answer.

Closed questions:

If the player answered "inv", the answer will be rejected and the player will need to answer the question again.
If the player answered 12, we determine whether this is an acceptable answer.  If the answer is acceptable, the game exits question mode and proceeds as normal.  If the answer is unacceptable, for example the player enters 234, the player will need to answer the question again.

Section: Flag for open or closed questions

To test if a question is an open or a closed question, we can use the 'closed question mode' flag:

	if closed question mode is true:
		do this.

	if closed question mode is false:
		do that.

Chapter: Asking questions

Section: Setting the current question

To ask a question, we first set the text for the question.  The form is:

	now the current question is "How old are you?"

Section: Setting items for menu questions

Before we ask a question that requires an answer from a menu of options, we need to set the menu items to be displayed.  We do this by setting the variable "current question menu" to the list of options that we require.

	now current question is "What is your favourite colour? >";
	now current question menu is {"Red", "Blue", "Green", "Yellow"};
	ask a closed question, in menu mode.

Section: Asking the question in closed question mode

To ask the question in closed mode, we use the following forms for closed questions:

	ask a closed question, in number mode;
	
	ask a closed question, in real number mode;

	ask a closed question, in menu mode;

	ask a closed question, in yes/no mode;

	ask a closed question, in gender mode;

	ask a closed question, in text mode;

Section: Asking the question in open question mode

To ask the question in open mode, we use the following forms for open questions:

	ask an open question, in number mode;
	
	ask an open question, in real number mode;

	ask an open question, in menu mode;

	ask an open question, in yes/no mode;

	ask an open question, in gender mode;

	ask an open question, in text mode;

Chapter: Setting the command prompt for questions

Section: Overview

When a question is asked, we can change the command prompt to indicate to the player that a question is being asked.  By default, the extension sets a series of default prompts.  These are specific to the type of question being asked; they are:

	Closed number prompt: "Please enter a whole number >".

	Open number prompt:  ">".
	
	Closed real number prompt: "Please enter a number >".

	Open real number prompt:  ">".

	Closed menu prompt: "Please select a number between 1 and [number of entries in current question menu] >".

	Open menu prompt is ">".

	Closed yes/no prompt: "Please enter Y or N (Yes or No) >".

	Open yes/no prompt: ">".

	Closed gender prompt: "Please enter M,  F or N (Male or Female or Neuter) >".

	Open gender prompt: ">".

	Closed text prompt: "Please enter your answer >".

	Open text prompt ">".

Section: Changing the question prompt

To change the question prompt, we set the variable "current prompt" to the text that we want:

	Now current question is "How old are you?";
	Now the current prompt is "Enter a number between 5 and 111: >"
	Ask a closed question, in number mode.

If we set the current prompt to "", the relevant default prompt outlined above will be used.

Section: Combining the question and prompt

We can combine the question and the prompt.   To do so, we set the current question to a blank string and the question prompt to the question that we want to ask:

	now current question is "";
	now current prompt is "What is your name? >";
	ask a closed question, in text mode.

Chapter: Responding to the answers given

Section: Player input

The player can answer a question by typing the number, menu number, yes / no response, gender response or text.
The player can also answer a question by using the form 'say X' where X is the answer given.

Section: Rulebooks

When we answer a question, the answer is processed by a rulebook.  By adding our own rules in the game, we can tailor the Questions extension to provide the functionality that we require.

Each type of question has its own rulebook.  These are:

Number questions: The number question rules.

Real number questions: The real number question rules.

Menu questions: The menu question rules.

Yes/No questions: The yes/no question rules.

Gender questions: The gender questions rules.

Text questions: The text question rules.

Section: Rulebook outcomes

Each rulebook has three named outcomes that we can use to control how the game proceeds.  The outcomes are:

Exit: The answer to the question is discarded and the game proceeds as normal.  Usually, we will have used the answer to set other conditions in the game before we use exit.  The exit outcome automatically advances the game by one turn.

Retry: The answer to the question is discarded but we remain in question mode awaiting another answer.  Usually, this will be because the answer to the question is not a valid answer.

Parse: The answer to the question is not disregarded and the question mode ends leaving the answer to be parsed as normal.  Usually, we use this where there is an open question.

Section: Default rules

Each rulebook has default rules.  If we do not create our own rules, the default rules control how answers are processed.  The default rules are set out below.

Section: Adding our own rules

We can add our own rules in the game.  For example:

	A number question rule (this is the set age rating rule):
		if the current question is "How old are you?":
			if the number understood is less than 5:
				say "It seems unlikely that a person of such tender years would be playing this game.";
				retry;
			if the number understood is greater than 111:
				say "I find it hard to believe that this is your real age.  Please be more realistic.";
				retry;
			if the number understood is less than 21:
				say "Setting the game mode to mild!";
				now gamemode is mild;
			otherwise:
				say "Setting the game mode to crude!";
				now gamemode is crude;
			exit.

	A menu question rule (this is the channel rule):
		if the current question is "Which channel would you like to watch on the telly?":
			if the number understood is 1:
				say "Raucous music blasts out from the local music TV station.";
			if the number understood is 2:
				say "The film that comes on is so raunchy that even a hard-bitten army sergeant would blush with shame";
			if the number understood is 3:
				say "The latest trend in reality TV assails you - celebrity navel transplants!";
			if the number understood is 4:
				say "You stomach turns with disgust - the collected speeches of George Bush begin to play.";
			exit.

Section: Rules for number questions

We test the answer to a number question using the phrase 'the number understood'.

There are two default rules for processing answers to number questions.

The first rule, called 'the invalid number reply rule', operates where the player enters an answer to a number question that is not a number.  If the question is a closed number question, the outcome is retry.  If the question is an open question, the outcome is parse.

The last rule, called 'the default number question rule', has the outcome exit.

Section: Rules for real number questions

We test the answer to a real number question using the phrase 'the number understood'.

There are two default rules for processing answers to real number questions.

The first rule, called 'the invalid real number reply rule', operates where the player enters an answer to a real number question that is not a real number.  If the question is a closed number question, the outcome is retry.  If the question is an open question, the outcome is parse.

The last rule, called 'the default real number question rule', has the outcome exit.

Section: Rules for menu questions

We test the answer to menu questions using the phrase 'the number understood'.  The value should be between 1 and the number of items in the menu.

There are two default rules for processing answers to menu questions.

The first rule, called the 'invalid menu reply rule' first tests whether the player has entered a number.  If the player has entered an answer that is not a number, the outcome is retry if the question was a closed menu question or parse if the question was an open menu question.  If a numbered was entered that falls outside the range 1 to the number of items in the menu, the outcome is retry for both open and closed menu questions.

The last rule, called the 'default menu rule', has the outcome exit.

Section: Rules for Yes/No questions

We test the answer to yes/no questions using the phrase 'the decision understood'.  The decision understood takes one of two values, 'Yes' or 'No'.  'Y' and 'N' are understood as Yes and No when the player types their response.

There are two default rules for processing the answers to yes/no questions.

The first rule, called the 'invalid yes/no reply rule' tests whether the player has entered Yes or No.  If the player has not so responded, the outcome is retry if the question is a closed yes/no question or parse if the question is a closed menu question.

The last rule, called the 'default yes/no rule', has the outcome exit.

Section: Rules for gender questions

The test the answer to gender questions using the phrase 'the gender understood'.  The gender understood takes one of three values, 'Masculine', 'Feminine' or 'Neutral'.  'M', 'F' and 'N' are understood as Masculine, Feminine and Neutral when the player types their response.  Neutral is used instead of Neuter as Neuter is defined as an adjective in I7.

There are two default rules for processing the answers to gender questions.

The first rule, called the 'invalid gender reply rule' tests whether the player has entered a valid gender.  If the player has not entered a valid gender, the outcome is retry if the question is a closed gender question or parse if the question is an open gender question.

The last rule, called the 'default gender rule', has the outcome exit.

Section: Rules for text questions

We test the answer to text questions using the variable "current answer".  The current answer is set to the player's answer.  If the answer was given in the form "say answer", the word "say" and the following space is also removed.

There are two default rules for text questions.

The first rule, called the 'remove punctuation from text questions rule' determines whether or not punctuation is removed from the player's answer before it is processed.  We can control punctuation removal by setting the truth state 'punctuation removal'.

	now punctuation removal is true;
	now punctuation removal is false;

The last rule is called the 'default text rule'.  If the question was a closed text question, the outcome is retry.  If the question was an open text question, the outcome is parse.

Chapter: Determining whether or not we are asking a question

If we need to determine whether or not we are currently asking a question, for example as a test in another rulebook, we can do so by using the phrase 'If we are asking a question'.  This will decide Yes if an open or closed question is being asked.


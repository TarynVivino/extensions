Version 6.2.1 of Conversation Suggestions by Eric Eve begins here.
"Provides a means of suggesting topics of conversation to the player, either in response to a TOPICS command or when NPCs are greeted. This extension requires Conversation Framework. Version 3 makes use of Complex Listing by Emily Short if it's included in the same game rather than indexed text to generate a list of suggestions."

Book 1 - Includes

Include Conversation Framework by Eric Eve.

Book 2 - Definitions

Part 1 - Suggestion Lists for People

A person has a list of objects called ask-suggestions.
A person has a list of objects called tell-suggestions.
A person has a list of objects called other-suggestions.

Part 2 - The misc-suggestion Kind

A misc-suggestion is a kind of thing. An misc-suggestion is usually proper-named. 
A misc-suggestion is usually familiar. 
A misc-suggestion has a number called seqno. The seqno of an misc-suggestion is usually 100.

The specification of misc-suggestion is "An misc-suggestion is an object for use in an other-suggestions list. It is used to suggest topics for conversation other than those the player might ask about or tell about (e.g. SAY YES or GIVE HIM THE BOOK). The printed name of an misc-suggestion should be something that would make sense following 'You could '. An misc-suggestion can be given a seqno in order to place it in an appropriate place in the sequence of misc-suggestions."

yes-suggestion is a misc-suggestion. The printed name is "say yes". The seqno is 10.
no-suggestion is a misc-suggestion. The printed name is "say no." The seqno is 12.
yes-no-suggestion is a misc-suggestion. The printed name is "say yes or no". The seqno is 10.

self-suggestion is a familiar thing. The printed name is "[regarding the current interlocutor][themselves]"

Part 3 - Global Variables

sugg-list-ask is a list of objects that varies.
sugg-list-tell is a list of objects that varies.
sugg-list-other is a list of objects that varies.
suggest-on-greeting is a truth state that varies.
suggest-on-greeting is true.

Topic-request is a protocol type that varies. Topic-request is explicit.



Book 2 - Some Useful Phrases

To say remove  (obj - a thing) tell suggestion:
   remove obj from the tell-suggestions of the appropriate-suggestion-database, if present.

To say remove (obj - a thing) ask suggestion:
   remove obj from the ask-suggestions of the appropriate-suggestion-database, if present.

To say remove (obj - a thing) other suggestion:
  remove obj from the other-suggestions of the appropriate-suggestion-database, if present.

To say add (obj - a thing) tell suggestion:
   add obj to the tell-suggestions of the appropriate-suggestion-database, if absent.

To say add (obj - a thing) ask suggestion:
   add obj to the ask-suggestions of the appropriate-suggestion-database, if absent.
  
To say add (obj - a thing) other suggestion:
  add obj to the other-suggestions of the appropriate-suggestion-database, if absent.

To decide which object is the appropriate-suggestion-database:
  decide on the current interlocutor.

Book 3 - Rules

Part 1 - Suggestion List Construction Rules


The suggestion list construction rules are a rulebook.

The first suggestion list construction rule (this is the use the current interlocutor's suggestion lists rule):
  now sugg-list-other is the other-suggestions of the current interlocutor;
  now sugg-list-ask is the ask-suggestions of the current interlocutor;
  now sugg-list-tell is the tell-suggestions of the current interlocutor.

The last suggestion list construction rule (this is the exclude unknown items from suggestions rule):
 Let u-list be the list of unknown things;
 remove u-list from sugg-list-ask, if present;
 remove u-list from sugg-list-tell, if present;
 if the number of entries in sugg-list-other > 0 begin;
   remove u-list from sugg-list-other, if present;
  sort sugg-list-other in seqno order;
end if.

The last suggestion list construction rule (this is the refer to current interlocutor as him-herself in suggestions rule):
  if the current interlocutor is listed in sugg-list-ask begin;
    remove the current interlocutor from sugg-list-ask;
    add self-suggestion at entry 1 in sugg-list-ask;
 end if;
 if the current interlocutor is listed in sugg-list-tell begin;
    remove the current interlocutor from sugg-list-tell;
    add self-suggestion at entry 1 in sugg-list-tell;
 end if.



Part 2 - The Listing Suggested Topics Action

Listing suggested topics is an action applying to nothing.

Understand "topics" as listing suggested topics.

Check listing suggested topics when the current interlocutor is not a person (this is the can't suggest topics when not talking to anyone rule):
  say "[We] [aren't] talking to anyone right [now]." (A) instead.

[ Following the suggestion in Matt Wigdahl's article at http://www.wigdahl.net/quern/2009/12/23/inform-7-development-implementing-single-keyword we use the printed name of  the interlocutor in the following to say phrase, rather than just the current interlocutor, to avoid any custom formatting that may have been applied to topic names in a rule for printing the name of ... when suggestion topics]

To say nothing specific:
   say "[We] [have] nothing specific in mind to discuss with [the printed name of the current interlocutor] just [now]."

Chapter 1a -  Listing Suggested Topics (for use with Complex Listing by Emily Short)

[ This version uses Complex Listing to end the list with "or" rather than "and" ]

Section 1 - Carry Out Listing

Carry out listing suggested topics (this is the list suggested topics rule):
	follow the suggestion list construction rules;
	let ask-suggs be the number of entries in sugg-list-ask;
	let tell-suggs be the number of entries in sugg-list-tell;
	let other-suggs be the number of entries in sugg-list-other;
	if ask-suggs + tell-suggs + other-suggs is 0:
		say "[nothing specific]";
		rule succeeds;
	say "[if topic-request is implicit]([end if][We] [could] " (A);
	if other-suggs > 0:
		say "[sugg-list-other in topic format][if tell-suggs + ask-suggs > 0]; or [end if]" (B);
	if ask-suggs > 0:
		say "ask [regarding the current interlocutor][them] about [sugg-list-ask in topic format][if tell-suggs > 0]; or [end if]" (C);
	if tell-suggs > 0:
		say "tell [regarding the current interlocutor][them] about [sugg-list-tell in topic format]" (D);
	say "[if topic-request is implicit].)[otherwise].[end if][paragraph break]" (E).
	
 
Section 2 - Carry Out Listing Support Routines

To say (l - a list of objects) in topic format:
	set up l for topic printing;
	say "[the prepared list delimited in disjunctive style]";
 
To set up (l - a list of objects) for topic printing:
	repeat with item running through l:
		now the item is marked for special listing;
	register things marked for listing.

Chapter 1b -  Listing Suggested Topics (for use without Complex Listing by Emily Short)

[ This version uses regular expression substitution in indexed text to end the list with "or" rather than "and" ]

Carry out listing suggested topics (this is the complex list suggested topics rule):
  follow the suggestion list construction rules;
  let ask-suggs be the number of entries in sugg-list-ask;
  let tell-suggs be the number of entries in sugg-list-tell;
  let other-suggs be the number of entries in sugg-list-other;
  if ask-suggs + tell-suggs + other-suggs is 0 begin;
     say "[nothing specific]" (A);
     rule succeeds;
  end if;
  let sugg-rep be a text;
  say "[if topic-request is implicit]([end if][We] [could] " (B);
  if other-suggs > 0 begin;
     let sugg-rep be "[sugg-list-other]";
     replace the regular expression "\band\b" in sugg-rep with "or";
     say "[sugg-rep][if tell-suggs + ask-suggs > 0]; or [end if]" (C);
  end if;
  if ask-suggs > 0 begin;
      let sugg-rep be "[sugg-list-ask with definite articles]";
      replace the regular expression "\band\b" in sugg-rep with "or";
      say "ask [regarding the current interlocutor][them] about [sugg-rep][if tell-suggs > 0]; or [end if]" (D);
 end if;
 if tell-suggs > 0 begin;    
     let sugg-rep be "[sugg-list-tell with definite articles]";
     replace the regular expression "\band\b" in sugg-rep with "or";
     say "tell [regarding the current interlocutor][them] about [sugg-rep]" (E);
end if;
say "[if topic-request is implicit].)[otherwise].[end if][paragraph break]" (F).



Part 3 - Automatic Topic Suggestions

carry out saying hello to someone when suggest-on-greeting is true and greeting type is explicit (this is the display topic suggestions on explicit greeting rule) :
  the topic list displays in 0 turns from now.

At the time when the topic list displays:
  Show the topic suggestions implicitly.

To show the/-- topic suggestions implicitly:
    now topic-request is implicit;
    try listing suggested topics;
    now topic-request is explicit.



Conversation Suggestions ends here.

Version 12.0.1 of Conversation Framework by Eric Eve begins here.

"A framework for conversations that allows saying hello and goodbye, abbreviated forms of ask and tell commands for conversing with the current interlocutor, and asking and telling about things as well as topics."

Book 0 - Includes

Include Epistemology by Eric Eve.

Book  1 - Actions for asking and telling about things

Chapter  1 - Action Definitions

Section 1 - New actions and grammar

Requesting it for is an action applying to two visible things.
Imploring it for is an action applying to one visible thing and one topic.

Understand the command "ask" as something new.

Understand "ask [someone] about [text]" as asking it about.

Understand "ask [someone] for [any known thing]" as requesting it for.
Understand "ask [someone] for [text]" as imploring it for.

Quizzing it about is an action applying to two visible things.

Understand "ask [someone] about [any known thing]" as quizzing it about.

Informing it about is an action applying to two visible things.

Understand "tell [someone] about [any known thing]" as informing it about.

Section 2 - Specifications

The specification of the quizzing it about action is "This action responds to commands like ASK FRED ABOUT BOAT, where BOAT is a thing defined in the game, rather than a topic."

The specification of the informing it about action is "This action responds to commands like TELL FRED ABOUT BOAT, where BOAT is a thing defined in the game, rather than a topic."

The specification of the requesting it for action is "This action effectively replaces the library's asking it for action. Like asking it for it matches ASK BOB FOR SOMETHING, but unlike asking it for it makes no assumptions that this is equivalent to BOB, GIVE ME SOMETHING. Instead it can match any object known to the player, and the response can be anything we care to define."

The specification of the imploring it for action is "This action provides handling for ASK SOMEONE ABOUT SOMETHING where SOMETHING is a topic rather than a thing, e.g. ASK BILL FOR ADVICE."


Chapter  2 - Some useful default rules

Report informing someone about something (this is the block informing rule):
  say "[There] [are] no reply." (A).

Report quizzing someone about something (this is the block quizzing rule):
  say "[There] [are] no reply." (A).

Instead of asking a female person about "herself" (this is the asking a woman about herself rule):
  try quizzing the noun about the noun.

Instead of asking a male person about "himself" (this is the asking a man about himself rule):
  try quizzing the noun about the noun.


Book  2 - Abbreviated commands for addressing the current interlocutor

The current interlocutor is an object that varies.
The current interlocutor is nothing.

Implicit-asking is an action applying to one topic.

Understand "ask about [text]" or "a [text]" as implicit-asking.

implicit-telling is an action applying to one topic.

Understand "t [text]" as implicit-telling.

implicit-quizzing is an action applying to one visible thing.
  Understand "ask about [any known thing]" or "a [any known thing]" as implicit-quizzing.

implicit-informing is an action applying to one visible thing.
  Understand "t [any known thing]" or "talk about [any known thing]" as implicit-informing.

implicit-requesting is an action applying to one visible thing.
  Understand "ask for [any known thing]" as implicit-requesting.

implicit-imploring is an action applying to one topic.
  Understand "ask for [text]" as implicit-imploring.

implicit-asking is implicit-conversing. 
implicit-telling is implicit-conversing. 
implicit-quizzing is implicit-conversing. 
implicit-informing is implicit-conversing.
implicit-requesting is implicit-conversing.
implicit-imploring is implicit-conversing.

Before implicit-conversing when the current interlocutor is nothing (this is the implicit-conversing needs current interlocutor rule):
let np be the number of visible people who are not the player;
if np is 0,  say "[There's] no one [here] to talk to." (A);
if np > 1, say "You need to specify who you want to speak to." (B);
if np is not 1, stop the action;
let the interlocutor be a random visible person who is not the player;
 if the interlocutor is a person begin;
   say "(addressing [the interlocutor])" (C);
   let sn be the second noun;
   implicitly greet the interlocutor;
   if the current interlocutor is not the interlocutor, stop the action; 
   now the second noun is sn;
 otherwise ;
  say "[We] [aren't] talking to anyone." (D);
  stop the action;
end if.

Before implicit-conversing when the current interlocutor is not visible and the current interlocutor is not nothing  (this is the can't converse with absent interlocutor rule):
  say "[The current interlocutor] [aren't] [here]." (A);
  reset the interlocutor instead.

Instead of implicit-asking:
  try asking the current interlocutor about it.

Instead of implicit-telling:
  try telling the current interlocutor about it.

Instead of implicit-quizzing:
  try quizzing the current interlocutor about the noun.

Instead of implicit-informing:
  try informing the current interlocutor about the noun.

Instead of implicit-requesting:
  try requesting the current interlocutor for the noun.

Instead of implicit-imploring:
  try imploring the current interlocutor for it.

[
After reading a command when the player's command matches "a [thing]" and the current interlocutor is not a person:
  if the number of visible people who are not the player > 1 begin;
     say "Whom do you want to ask?";
     reject the player's command;
  end if.
]

Book 3 - Greeting Protocols

Chapter 0 - New Verbs

To say is a verb. 

Chapter 1 - Greeting Definitions

Asking someone about something is conversing.
Telling someone about something is conversing.
Quizzing someone about something is conversing.
Informing someone about something is conversing.
Answering someone that something is conversing.
Asking someone for something is conversing.
Requesting someone for something is conversing.
Imploring someone for something is conversing.

Asking someone about something is speaking.
Telling someone about something is speaking.
Quizzing someone about something is speaking.
Informing someone about something is speaking.
Answering someone that something is speaking.
Asking someone for something is speaking.
Requesting someone for something is speaking.
Imploring someone for something is speaking.


Saying yes is speaking.
Saying no is speaking.
Saying sorry is speaking.


Chapter  2 - Greeting


Before conversing when the noun is not the current interlocutor (this is the greet a new interlocutor rule):
  implicitly greet the noun;
  if the noun is not the current interlocutor, stop the action.

Before showing something to someone when the second noun is not the current interlocutor (this is the showing needs an interlocutor rule):        
  implicitly greet the second noun;
  if the second noun is not the current interlocutor,  stop the action.
 
Before giving something to someone when the second noun is not the current interlocutor (this is the giving needs an interlocutor rule):
  if the current interlocutor is not a person, abide by the implicit-conversing needs current interlocutor rule;
  implicitly greet the second noun;
  if the second noun is not the current interlocutor, stop the action.

Before asking someone to try doing something when the person asked is not the current interlocutor (this is the giving orders needs an interlocutor rule):
  implicitly greet the person asked;
  if the person asked is not the current interlocutor, stop the action.

To implicitly greet (character - a thing):
  now the greeting type is implicit;
  try saying hello to the character.


Saying hello to is an action applying to one visible thing.

Understand "greet [something]" or "say hello/hi to [something]" or "talk to [something]" as saying hello to.

Check saying hello to a person when the noun is the current interlocutor (this is the can't greet current interlocutor rule):
    if the noun is the player, say "Talking to [ourselves] [regarding nothing][are] unrewarding." (A) instead;
    say "[We] [are] already talking to [the noun]." (B) instead.

Check saying hello to the player (this is the can't greet yourself rule):
   say "Talking to [ourselves] [regarding nothing][are] likely to prove unrewarding." (A) instead.

Carry out saying hello to a person (this is the note current interlocutor when greeted rule):
  now the current interlocutor is the noun.

Report saying hello to something that is not a person (this is the can't greet inanimate objects rule):
  say "[The noun] [do not] respond."

Report saying hello to someone when the greeting type is explicit (this is the default greeting rule):
  say "[We] [say] hello to [the noun]." (A).

Hailing is an action applying to nothing.

Understand "hello" or "hi" or "say hello/hi" as hailing.

Before asking someone to try hailing (this is the change greeting command to greeting rule):  
  now the greeting type is explicit;
  try saying hello to the person asked;
  rule succeeds.

The change greeting command to greeting rule is listed before the giving orders needs an interlocutor rule in the before rules.

Check hailing (this is the check what's being hailed rule):
  if the current interlocutor is a visible person, 
    say "[We] [are] already talking to [the current interlocutor]." (A) instead;
  now the noun is a random visible person who is not the player;
  if the noun is a person and the noun is not yourself and the noun is not the player,  
    say "(addressing [the noun])" (B);
  otherwise say "[There's] no one [here] but [us]." instead.

Carry out hailing (this is the standard hailing rule):
  try saying hello to the noun.
  

Persuasion rule for asking people to try hailing (this is the allow hailing rule): persuasion succeeds.

A protocol type is a kind of value. The protocol types are implicit and explicit.

Greeting type is a protocol type that varies. Greeting type is explicit.

When play begins: reset the interlocutor.

Chapter 2  - Saying Goodbye

Farewell type is a protocol type that varies. Farewell type is explicit.

[ This is the only way I could figure to effectively change the current interlocutor to no one]

To reset the interlocutor:
  now the current interlocutor is nothing. [a random person who is not a person]

Leavetaking is an action applying to nothing.

Understand "bye" or "goodbye" or "cheerio" or "farewell" as leavetaking.

Saying goodbye to is an action applying to one visible thing.

Understand "say bye/goodbye/farewell/cheerio to [someone]" as saying goodbye to.

Check saying goodbye to something when the noun is not the current interlocutor (this is the can't say goodbye to someone you're not talking to rule):
  say "[We] [aren't] talking to [the noun]." (A) instead.

Carry out saying goodbye to something (this is the reset interlocutor on saying goodbye rule):   
  reset the interlocutor.

Check leavetaking when the current interlocutor is not a visible person (this is the don't allow saying goodbye to no-one rule):
  say "[We] [aren't] talking to anyone." (A) instead.

Carry out leavetaking (this is the standard leavetaking rule):
  try saying goodbye to the current interlocutor.

Persuasion rule for asking people to try leavetaking (this is the alllow leavetaking rule): persuasion succeeds.

Carry out someone trying leavetaking (this is the convert npc leavetaking to player leavetaking rule):
  try saying goodbye to the person asked.

Report saying goodbye to someone when the farewell type is explicit (this is the default saying goodbye rule):
   say "[We] [say] goodbye to [the noun]."

This is the say goodbye when moving rule:
    if the current interlocutor is a person enclosed by the location begin;
        now the farewell type is implicit;
        try saying goodbye to the current interlocutor;
   end if.


The say goodbye when moving rule is listed first in the carry out going rules.


[
Before going from somewhere when the current interlocutor is a person in the location (this is the say goodbye when moving rule):
  change the farewell type to implicit;
  try saying goodbye to the current interlocutor.  

The say goodbye when moving rule is listed first in the before rules.
]

Chapter 3 - Reset protocol each turn

Every turn (this is the reset protocol rule):
  now the farewell type is explicit;
  now the greeting type is explicit.

Book 4 - Yes, No and Sorry

saying yes is implicit-conversing.
saying no is implicit-conversing.
saying sorry is implicit-conversing.

Before asking someone to try saying yes (this is the greet before saying yes rule):
  if the person asked is not the current interlocutor, implicitly greet the person asked;
  try saying yes instead.

Before asking someone to try saying no (this is the greet before saying no rule):
  if the person asked is not the current interlocutor, implicitly greet the person asked;
  try saying no instead.

Before asking someone to try saying sorry (this is the greet before saying sorry rule):
  if the person asked is not the current interlocutor, implicitly greet the person asked;
  try saying sorry instead.

Before answering someone that "yes" (this is the change answering yes to saying yes rule):
  try saying yes instead.

Before answering someone that "no" (this is the change answering no to saying no rule):
  try saying no instead.

Before answering someone that "sorry" (this is the change answering sorry to saying sorry rule):
  try asking the noun to try saying sorry instead.

Understand "tell [someone] [text]" as answering it that. Understand "tell [someone] that [text]" as answering it that.


Book 4 - Limiting what can be spoken about

Check quizzing someone about something unknown (this is the block asking about something unknown rule):
  abide by the block asking rule.

Check informing someone about something unknown (this is the block telling about something unknown rule):
  abide by the block telling rule.

To say make (obj - a thing) known/familiar:
  now obj is familiar.


Conversation Framework ends here.


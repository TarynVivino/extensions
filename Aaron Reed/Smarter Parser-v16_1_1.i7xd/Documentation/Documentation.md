
Chapter: Introduction

Newcomers to IF can be frustrated by the standard parser, which offers little instruction and is fairly rigid about the type of input it will accept. After one or two confusing errors, many new players will just give up. This extension responds to various common forms of misunderstood input tried by new players, as seen in hundreds of example transcripts collected by many IF authors over the years, and both offers more helpful responses as well as retrying some commands in a more standard form, teaching the player correct syntax as it goes.

Section: Installation and Use

Smarter Parser is triggered only when a parser error is about to be printed; that is, when the parser has given up trying to understand the player's command. After standardizing the misunderstood input to simplify pattern matching, it looks through all the rules in a new rulebook, the Smarter Parser rules. Depending on the result of a rule, a command can be rejected with a better error message, or changed into a better form and re-parsed.

Since Smarter Parser only interferes when parsing has failed, you shouldn't normally have to worry about it interfering with your own nouns or verbs. For instance, while Smarter Parser will respond helpfully to >HINT, if you create your own "hint" command, it will take precedence over Smarter Parser. However, since Smarter Parser will still fire if the player misuses your command in a way that causes it not to be parsed (by typing >HINT CASTLE, for instance, if your command expects only HINT) you should review the Smarter Parser rules below and modify the output or delist rules that could hinder rather than help your own implementation.

Section: Quick Tips

If your story includes any of the following, you'll probably want to take a look at the listed rules as a starting point:

	conversation
		the failed communication attempts rule
	
	nonstandard movement or an "exits" command
		the where can i go rule
		the where am i rule
		the unnecessary movement rule
		
	new verbs requiring you to do something "with" something else
		the stripping failed with rule
		
	a characterized narrator or parser
		the asking who are you rule (at a minimum)

	any questions-based commands (who, what, where, etc)
		the asking unparseable questions rule
		
	nouns involving possessives, like "Bob's nose"
		the unnecessary possessives rule

Section: Testing

In an unreleased story, you can type PARSER to start showing the names of  matched Smarter Parser rules. You can look up a rule in this documentation  to see how to change or remove it.

Section: Configuration

Experienced players can type NOVICE OFF to disable Smarter Parser completely, which will improve speed on slower platforms, or CORRECT OFF to turn off automatic reparsing of commands (instead, the extension recommends a correction but does not actually submit it). These commands (along with UNDO) are introduced the first time the extension kicks in. If the target platform supports file i/o, this configuration is saved to disk and will be honored across projects using version 15 of Smarter Parser or newer if they're run locally from the same directory.

Authors can also disable corrections or Smarter Parsing entirely, perhaps temporarily for a certain sequence or permanently after the player has advanced past an introductory sequence, with the following phrases:

	now corrections enabled is false
	now novice mode enabled is false
	
Section: Style

Smarter Parser messages can easily be styled differently than normal messages by adding before and after formatting instructions to the "as the parser" and "as normal" say phrases. For instance, to make Smarter Parser messages appear in italics:

	To say as the parser: say italic type.
	To say as normal: say roman type.

Chapter: The Rules

Section: Blank Lines

Novice players often press enter at a blank prompt, which normally shows the message "I beg your pardon?" Under the theory that players probably do this when they're not sure what to do next, Smarter Parser maps blank lines to LOOK, to get a fresh description of the surroundings. You can change the command to any string:

	The blank line replacement is "wait".

...or restore the default behavior:

	{*}Use normal blank lines.
	
Section: Lonely Nouns

If a player types just a noun, as in >SWORD, we treat this like >EXAMINE SWORD.

To remove:

	{*}Use normal lonely noun behavior.

Section: the stripping punctuation rule

This rule tries to remove extraneous punctuation marks from the player's input, successfully parsing commands like >WAIT? or >(LISTEN) . It prints no message.

To remove:

	{*}The stripping punctuation rule is not listed in the Smarter Parser rulebook.
	
Section: the simplify contractions rule

To make pattern matching simpler in later rules, this changes things like I'LL to I WILL. It prints no message.

To remove (although note that this will cause some later rules to not recognize contractions):

	{*}The simplify contractions rule is not listed in the Smarter Parser rulebook.
	
Section: the Standardize can verbs rule

Similarly, this replaces CAN, WOULD, WILL, SHOULD, MAY, DO, and LIKE TO with _CAN. This special word simplifies later pattern matching. It prints no message.

To remove (although note that this will break several later rules):

	{*}The standardize can verbs rule is not listed in the Smarter Parser rulebook.

Section: the where can I go rule

Tries to help players who seem to be trying to find where the exits are, matching commands like >WHICH WAY IS OUT or >CAN I LEAVE. To change the message it prints, paste the code block below and adjust the quoted text accordingly.

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	where can I go rule	"[as the parser]Movement is usually by compass direction. Typing LOOK is a good way to get oriented.[as normal]"
	
To remove:

	{*}The where can I go rule is not listed in the Smarter Parser rulebook.
	
Section: the signs of confusion rule

Looks for patterns indicating player confusion or frustration, including >I DON'T KNOW..., >WTF, >SO CONFUSED, >HUH??, >INFO, >HOW DO I..., >ACTIONS, and several others. To change the parser message:

	{*}Table of Smarter Parser Messages (continued)
	rule name		message
	signs of confusion rule		"[as the parser]Try typing LOOK for a description of your surroundings. Any directions indicate exits which you can use by typing [get direction example]. Some of the objects mentioned in the description might be worth a closer look with a command like EXAMINE [get noun example]. You can also TAKE or DROP some things, type INVENTORY to see a list of what you're carrying already, OPEN or CLOSE containers or doors, and so on.[as normal]"
	
To remove:

	{*}The signs of confusion rule is not listed in the Smarter Parser rulebook.

Section: The stripping niceties rule

Removes the phrases PLEASE or CAN I (and variants) and reparses the command. To change the parser message:

	{*}Table of Smarter Parser Messages (continued)
	rule name		message
	stripping niceties rule		"[as the parser]You can just state your commands directly.[as normal]"
	
To remove:

	{*}The stripping niceties rule is not listed in the Smarter Parser rulebook.

Section: The stripping interjections rule

Removes interjections to successfully parse colorful commands like >GET THE DAMN JAR or >WHERE IN THE HELL AM I and reparses without showing an error message. If this reduces the command to one or no words, don't reparse and show the message below. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name		message
	stripping interjections rule		"[as the parser]I think your command included an interjection, but I couldn't understand it. Try stating your intention more directly.[as normal]"

To remove:

	{*}The stripping interjections rule is not listed in the Smarter Parser rulebook.

Section: The standardize be verbs rule

Replaces words like AM, WAS, WERE, HAVE BEEN with _BE, to simplify later pattern matching.

To remove (although note that this will break several later rules):

	{*}The standardize be verbs rule is not listed in the Smarter Parser rulebook.
	
Section: the asking who are you rule

Responds to players trying to address the parser or narrator with commands like >WHO ARE YOU, >WHO'S SPEAKING, >WHO AM I TALKING TO, and so on. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	asking who are you rule	"[as the parser]I'm the parser-- I translate what you type into actions your character takes in the story world. Use imperative commands like LOOK, GET [get noun example], or GO [get direction example] to advance the story. Try typing [default help command in upper case] for more information.[as normal]"
	
To remove:

	{*}The asking who are you rule is not listed in the Smarter Parser rulebook.

Section: the asking who am I rule

Answers the question >WHO AM I? with an explanation and a reparsing as >EXAMINE ME. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	asking who am i rule	"[as the parser]You are a character in this story. Normally, you'll want to phrase your input as commands, not questions.[if corrections enabled is true] I've taken the liberty of demonstrating below.[end if][as normal]"
	
To remove:

	{*}The asking who am I rule is not listed in the Smarter Parser rulebook.
	
Section: the asking where am I rule

Answers the question >WHERE AM I or attempts to examine the location (>LOOK AROUND, >EXAMINE ROOM, >SEARCH LOCATION, >WHAT'S IN THE AREA) with a pointer towards >LOOK. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	asking where am i rule	"[as the parser]To get a description of your surroundings, try typing LOOK.[as normal]"
	
To remove:

	{*}The asking where am I rule is not listed in the Smarter Parser rulebook.

Section: the stripping verbose intro rule

Reparses commands that contain an unnecessary introduction, such as >I GO NORTH, >CAN WE TAKE THE BALL, >LET'S WAIT, >I WANT TO ATTACK, and so on. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	stripping verbose intro rule	"[as the parser]You can just begin your command with the verb.[as normal]"
	
To remove:

	{*}The stripping verbose intro rule is not listed in the Smarter Parser rulebook.

Section: the asking unparseable questions rule

Rejects commands that look like questions: anything starting with WHO, WHAT, WHERE, WHY, WHICH, HOW, or variants on CAN I. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	asking unparseable questions rule	"[as the parser]You can't ask direct questions to the game. Type a verb - noun command like EXAMINE [get noun example] to interact with the story world, or LOOK to get a description of your surroundings.[as normal]"
	
To remove:

	{*}The asking unparseable questions rule is not listed in the Smarter Parser rulebook.
	
Section: the stripping adverbs rule

Reparses the player's command after removing some of the most commonly tried adverbs, including SLOWLY, CAREFULLY, QUICKLY, QUIETLY, and LOUDLY. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	stripping adverbs rule	"[as the parser]Adverbs are not usually necessary in interactive fiction.[as normal]"

To remove:

	{*}The stripping adverbs rule is not listed in the Smarter Parser rulebook.

Section: the making assertions rule

Rejects commands that look like assertion statements, such as anything starting with I, HE, SHE, IT, THIS, YOU, or YOUR. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	making assertions rule	"[as the parser]Please rephrase your command to start with an imperative verb, like LOOK.[as normal]"
	
To remove:

	{*}The making assertions rule is not listed in the Smarter Parser rulebook.

Section: the unnecessary movement rule

Rejects a wide variety of commands that look like attempts to move within a single room, one of the most common newbie moves in IF, with a mini-tutorial message. Commands matched include those starting with phrases like >GO OVER TO, >MOVE AWAY FROM, >STAND NEXT TO, >GET IN FRONT OF, >WALK UP TO, etcetera. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name		message
	unnecessary movement rule		"[as the parser]If you can see an object, you can usually just interact with it directly without worrying about your position[if player is enclosed by something] (although since you're in or on something, you may need to type EXIT first)[end if]. Try a command like EXAMINE [get noun example] for a closer look at something[if the number of sp_viable directions is at least 1], LOOK to get a new description of this location, or a direction like [get direction example] to move to a different location.[otherwise], or LOOK to show the description of this location again.[as normal]"

To remove:

	{*}The unnecessary movement rule is not listed in the Smarter Parser rulebook.

Section: the stripping vague words rule

Rejects commands containing vague words like SOMEONE, ANYWHERE, NOBODY, or EVERYTHING. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	stripping vague words rule	"[as the parser]You will need to be more specific. Try typing LOOK to get a description of your surroundings.[as normal]"

To remove:

	{*}The stripping vague words rule is not listed in the Smarter Parser rulebook.

Section: the stripping pointless words rule

Rejects commands containing hedges like ANYWAY, ALMOST, SO, or JUST, as well as generally meaningless sequential or quantitative words like NOW, NEXT, or MORE, and reparses the command if any words remain, otherwise rejecting it. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	stripping pointless words rule	"[as the parser]Most connecting and comparative words are not necessary.[as normal]"

To remove:

	{*}The stripping pointless words rule is not listed in the Smarter Parser rulebook.

Section: the stripping failed with rule

Reparses commands that contain unnecessary addenda like >ATTACK MONSTER WITH MY SWORD, >GO NORTH BY THE PATH, >TOUCH ROCK USING MY FINGERTIP, and so on. (Everything from the "with" word on is stripped.) If your story includes a command that legitimately uses "with," you may want to change the message to account for this, or remove this rule altogether. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	stripping failed with rule	"[as the parser]You don't always need to specify what you're doing something with.[as normal]"
	
To remove:

	{*}The stripping failed with rule is not listed in the Smarter Parser rulebook.
	
Section: the gerunds rule

If the input contains the gerund form of several common IF commands, such as LOOKING, GOING, PUSHING, etc., strips the "ing" and reparses. Most useful in conjunction with other rules; i.e. along with "stripping pointless words" allows a command like >TRY WAITING to be successfully understood. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	no gerunds rule	"[as the parser]Use verbs in present tense command form.[as normal]"
	
To remove:

	{*}The gerunds rule is not listed in the Smarter Parser rulebook.

Section: the unnecessary possessives rule

If the player's command includes an interior unrecognized word that ends with an apostrophe s, strip the word and reparse. This works because the interior word is most likely to be a possessive in a command like >GET BOB'S JACKET; if the story doesn't recognize the word BOB'S, we can assume this isn't going to be a helpful disambiguation word and try just >GET JACKET instead. We limit our search to interior words to exclude different contexts like >BOB'S A JERK or >GET APPLE'S. This rule prints no message.

To remove:

	{*}The unnecessary possessives rule is not listed in the Smarter Parser rulebook.

Section: the understood as far as rule

If the parser understood the player's command up to a certain point, and the words before that point look like a standard IF command, try stripping the excess and reparsing. This lets commands like >TAKE BALL I SUPPOSE, >LOOK AROUND THE ROOM, or >KILL THE TROLL IN TERROR work. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name		message
	stripping unnecessary addendum rule		"[as the parser]I only understood the first part of that[if corrections enabled is true]-- trying anyway[end if].[as normal]"

To remove:

	{*}The understood as far as rule is not listed in the Smarter Parser rulebook.
	
Section: the failed communication attempts rule

If a person is near the player and they typed one of several common greeting words, including HELLO, HI, GREET, SPEAK..., etc., reject the command and print a message pointing towards correct conversation commands. Note that if your story includes a conversation system, you will almost certainly want to replace this message with something customized for your game, or remove the rule entirely. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name	message
	failed communication attempts rule	"[as the parser]If you're trying to talk to someone, you might try ASK [get person example] ABOUT something, the traditional conversation syntax. Type [default help command in upper case] to see if this story offers more detailed instructions for conversation.[as normal]"
	
To remove:

	{*}The failed communication attempts rule is not listed in the Smarter Parser rulebook.

Section: the too many words rule

If none of the previous rules have matched and the player's command has more than six words, reject it with a tip to try shorter commands. To change the message:

	{*}Table of Smarter Parser Messages (continued)
	rule name		message
	too many words rule		"[as the parser]You typed a rather long command and I didn't understand it. It's better to stick to simpler things like TAKE [get noun example].[as normal]"
	
To remove:

	{*}The too many words rule is not listed in the Smarter Parser rulebook.


Chapter: Advanced Features

Section: Changing how reparsing is presented to the player

To change the text used to frame reparsed commands, and the notifications the first time auto-corrections and a smarter parser message are seen, just redefine one of the following phrases in your own source (the text shown here is the default behavior):
	
	To display the active corrections introduction:
		say "[line break][as the parser]Retrying as:[as normal][line break]";
	
	To display the inactive corrections introduction:
		say "[as the parser]You might try:[as normal] ".
	
	To display the corrections instructions:
		say "[paragraph break][as the parser]Type UNDO if this isn't what you wanted to do, or CORRECT OFF to stop automatically correcting commands.[as normal]";

	To display the novice instructions:
		say "[line break][as the parser]To stop these messages entirely, type NOVICE OFF.[as normal]".
	
More utilitarian but also available to be replaced if necessary:
	
	To display the rule explanation (explanation - a text):
		say "[explanation][command clarification break]".

	To display the reborn command:
		say ">[reborn command in upper case]".

Section: Default Examples

A number of the built-in messages need examples of things, people, or directions. Some effort is made to find sensible options from the nearby environment, but if nothing matches, the extension uses default fallbacks, which can be changed thusly (again, the defaults are below):

	The default noun example is "flower".
	The default person example is "John".
	The default direction example is north.
	
Several instructional messages encourage the player to type the standard ABOUT to get more help or information about the game. (If your game doesn't have an ABOUT command, Smarter Parser will print some generic instructional text if the player tries it.) You can change the referenced command if your game provides something different:

	The default help command is "hint".
	
Section: Making your own rules

You can add new Smarter Parser rules to match additional patterns of misunderstood input. Smarter Parser uses regular expressions on the indexed text variable "the rejected command" to match patterns. The "Advanced Text" chapter of the Inform docs has a good primer on how to use regular expressions if you're not familiar with them.

Smarter Parser rules can optionally modify a second indexed text, "the reborn command," and can have one of four outcomes:

	reparse the command (success)
	reparse the command without an explanation (success)
	reject the command (failure)
	no match (default)

If there is no match, the next rule in the rulebook will be checked, and so on. If no Smarter Parser rules match, responsibility for printing an error returns to the default parser, as if Smarter Parser hadn't run.

For any of the non-default outcomes, however, the rule must first call the phrase:

	identify error as (the name of the matching rule)

In all cases except "without an explanation," the extension looks up the identified rule in the Table of Smarter Parser Messages, which has two columns, "rule name" and "message," and display the associated text to explain the nature of the problem. Stylistically, Smarter Parser messages should not just explain what went wrong, but try to suggest a better command or explain something about the IF world model that will lead the player towards more helpful input in the future. It's legal to have no matching error message, in which case nothing is printed.

With the two "reparse the command" outcomes, and if "corrections enabled" is true, the extension next takes the value of "the reborn command" and starts parsing over again as if the player had typed that command. The "without an explanation" variant will do so without printing an explanation, which is useful for very straightforward or obvious corrections such as misplaced punctuation.

Here's an example of a Smarter Parser rule that rejects a command:

	A smarter parser rule (this is the signs of frustration rule):
		if the rejected command matches the regular expression "(stupid|hate|dumb|boring|wtf)":
			identify error as signs of frustration rule;
			reject the command.
			
	Table of Smarter Parser Messages (continued)
	rule name						message
	signs of frustration rule	"[as the parser]You know, there's a HINT command available...[as normal]"

And here's one that reparses:

	A smarter parser rule (this is the stripping formal address rule):
		if the rejected command matches the regular expression "(sir|ma'am)":
			replace the regular expression text matching subexpression 1 in the reborn command with "";
			identify error as stripping formal address rule;
			reparse the command.
			
	Table of Smarter Parser Messages (continued)
	rule name						message
	stripping formal address rule	"[as the parser]There's no need to be overly polite.[as normal]"
	
Section: Shortcuts for new rules

There are a few built-in phrases to streamline common patterns in making Smarter Parser rules. One of these is checking whether a pattern matches, and if so, removing it from the player's command. This can be done with the "stripping (regex) is fruitful" phrase. The "stripping formal address rule" example above could be rewritten like this:

	A smarter parser rule (this is the stripping formal address rule):
		if stripping "(sir|ma'am)" is fruitful:
			identify error as stripping formal address rule;
			reparse the command.
	
By default these phrases all stop at word boundaries, so the above would not match on the word "sirrah." We can override this, or restrict the search to only match the beginning of the rejected command, with these two phrase variants:

	if stripping "regex" is fruitful, even within words
	if stripping "regex" is fruitful, only from the beginning

Similarly, we can check if the rejected command contains a certain regular expression (without modifying the command) with this shortcut phrase and variants:

	if input contains "regex"
	if input starts with "regex"
	if input ends with "regex"
	
We can also add the ", even within words" suffix to any of these three phrases to search across word boundaries.

Finally, there's a much faster alternate version of the "input starts with" phrase that works if you're just looking to match individual words at the start of a command and don't need any complex regular expression handling. This is:
	
	if input simple starts with "word"
	if input simple starts with "(one|of|these|words)"

Smarter Parser rules are checked in the order defined in the source, meaning any new ones you define will come at the end of the built-in set. You can use the standard rule reordering syntax to adjust this:

	The stripping formal address rule is listed before the stripping pointless words rule in the Smarter Parser rules.

A final note: checking regular expressions is slow, so adding rules ad infinitum is not necessarily a good idea. The slowdown only happens when the player types misunderstood input, but keep in mind this might be rather frequent for new players, many of whom may be playing your story on a slow interpreter such as a Javascript-based web environment.

Chapter: Miscellany

Section: No default rules

You can remove all of the built-in rules by adding the use option:

	Use empty Smarter Parser rulebook.

Section: Overriding player preferences

If an author is doing something unique with Smarter Parser and wants to override player preferences saved in an external file, she can simply use a "when play begins" rule to set "corrections enabled" or "novice mode enabled" to the desired boolean value.
	
Section: Compatibility

Smarter Parser replaces the I6 Keyboard routine to allow for blank line replacement, which may create compatibility issues with other extensions that replace this routine (such as Undo Output Control by Erik Temple). If you don't want to replace Keyboard, you can fall back on a simpler implementation for dealing with blank lines by adding an empty section replacing the relevant code:

	Section - revert to simple blank lines (in place of Section - Nothing Entered Advanced Version in Smarter Parser by Aaron Reed)
	
The simpler version can't have a custom verb (it always LOOKs) and acts like an out-of-world command (time doesn't pass).

Section: Bugs

The author is constantly striving to improve this extension. If you have any problems with Smarter Parser or suggestions for future improvement, please contact me at my gmail account, aareed, or on the intfiction.org forum.


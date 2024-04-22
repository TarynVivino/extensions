Section: THE BASICS

Conversation Rules builds on Conversation Framework, List Control and Epistemology (which it uses, and which therefore must be present for it to use) to provide a sophisticated (and fairly complex) means of handling conversations of the ASK/TELL type. It can also suggest to the player which topics are available to be asked about and told about. Finally, it allows the use of Conversation Nodes --  points in a conversation when the player can types responses outside the normal ask/tell paradigm in reply to a question or comment by the NPC. (If this all sounds a bit like the TADS 3 conversation system, there is a reason for that; I originally developed this extension in the course of porting part of a TADS 3 game to Inform 7).

The first point to bear in mind about Conversation Rules is that it supports asking and telling NPCs about things rather than topics; that is it uses the quizzing it about and informing it about actions defined in Conversation Framework (the documentation of which should also be consulted at this point if it is not already familiar), rather than the standard asking it about and telling it about actions that come with Inform 7. That doesn't mean that we can't use asking it about (a topic) and telling it about (a topic) with Conversation Rules; it's just that Conversation Rules provides no additional support for these actions. Instead, it provides support for quizzing and informing NPCs about things (which may include things or subjects -- for which see the Epistemology documentation -- used to represent abstract ideas like love, liberty or the rate of inflation).

Within Conversation Rules each NPC's responses to being quizzed about or informed about something is controlled through a pair of tables we need to define for the purpose: the NPC's quizzing table and informing table. Thus we might define:

	Bob is a man. The quizzing table is The Table of Bob's Quizzes. The informing table is The Table of Bob's Informs.

We then need to supply these tables, which take the form:

	Table of Bob's Quizzes
	subject		response rule			response table	suggest
	bob		bob himself rule			--		1

This will cause the bob himself rule to be invoked in response to the command ASK BOB ABOUT BOB or ASK BOB ABOUT HIMSELF. It will also cause 'you could ask Bob about himself' to be suggested as a possible topic of conversation with Bob, until we had actually asked him about himself for the first time. If we didn't want this to appear as a suggested topic we could put a 0 in the suggest column (or leave it blank). If we wanted it to be suggested more than once, we would put the number of times Bob could be asked about himself before this ceased to be suggested in the suggest column.

Obviously, we also need to provide an appropriate bob himself rule, for example:

	This is the bob himself rule:
	say "'How are you today, Bob?' you enquire.

	'Fine, just fine,' he replies."

If Bob's responses varied according to circumstances, we could write a more complex rule, or else use a rulebook to decide Bob's response:

	Table of Bob's Quizzes
	subject		response rule			response table	suggest
	Fred		bob fred rules			--		3


	The bob fred rules is a rulebook.

	A bob fred rule when fred is unseen:
			say "Who is Fred anyway?' you ask.

	'He's my cousin,' Bob tells you."

	A bob fred rule when fred is seen:
	say "'Fred looks quite ill, don't you think?' you remark.

	'Yes - he contracted Dutch Elm Disease last week,' Bob tells you."

A common situation is where we want an NPC to run through a list of responses, supplying a new one each time he is asked until the last is reached, or maybe supplying a random one drawn from a list of possible responses on each occasion. The extension List Control, which Conversation Rules uses, provides a mechanism for running through such a list, while Conversation Rule provides a means of getting the next response from such a list automatically, instead of of explicitly having to write a rule to do it. Just put the name of the table containing the list of responses in the appropriate response table column, e.g.:

	Table of Bob's Quizzes
	subject		response rule			response table		suggest
	bob		--				Table of Bob Himself	3


	Table of Bob Himself
	response
	"'How are you today?' you ask.

	'Fine, just fine,' he assures you."
	"'Are you sure you're all right, Bob?' you enquire, 'you look a bit off colour.'

	'I'm absolutely fine,' he insists."
	"Are you absolutely sure you're all right?' you ask.

	'How many times do I have to tell you?' he snaps, 'I'm completely all right!'"

	Table of Table Types (continued)
	tabname		index	tabtype
	Table of Bob Himself	0	stop-list

See the List Control documentation for an explanation of how the above two tables work. It is, by the way, perfectly legal to include both a rule and table name in the same row, in which case the rule will be executed before the next response from the table is shown. This may be useful if, say, we want quizzing someone about something to have a side effect in addition to the display of a conversational exchange.


Section: DEFAULT RESPONSES

We next need a means of having our NPC respond to things we haven't explicitly provided for. Two rules are provided for this, the NPC's unknown quizzing rule and the NPC's unknown informing rule, which by default are set to the no response rule (which in turn simply says that there's no response). To customize this, we need to change these rules to something different; e.g.

	The unknown quizzing rule of Bob is the Bob no quiz rule. The unknown informing rule of Bob is the Bob no inform rule.

	This is the Bob no quiz rule: say "Bob scratches his head and looks puzzled by your question."

	This is the Bob no inform rule: say "Bob listens to what you have to say, but merely grunts in reply."

Of course, these rules could be more elaborate; we might, for example, want Bob's response to be a random response from a selection of defaults:

	This is the Bob no quiz rule: show the next response from the Table of Bob's Default Quiz Responses.

Obviously, we'd then need to define this table (again see the List Control documentation).


Section: CONTROLLING RESPONSE ACCESSIBILITY

A further sophistication is that Conversation Rules makes use of the Epistemology extension, which keeps track of which objects the player knows about. If the player asks an NPC about a thing the player character does not (yet) know about, the default response will be used even if a custom response has been supplied (in the relevant table) for that object. This prevents the player stumbling on something prematurely, or getting a response that presupposes something the player character does not know about (i.e. a thing which is still unfamiliar and unseen, as defined by the Epistemology extension). For example, suppose the PC doesn't know that Bob has a cousin called Fred until Bob mentions the fact in conversation; we could write:

	Table of Bob's Quizzes
	subject		response rule			response table		suggest
	bob		--				Table of Bob Himself	2
	fred		bob-fred rule			--			1


	Table of Bob Himself
	response
	"'How are you today, Bob?' you ask.

	'Better than my cousin Fred, at any rate.' he mutters[reveal Fred]."
	"'How are you doing?' you wonder.
	'Oh I'm doing fine, just fine,' he assures you."

	This is the bob-fred rule:
	say "'What's the matter with your cousin Fred?' you ask.

	'He's suffering an acute attack of Dutch Elm Disease,' he tells you."

Now if we type ASK BOB ABOUT FRED before asking Bob about himself for the first time, we'll only get Bob's default response. The special tag "[reveal Fred]" changes Fred from unfamiliar to familiar (it's a to say rule that doesn't actually say anything), so that we can ask Bob (or anyone else) about Fred thereafter. Note that the 'To reveal X' rule is built into the Conversation Rules extension; it's not something we need to supply in our game code.

This mechanism is fine for stopping the player character talking about things that aren't yet known to him or her, but there may be other reasons why we want to make a response temoparily unreachable, e.g because the NPC doesn't know about it yet, or it doesn't make sense to talk about it with this particular NPC until something else has been said. One way to deal with this situation would be to test for the appropriate condition(s) in the relevant response rule, but this may not always be convenient, particularly if we are using a response table to provide the response. Another method we can use is to set the value in the suggest to -1, which makes the topic unavailable (and, of course, not suggested) until the suggest value is changed to something else. Just as we can use "[reveal Fred]" to change Fred to familiar, so we can use "[quiz x to n]" or "[inform x to n]" to change the suggest column corresponding to x to n in the quizzing table or informing table of the current interlocutor (the NPC we're current talking to). So, for example, if it's possible that the player character already knows of the existence of Fred, but we don't want him asking Bob about Fred until Bob has mentioned Fred, we could change the above example to:

	Table of Bob's Quizzes
	subject		response rule			response table		suggest
	bob		--				Table of Bob Himself	2
	fred		bob-fred rule			--			-1


	Table of Bob Himself
	response
	"'How are you today, Bob?' you ask.

	'Better than my cousin Fred, at any rate.' he mutters[quiz Fred to 1]."
	"'How are you doing?' you wonder.
	'Oh I'm doing fine, just fine,' he assures you."


Section: COMBINING ASK AND TELL

Sometimes we want ASK FOO ABOUT BAR to give the same response as TELL FOO ABOUT BAR. If this is always the case for every NPC we can simply write:

	Instead of informing someone about something, try quizzing the noun about the second noun.

We can do something similar if we want this to apply only to a particular NPC:

	Instead of informing Bob about something, try quizzing Bob about the second noun.

Sometimes, however, we may want ASK and TELL to be equivalent only for certain topics. We could cope for this by writing a series of Instead rules:

	Instead of informing Bob about Fred, try asking Bob about Fred.
	Instead of informing Bob about the lighthouse, try asking Bob about the lighthouse.

But this could become a bit tedious and long-winded if we have quite a few topics to redirect like this. An alternative is to use the supplied quiz-inform and inform-quiz rules within the apprropriate table to redirect quizzing to informing or informing to quizzing, e.g.:

	Table of Bob's Informs
	subject		response rule			response table		suggest
	fred		inform-quiz rule			a table-name		0
	lighthouse	inform-quiz rule

It may seem that we could simply have written "bob-fred rule" in the response column to get the same effect, since the same rule would be triggered whether we ASK BOB ABOUT FRED or TELL BOB ABOUT FRED. The problem is that we'd then have to worry about keeping the values in the suggest columns of both tables in sync, and this is a complication best avoided.


Section: CONVERSATION NODES

There may come a point in a conversation when an NPC asks a question or makes a statement to which ASK BOB ABOUT X or TELL BOB ABOUT X would be a clumsy response at best. It may be that a simple yes or no would be better, or it may be that a more elaborate reply is called for. For this type of situation we can use a Conversation Node. Suppose, for example, that Bob asks a question to which the possible answers are YES, NO and I DON'T KNOW. Perhaps the question was "Have you met my cousin Fred?", so we might call our conversation node the bob-fred node:

	The bob-fred node is a Conversation Node.

Next we need to have some means of letting the player know what responses are possible while we're in this node. For this purpose we can set the Conversation Node's suggestions property:

	The bob-fred node is a Conversation Node. The suggestions is "say yes or no, or say that you don't know"

The rule here is that the text in the suggestions property is something that can reasonably follow "You could". In the above example the player would see a prompt like "(You could say yes or no, or say that you don't know."). A further refinement is that a Conversation Node can be limited (the default) or unlimited. If the Conversation Node is limited then the suggestions in its suggestions property are the only suggested conversation topics that will be shown. If it is unlimited then all the other topics currently available for suggestion (i.e. all the quizzing and informing topics with a suggest entry greater than 0 in the appropriate table) will be listed too.

We still need a means for the Conversation Node to respond to the player's special response (in this case yes, no, or don't know). To do this we need to give the Conversation Node a node rule (which in practice will usually be a rulebook):

	The bob-fred-node rules is a rulebook.
	The node rule of the bob-fred node is the bob-fred-node rules.

Then we need to define the appropriate rules for handling the player's possible responses. We'll start by handling the straightforward YES and NO responses:

	A bob-fred-node rule when saying yes:
		say "'Yes, I ran into him the other day,' you say.

	'In that case you know he's not very well.' Bob replies[convnode null-node].";
			rule suceeds.

	A bob-fred-node-rule when saying no:
	say "'No, I didn't even know you had a cousin called Fred,' you reply.

	'Unless he recovers soon, I probably won't for much longer,' he replies darkly[convnode null-node].";
	rule suceeds.

These rules will handle YES or NO or BOB, YES or BOB, NO or SAY YES TO BOB or SAY NO TO BOB (since Conversation Framework, included by Conversation Rules) takes care of converting the other forms to YES and NO respectively). Note that we need to end each rule with "rule succeeds" to prevent fall through to the normal conversation processing (unless, of course, we want to allow this). Not also the "[convnode null-node]", which is used to reset the current conversation node to nothing once we are done with it (this will be explained further below).

Next, we may want a special rule to make Bob insist on an answer if we don't give him one:

	The last bob-fred-node rule:
	say "'I asked you if you'd met my cousin Fred,' Bob reminds you.";
			rule succeeds.

Here we don't include "[convnode null-node]", since we want the current node to remain active when Bob doesn't get a satisfactory reply. If we were instead happy for Bob's question to be ignored (say by the player asking about something else) we'd instead write:

	The last bob-fred-node rule:
	Change the current convnode to the null-node;

This resets the current convnode so that the bob-fred-node rule doesn't stay current once the player has ignored the question that triggered it; we also make sure that this rule doesn't succeed so that we can go on to the ordinary handling of the topic asked about.

This still leaves the question of how we respond to I DON'T KNOW. This is a bit trickier; the first part of the trick is to think of all the ways the player might signal I DON'T KNOW and then wrap them up in an Understand statement:

	Understand "you don't/dont know" or "i don't/dont know" or "don't know" or "dont know" as "[dont know]".

Next we have to make these responses understood as a special action, but only when this conversation node is active. A special wierdly-named Xspcing action (most unlikely to clash with anything else) is provided for the purpose. In this case we'd use it thus:

	Understand "[dont know]" as Xspcing when the current convnode is the bob-fred node.

Then we provide a bob-fred-node rule to respond to this input:

	A bob-fred-node rule when Xspcing:
	if the player's response matches "[dont know]" begin;
		say "[dont know fred].";
				rule succeeds;
	end if.

	A bob-fred-node rule when answering and the topic understood matches "[dont know]":
					say "[dont know fred].";
				rule succeeds;

	To say dont know fred:
		say "'I have met someone called Fred, but I don't know whether he's your cousin,' you reply.
	'He's a tall, thin, bald man with a limp,' Bob tells you, 'anyway -- he's also very sick[convnode null-node].'"

Note that in this case we need the 'when answering' rule to cover the possibility that the player types SAY I DON'T KNOW or the like.

Finally, we need some way to trigger the conversation node. At root, the way to activate a Conversation Node is to make it the current convnode, e.g.:

	Change the current convnode to the bob-fred node.

More normally, though, we'd use a "[convnode whatevernode]" tag inside a text string, e.g.:

	Table of Bob Himself
	response
	"'How are you today, Bob?' you ask.

	'Better than my cousin Fred, at any rate.' he mutters, 'Have you met him?'[quiz Fred to 1][convnode bob-fred node]"
	"'How are you doing?' you wonder.
	'Oh I'm doing fine, just fine,' he assures you."

Not only does "[convnode whatevernode]" change the current convnode from within a text string, it also causes the topics associated with the node to be suggested so that the player can see what responses are available.


Section: SAYING YES AND NO

As mentioned above, Conversation Framework (included by Conversation Rules) takes care of directing the commands WHOEVER, YES and SAY YES TO WHOEVER to a simple YES command (and likewise with NO). In addition commands like FRED, YES or SAY YES TO FRED will trigger an implicit greeting of Fred (for which see the Conversation Framework documentation) if Fred is not already the current interlocutor (actually, most of the work for this is now carried oun by Conversation Framework).


Section: SUGGESTED TOPICS

As noted under section 1 above, Conversation Rules provides a mechanism for showing the player a list of things s/he can ask or tell the current interlocutor about. As already explained, this is managed by entering a number (greater than zero) in the suggest column against the appropriate item in the appropriate table. This number is reduced by one each time the subject is asked about (or told about, as the case may be) until it reaches zero. The number should therefore start at the number of times you want the suggestion to remain active.

Whether the suggestion appears as a suggested tell topic ("You could tell Bob about Fred") or a suggested ask topic ("You could ask Bob about Fred") depends on whether it appears in the NPC's informing table or its quizzing table (again, as described above).

By default, a list of suggested topics is displayed:

1) In response to an explicit TOPICS command typed by the player; and

2) When a Conversation Node is entered via a "[convnode whatevernode]" tag in a text string, and the Conversation Node in question has a suggestions property that is not "blank".

It may be that we would also like to see a list of suggested topics displayed in response to an explict greeting (such as TALK TO BOB, or BOB, HELLO). To do this we need to dd something like (assuming we have elsewhere defined a Table of Bob's Greetings):

	After saying hello to Bob:
	show the next response from the Table of Bob's Greetings;
	if the greeting type is explicit then consider the standard list suggested topics rule.

Note that in this case it is preferable to use 'consider the standard list suggested topics rule' rather than 'try requesting suggested topics', since if the latter is used the turn count will not be advance (requesting suggested topics is an action out of world, since it seems reasonable that it shouldn't consume any game time).


Section: DISAMBIGUATION AND PRIMARY SUBJECTS

Since quizzing about and informing about are actions that potentially apply to all objects defined in our game, there is a danger that trying to converse with someone about something may result in an ungainly disambiguation prompt:

>ASK JIM ABOUT BALL

Which do you mean, the red rubber ball, the ball gown, the masked ball or the ball bearing?

Conversation Rules takes care of this to some extent by preferring subjects that are known about to those that aren't in such contexts, which may help cut down the list (and avoid revealing the existence of something the player isn't meant to know about yet), but this may not be enough to avoid all instances of ungainly disambiguation, especially in the later stages of a game when most things are known about. Conversation Rules offers partial relief in the form of the primary/secondary condition applied to all objects. Other things being equal, Conversation Rules will pick a primary thing in preference to a secondary thing in a context such as this (provided the primary thing is known). So, for example, if we want all conversational references to BALL, not otherwise qualified, to refer to the masked ball, then we could define:

	The masked ball is a primary subject.

The problem is, the masked ball is then the primary meaning of 'ball' for all interlocutors in the game. If little Billy is more likely to be more interested in his red rubber ball, we should have to supply special grammar lines for this particular exception:

	Understand "ask [billy] about [red subber ball]" as quizzing it about.
	Understand "a [red rubber ball]" as quizzing it about when the default interlocutor is Billy.

But it could become quite cumbersome to do this for a lot of subject/interlocutor combinations.


Section: . OTHER FEATURES

Note that Conversation Rules is fully compatible with the greeting protocols defined in Conversation Framework (for which consult the Conversation Framework documentation). To take full advantage of this it may be necessary to write rules for saying hello and goodbye to particular NPCs in addition to the various types of conversation rule described above.

Conversation Rules is also compatible with the abbreviated conversation commands A THIS or T THAT implemented in Conversation Framework.



However assiduous we are in providing conversational responses for things the player may try to tell or ask our NPCs about, we cannot possibly cover them all. Even if one of our NPCs is a banker, it's unlikely that we'll have provided responses to ASK BANKER ABOUT NORTHEN ROCK and ASK BANKER ABOUT LATEST INTEREST RATE CUT and ASK BANKER ABOUT DETAILS OF INTERNET SAVINGS ACCOUNTS. In such cases we need to provide default responses, responses which in practice mean "I have not be programmed to respond to that input" without making our NPCs look too robotic. This extension defines a number of rules and rulebooks to ease the process of defining such default responses. These enable us to write rules of the form:

	default ask response for the banker:
	default answer response for the banker:
	default tell response for the banker:
	default ask-tell response for the banker:
	
	defaullt give response for the banker:
	default show response for the banker:
	default give-show response for the banker:

	default ask-for response for the banker:
	default yes-no response for the banker:

	default response for the banker:

Note that there's a hierarchy here. If we define a default ask response and a default tell response for the banker, we don't need a default ask-tell response since it would then never be reached. Either we define separate a default ask response and default tell response (if we want to handle them differently) or we define a default ask-tell response if we want to use the same default response whether the player typed ASK or TELL. Similarly, we can define separate default give and default show responses for an NPC if we want to handle them differently, or a single default give-show response to handle both GIVE and SHOW.

A slightly subtler point: if we don't define a default answer response for an NPC, a command like ANSWER BANKER THAT FOO  or SAY FOO TO BANKER, will first be handled by our default tell response rule (if we've defined one), or failing that by our default ask-tell response rule (if we've defined one), or failing that by a default response rule.

The default response rule is a catch-all for all the other cases we haven't explicitly defined. If we liked, we could just define a single "default response for banker" rule that handled all conversational commands addressed to the banker for which we haven't defined particular responses.

Note also that these rules effectively kick in at the report stage. This allows us to define our particular responses at the after stage, e.g.:

	after asking banker about "savings accounts":
	"'We offer a very attractive range of savings accounts,' he assures you, 'indeed, we boast the highest interest rates of any bank in the country. Of course, you understand that [italic type]we[roman type] charge [italic type]you[roman type] the interest for looking after your money.'"

	after quizzing banker about Pluto Crat:
	"'You know very well I can't discuss my other clients with you,' he replies sternly, 'bankers have a rigorous code of ethics, you know.'"

	default ask response for the banker:
	"'[one of]This really isn't the best time to discuss that[or]I'd rather not talk about that right now[or]You'll need to make another appointment to discuss that[or]I hardly think that's an appropriate question to ask your bank manager[in random order],' he replies."

An alternative would be to use Conversational Defaults alongside Conversation Responses. Then instead of the above we could write:

	response of banker when asked about "savings accounts":
	"'We offer a very attractive range of savings accounts,' he assures you, 'indeed, we boast the highest interest rates of any bank in the country. Of course, you understand that [italic type]we[roman type] charge [italic type]you[roman type] the interest for looking after your money.'"

	response of banker when asked about Pluto Crat:
	"'You know very well I can't discuss my other clients with you,' he replies sternly, 'bankers have a rigorous code of ethics, you know.'"

	default ask response for the banker:
	"'[one of]This really isn't the best time to discuss that[or]I'd rather not talk about that right now[or]You'll need to make another appointment to discuss that[or]I hardly think that's an appropriate question to ask your bank manager[in random order],' he replies."

The two examples illustrate these two methods further.

One other thing to note: our default answer response for the banker would be reached whenever the player enters the command ASK BANKER ABOUT FOO, when we haven't implemented a response for foo, whether the parser matches "ASK BANKER ABOUT FOO" to the asking it about action or the quizzing it about action. Similarly a default tell response is triggered whether we TELL BANKER ABOUT THING or TELL BANKER ABOUT "TOPIC", and a default ask-for response whether we ASK BANKER FOR THING or ASK BANKER FOR "TOPIC".


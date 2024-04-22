Version 1.0.1 of Speechless by Zed Lopez begins here.

"Make the player unable to speak or interact with others by speech,
and block references to the player being able to speak."

Part define talking

Asking someone about something is talking.
Telling someone about something is talking.
Asking someone for something is talking.
Answering someone that something is talking.

Part don't ask which

For asking which do you mean when the person asked is not the player (this is the don't ask which or whom rule): instead say "[We] [can't] speak." (A).

Part before talking

Before talking (this is the before talking rule): instead say "[We] [can't] speak." (B).

Part implicitly taking 

For implicitly taking something when the person asked is not the player
  (this is the NPCs don't implicitly take rule): instead say "[We] [can't] speak." (C).

[Before trying doing anything when the person asked is not the player]

Part asking someone to do

Persuasion rule for asking people to try doing something
  (this is the unpersuasive rule): instead say "[We] [can't] speak." (D).

Part parser errors

[ Normally "You can only do that to something animate." ]
The parser error internal rule response (M) is "[We] [can't] speak.".

[ Normally "You seem to want to talk to someone, but I can't see whom." ]
The parser error internal rule response (U) is "[We] [can't] speak.".

[ Normally "You can't talk to [the noun]." ]
The parser error internal rule response (V) is "[We] [can't] speak.".

[ Normally "To talk to someone, try 'someone, hello' or some such." ]
The parser error internal rule response (W) is "[We] [can't] speak.".

Part claryfying asking

For clarifying the parser's choice of something when the person asked is not the player
  (this is the lack of clarification rule): do nothing.

Part block vaguely

[ gus, go ]
The block vaguely going rule does nothing when the person asked is not the player.

Part lack of instruction

For issuing the response text of the action processing internal rule response (K) when the person asked is not the player (this is the lack of instruction rule):
    instead say "[We] [can't] speak.[no line break]" (E).

Part don't ask

For issuing the response text of The parser clarification internal rule response (D) when the person asked is not the player
  (this is the don't ask whom we want the npc to do something to rule): instead say "[We] [can't] speak.[no line break]" (F).
For issuing the response text of The parser clarification internal rule response (E) when the person asked is not the player
  (this is the don't ask what we want the npc to do something to rule): instead say "[We] [can't] speak.[no line break]" (G).

Speechless ends here.

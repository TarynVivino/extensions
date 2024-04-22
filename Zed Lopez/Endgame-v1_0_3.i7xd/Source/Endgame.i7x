Version 1.0.3 of Endgame by Zed Lopez begins here.

"An alternative end game approach that disables much of the action-processing and
 turn sequence but retains the regular command parsing loop. For 10.2 and above."

[ We need a new indicator for whether the game is on or over: from the point of
  view of the rest of the Standard Rules, the game is still continuing normally 
  through the turn sequence when Endgame thinks it's over...  ]

Include (- Global game_on = 1; -).

gameplay is a truth state that varies.
The gameplay variable translates into I6 as "game_on".

To decide if game over: (- (~~game_on) -).
To decide if game on: (- game_on -).

Ending the game is an activity.
First before ending the game: now gameplay is false.

For ending the game (this is the standard endgame question rule):
  say "Would you like to Restore, Restart, or Quit?" (A).

To end the/-- game: carry out the ending the game activity.

Restarting the game is an endgame action.
Restoring the game is an endgame action.
Quitting the game is an endgame action.
Switching the story transcript on is an endgame action.
Switching the story transcript off is an endgame action.
Requesting the story file version is an endgame action.

To knock current action out of this world: (- meta = 1; -)

First setting action variables when the current action is not an endgame action (this is the endgame knock disallowed actions out of this world rule):
  knock current action out of this world.

First specific action-processing rule when game over and the current action is not an endgame action (this is the endgame block disallowed actions rule):
  instead say "Only Restore, Restart, and Quit are available." (A).

[ catches all in-world actions ]
first before when game over (this is the endgame block in-world actions rule):
  instead say "Only Restore, Restart, and Quit are available." (A).

The every turn stage rule does nothing when game over. 
The early scene changing stage rule does nothing when game over. [ The scene changing rules didn't have names before 10.2 ]
The late scene changing stage rule does nothing when game over.  [ so couldn't be deactivated easily ]
The timed events rule does nothing when game over.
The advance time rule does nothing when game over.
The update chronological records rule does nothing when game over.
The notify score changes rule does nothing when game over.

The endgame block disallowed actions rule is listed in the check verifying the story file rules.
The endgame block disallowed actions rule is listed in the check requesting the score rules.
The endgame block disallowed actions rule is listed in the check preferring abbreviated room descriptions rules.
The endgame block disallowed actions rule is listed in the check preferring unabbreviated room descriptions rules.
The endgame block disallowed actions rule is listed in the check preferring sometimes abbreviated room descriptions rules.
The endgame block disallowed actions rule is listed in the check switching score notification on rules.
The endgame block disallowed actions rule is listed in the check switching score notification off rules.
The endgame block disallowed actions rule is listed in the check requesting the pronoun meanings rules.

Endgame ends here.

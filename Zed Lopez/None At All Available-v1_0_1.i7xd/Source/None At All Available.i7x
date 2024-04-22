Version 1.0.1 of None at All Available by Zed Lopez begins here.

Include Intriguing Snippets by Zed Lopez.

The exclude people from take all rule is not listed in the for deciding whether all includes rules.
The exclude people from drop all rule is not listed in the for deciding whether all includes rules.

For deciding whether all includes the player when taking or dropping or throwing or inserting or putting (this is the include player in doing something to all rule): it does.
For deciding whether all includes the person asked when taking: if the person asked is not the player, it does not.


[a person when someone taking: it does not.]
[or someone dropping or someone throwing or someone inserting or someone putting (this is the exclude NPCs from doing something to all rule): it does not.]

Verbify relates one text to one verb.
The verb to verbify means the reversed verbify relation.
Verb take verbifies "take".
Verb drop verbifies "drop".
Verb get verbifies "get".
To pick up is a verb.
Verb pick up verbifies "pick".
To insert is a verb.
Verb insert verbifies "insert".
To throw is a verb.
Verb throw verbifies "throw".

First multiple action processing rule (this is the anti-none available rule):
let l be the multiple object list;
if the player is listed in l begin;
  remove the player from l;
  alter the multiple object list to l;
  if the number of entries in l is 0 begin;
    let command be the substituted form of "[the verb word]";
    if the action name part of the current action is dropping action begin;
      if the number of things carried by the player is 0 begin;
        say "[We] [aren't] carrying anything.";
      else;
        say "[We] [can't] drop anything.";
      end if;
    else if there is a verb (called v) that verbifies command begin;
      say "There [adapt verb be in story tense] nothing [here] to [infinitive of v].";
    else;
      say "There [adapt verb be in story tense] nothing [here] to do that with.";
    end if;  
  end if;
end if;
if the number of entries in l is 1, say "[entry 1 in l]: [run paragraph on]";

None at All Available ends here.

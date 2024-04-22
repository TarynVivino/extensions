Section: Introduction

The short version: Planner is a stateless goal-planning engine for IF actors. It is an Inform 7
reimplementation of the library formerly known as RAP (Reactive Agent Planner) for Inform 6 and TADS.

Note: A more full version of documentation with usage details is in the works. For now, look at the included demo game 'Alchemy' and at 'Basic Plans' to see how to use and define plans, relations and actions.

What is Planner, and why would you want one?

Planner gives your actors the ability to take charge of their own destiny and make their own way in the world. Instead of spelling out a series of actions in order, or responses to situations as they arise, you give the actor a goal to achieve, and - if it knows how - it chains together a series of actions that it thinks will make that goal happen. Then it takes the first step toward the goal. Then, next move, it does the whole thing again, starting from a blank slate, but hopefully one step closer to achieving its dream. This means that a Planner-guided actor can
be both scripted *and* react to events that change the state of the world.

What kind of goals can Planner handle?

Literally anything. It's that powerful! Okay, a few qualifications.

1) You have to be able to describe the goal as a yes/no question - 'am I in the lounge? Is the red ball in the blue box? Does Belboz have the Flubar spell memorised?'

2) The goal has to be made up of only three parts: two objects and a relation between them (the cat, is-on, the mat).

3) The relation has to have two things defined for it, using rules:
a) How to test if it's true or not
b) One or more plans for making it come true, if it's not already.

4) It's in those plans that the real magic lies. You have to be able to write a fairly short, clear set of answers to the question 'given this goal that I want to achieve, what is the best next step toward that goal?'

5) The 'next action to do' can have any number of subgoals attached to it, which Planner will attempt to make true in the order in which you give them. 'To have the rabbit, first: have the Flubar spell memorised. Next: have the hat. next: have the wand. finally: wave the wand.' If the actor doesn't have the spell, it will first make sure it does before even considering the rest of the goal. Then, if it has the spell, it will make sure it has the hat. And so on.

6) It's okay to have multiple ways of getting to a goal! Planner will explore all the options in parallel until it finds the first one that seems like it would work. And if it comes across a goal that it has already looked at, it won't add it twice.

7) There are a few built-in relations that Planner knows how to handle (basic movement, possession and containment, locking and unlocking), and you can custom-write as many as you need for the special features of your story.

8) One of the most important limitations of Planner is that it has no memory between moves. This makes it react instantly to anything that changes, so it never gets sidetracked into trying to follow plans that are already out of date. But it won't know even what it was doing in the last move unless you track that yourself. It could get stuck in loops. For this reason it is important to give some thought to the exact sequence of goals in any given plan, and which ones it makes sense to do first. For example: if you're trying to get through a locked door, you probably want
to find the key, and find the the door, and make sure the door is open. But you'll want to find the key *first*, otherwise you'll get stuck.

9) Planner also assumes that it has access to perfect knowledge about everything in the world. This is because this is the simplest and least memory-consuming way to program it - it simply checks the 'real' story state rather than giving each actor its own model of the world. This is fine for modelling actors who are at home in an environment they know very well. But if you want your actors to make guesses and have false or imperfect knowledge, you'll need to find a way of storing that information and dealing with it yourself. There's a whole barrel of complications that that raises, the limitations of memory in the Z-machine only one of them. (Dealing sensibly with false information is also probably a problem that requires major artificial intelligence... but you're welcome to give it a go.)

10) Calculating a goal tree every move can be a very expensive process in terms of CPU usage (more so than memory - another reason Planner is written to recalculate everything on the fly rather than storing state between moves). The exact number of calculations Planner has to do each move will vary wildly depending on what goal it's trying to achieve, how big the story is, and just what kind of relations and plans for making them true have been programmed into the system.

So that's it. Planner lets you give IF actors their own mind - of a fairly mechanical, goal-focused, efficiency-driven sort. You may want to dress up their actions a bit, or use Planner only in the parts of your game where it makes sense. With Inform 7, you've got a lot of freedom to mix and match libraries and rules, so give it a go, explore the possibilities, and most importantly, have fun!

Section: Extension

How to extend Planner:

1. If you are defining a new relation type:
a) define a new 'planning-relation'
b) create a 'planning-testing rule when the desired relation is <relation>'

2. If you are defining a new action type:
a) define a new 'planning-action'
b) create a 'planning-acting rule when the planned action is <action>'

3. If you are defining a new plan:

a) create a 'planning rule when the planning actor is <actor> and the desired relation is <relation> and the desired param1 is <object> and the desired param2 is <object>' (and whatever other 'when' clauses you may need to narrow down the exact conditions under which this plan applies

b) To avoid having to use a whole lot of 'if' statements to check the 'desired plan' and 'desired step', there are a couple of phrases you can use for shorthand.

	'plan 1;'  (this sets the current plan number for 'suggest')
	'suggest <token> with <object 1> and <object 2>;' (you can omit the 'with <object 1>...' and 'and <object 2>' if there is no sensible first or second parameter)
	
	And just continue with 'suggest...' lines until you're done.
	
	Each time you call 'suggest...' it will increment an internal step number, and compare this against 'desired step', ignoring the line for all the cases that don't match. This is a bit of a kludge but it's the simplest syntax I've come up with so far.
	
	Be aware that rules may interact in unexpected ways unless you put an explicit 'rule succeeds' on the end of yours. Also, the 'Basic Plans' rules may take precedence over more specific rules you write unless you use a procedural rule to make them go away. This may change as I7's rule precedence ordering evolves.
	
	Check 'Basic Plans' and the demo game 'Alchemy' to see examples of writing plans.

Section: Design Notes
	
Some notes on the design:

Planner (and its predecessor, RAP) was influenced by a paper [1] describing the architecture of the Carnegie Mellon University 'Oz' interactive storytelling system. I have never seen Oz running, but the paper described a goal-planning framework called Hap. Like the rest of Oz, it was built in Lisp, a dynamic language which is well-suited to building complicated data structures in memory and manipulating them efficiently. Interactive Fiction systems, however, tend to deal much better with static data and routines. There were also a few design decisions in Hap that I just plain didn't understand, so when I tried to build a planner myself, I simplified the design down to
the point that I could at least fit it in my head.

One feature of Hap, for instance, was that it appeared to store plans as sequences of actions to be carried out, but not dynamically recalculate them each move. I couldn't understand how that could work in a dynamic gameworld where no world state could be relied upon to remain constant from move to move, so I made mine only plan one action ahead at a time. Hap also had two types of plans: ones with goals to be satisfied sequentially (like Planner), but also ones where the goals could be satisfied in parallel. Again, I had no idea how such a thing could be implemented in a small machine or even what it would look like if it did. I suspect that parallel goal-solving would require vastly more complicated machinery to weigh up competing goals and avoid nasty causality loops. So I cut that out too.

Finally, Hap appeared to have the ability to evaluate plans that had run and reward or punish them based on whether they seemed to work. Not only did that seem hard to implement, it also sounded like overkill for the IF environment, where generally the actors know more than the player does, and the author tends to lovingly hand-script everything anyway. And I just didn't understand how an AI actor could possibly evaluate highly specific plans without a sense of context - if I try to open a door and it fails, should I gather from that that the 'open door by turning doorknob'
plan is wrong in all cases, or is it just this one door that's stuck? So I made the decision early on that RAP (as it was then) would not care at all about machine learning, or in fact any kind of feedback from the environment, but would simply and blissfully assume that The Author Knows Best and that every plan hard-coded into the actor's memory could be treated as the pure gold of Absolute Truth dripping from the heavens.

This is a huge assumption, but it made the problem manageable enough to fit both into an Interactive Fiction engine and into my bear-of-small-brain head, and at the same time. I recommend radical oversimplification for any other problems you may face in life.

(It may well be possible to layer some kind of feedback / learning / knowledge management layer over top of Planner's fairly stripped-down kernel. Or you might have better luck throwing it completely out and starting from scratch. Either way I suspect you will need a more powerful virtual machine than the Z-machine, and a language more meta-programmable than Inform 7, in order to start reinventing symbolic AI of the kind that was cutting edge in the 1970s. But the history of the Interactive Fiction community so far has been full of surprises, and the children of
SHRDLU may yet surpass their elders. We've come a long way from Blocks World as it is.)

Section References

[1] "Hap: A Reactive, Adaptive Architecture for Agents". A. Bryan Loyall and Joseph Bates. Technical Report CMU-CS-91-147, School of Computer Science, Carnegie Mellon University, Pittsburgh, PA, June 1991. Downloadable postscript version available as of 2006-05-28 from http://www.cs.cmu.edu/afs/cs.cmu.edu/project/oz/web/papers.html

Section Changelog

Version 2/211124: bug fixes per Version 3/211124: Bug fixes per [Planner/Basic Plans, NPC actions are invisible IntFiction thread](https://intfiction.org/t/planner-basic-plans-npc-actions-are-invisible/10034/)

This extension differs from the author's original version. The latest version of this extension can be found at <https://github.com/i7/extensions>.

This extension is released under the Creative Commons Attribution licence. Bug reports, feature requests or questions should be made at <https://github.com/i7/extensions/issues>.


This extension is partly based on one called "Epistemology" by Eric Eve. As a concept, epistemology refers to the study of how we know what we know. As such, the title of the original extension was a bit grandiose at best since it dealt not at all with concepts like the scope of knowledge, epistemic justification, or the rationality of belief; all of which are in the ambit of epistemology.

The aim here is a bit simpler, which is to model the very basics of how people come to know certain things about the world around them, which is generally by becoming aware of them.

Given that more modest goal, the purpose of the extension is quite simply to keep track of what objects the player character knows about, either because they have seen the objects or because they are already familiar with them for some other reason, such as prior knowledge. This extension will also model the idea of being aware of something (a supposition) and direct knowledge of something (a fact).

Section: Sight and Familiarity

With this extension in place, all objects in the story world have the following either-or distinctions:
	
(1) seen or unseen

(2) familiar or unfamiliar

(3) known or unknown

By default, all objects start unseen and unfamiliar and hence unknown. As an author you can, of course, change this for individual objects, groups of objects or kinds. A few points are important:
	
(1) The seen/unseen and familiar/unfamiliar pairs can be tested or set as is required.

(2) The known/unknown status may be tested for but not directly changed in code.

That second point must be the case since the known/unknown status derives from the other two.

Section: State of Knowledge

Given the above points, the following general rule holds: a thing is considered to be known if it is either seen or familiar; otherwise it is unknown.

These distinctions exist to model different kinds of knowledge. Consider, for example, that the player character may well know about things they have yet to see. For example, a detective character is sent to investigate a particular crime. That certainly means they, at the very least, know of the crime and, possibly, they know who the crime was committed against.

The player character may also know of or be familiar with things that can't be seen, such as concepts like crime (in a general sense) or justice and so on. Likewise, a detective may come to be familiar with certain motivations that some other character had for committing the crime. A motivation could be something internal that the player character learns about but also tied to something tangible, such as finding incriminating evidence. Of those aspects, only one could be said to be "seen" in any sense.

Things that are known about but as yet unseen or concepts that are abstract can be marked as familiar, either from the outset, or when the player learns about them during the course of the game. Also, there may be cases where it's important to distinguish whether the player character has actually seen something -- like, say, a crime scene -- or merely knows about it.

Section: Implementation

As far as possible, the extension tries to keep track of what the player character has seen in two ways.

(1) Marking as seen (and familiar) everything that's in plain view (i.e., in scope) in the location when a LOOK command is executed.

(2) Marking eveything as seen (and familiar) in plain view within a container when that container is opened.

This is a lot of calculation and this extension does incorporate changes made by Andrew Plotkin to Eric Eve's extension, essentially putting in some optimizations to the algorithm to avoid potential performance issues with games that have a lot of objects in the model world.

In general a few points about how this works:
	
(1) When the player opens a container, all objects in the room (not just the container) are marked "seen".

(2) When the player LOOKs or OPENs, objects added to scope (with the "deciding the scope of" activity) are marked "seen".

The simple way to summarize all this is that this extension only marks objects "seen" when the player looks around, opens a container, or examines something. This includes the case of when they move to a different room, which invokes LOOK. This does mean, however, that objects which are moved into a room might not be "seen" until the player does LOOK or EXAMINE.

Section: Familiarizing

The phrase "familiarize (thing)" is provided to mark a thing as both "seen" and "familiar".

You can also use the phrase "mark-everything-in-scope-as-seen" to re-scan the entire room. In fact, if you want to be absolutely certain about marking every object that appears, you can add this rule:
	
	Every turn: mark-everything-in-scope-as-seen.
	
That said, it's worth noting that this may come at the expense of some game speed.

Section - Knowledge Subjects

A new kind called "knowledge subject" is provided for more abstract objects such as criminal behavior, ancient history, quantum mechanics, and so on.

Unlike all other things in the game world, knowledge subjects are considered familiar by default.

Part - Testing World Knowledge

Finally, the testing command KSTATE (not for release) is provided to aid the testing and debugging of games using this extension. For example the command KSTATE <NOUN> will show whether the noun is seen, familiar or known. This may be useful to help track whether the knowledge state of various objects in your story is actually what you think it should be.

The KSTATE check can also be done for knowledge subjects, suppositions, and facts.


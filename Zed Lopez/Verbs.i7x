Version 1/211231 of Verbs by Zed Lopez begins here.

"Provides a phrase that, given a text, returns a corresponding verb
if it exists. For 6M62."

Volume 1

Part 1 - All-verbs

Chapter 1 - All-verbs var

All-verbs is a list of verbs variable.

Chapter 2 - Evil hard-coding of contraction verbs

To decide what verb is 're-verb: (- ConjugateVerb_74 -).
To decide what verb is 've-verb: (- ConjugateVerb_75 -).
To decide what verb is aren't-verb: (- ConjugateVerb_76 -).
To decide what verb is can't-verb: (- ConjugateVerb_77 -).
To decide what verb is haven't-verb: (- ConjugateVerb_78 -).
To decide what verb is don't-verb: (- ConjugateVerb_79 -).
To decide what verb is mustn't-verb: (- ConjugateVerb_80 -).
To decide what verb is mightn't-verb: (- ConjugateVerb_81 -).
To decide what verb is mayn't-verb: (- ConjugateVerb_82 -).
To decide what verb is wouldn't-verb: (- ConjugateVerb_83 -).
To decide what verb is couldn't-verb: (- ConjugateVerb_84 -).
To decide what verb is shouldn't-verb: (- ConjugateVerb_85 -).
To decide what verb is won't-verb: (- ConjugateVerb_86 -).

Chapter 3 - Load-all-verbs

To load-all-verbs:
  repeat with v running through verbs begin;
    add v to all-verbs;
  end repeat;
  add 're-verb to all-verbs;
  add 've-verb to all-verbs;
  add aren't-verb to all-verbs;
  add can't-verb to all-verbs;
  add haven't-verb to all-verbs;
  add don't-verb to all-verbs;
  add mustn't-verb to all-verbs;
  add mightn't-verb to all-verbs;
  add mayn't-verb to all-verbs;
  add wouldn't-verb to all-verbs;
  add couldn't-verb to all-verbs;
  add shouldn't-verb to all-verbs;
  add won't-verb to all-verbs;

Chapter 4 Verb -- that's what's happenin'

To decide what verb is (T - a text) as a verb:
    let t be T in lower case;
    repeat with v running through all-verbs begin;
       if t is "[verb v]", decide on v;
    end repeat;
    decide on the null verb.

chapter 5 Say verb

[ If V is a verb, say V outputs the verb with "verb" in front, e.g.,

let v be "have" as a verb;
say "[v]";

will output "verb have". This is an alternative that omits the "verb".

let v be verb have;
say "[verb v]";

will output "have".
]
To say verb (V - a verb):
    (- {V}(1); -).

Chapter 6 - Meaning

To say the/-- showme-meaning of (V - a verb):
    showme the meaning of V.

To decide what text is the verb-meaning of (V - a verb):
  if "[V]" is "verb be", decide on "Relation of objects: equality relation";
  let result be "[showme-meaning of V]";
  if result matches the text "relation of objects:  relation", decide on "Property";
  if result matches the text "relation of objects: equality relation", decide on "For saying only";
  now result is line number 1 in result; [trim whitespace]
  replace the text "'meaning of V' = r" in result with "R";
  decide on result.

Volume 2 - Initialization

Section 1 (for use with Alternative Startup Rules by Dannii Willis)

After starting the virtual machine: load-all-verbs.

Section 2 (for use without Alternative Startup Rules by Dannii Willis)

When play begins: load-all-verbs.

Volume 3 (For use without Central Typecasting by Zed Lopez)

To decide which K is the/a/-- null (name of kind of value K): (- nothing -)

Verbs ends here.

---- Documentation ----

Provides these phrases:

``<text> as a verb`` returns a verb. If it couldn't find a verb it returns "the null verb", i.e., the value 0 cast as a verb. If there's a possibility of this, your code should make a test like ``if v is the null verb`` after calling the phrase.

``say showme-meaning of <verb>`` outputs one of:
- Relation of objects: <relation name> relation
- For saying only
- Property
- I don't know the meaning of <provided verb>

This improves on the default behavior of ``showme the meaning of <verb>`` 
which outputs "relation of objects: equality relation" for verbs that are for saying only and "relation of objects:  relation" for verbs that are properties.

If v is the verb to be and you use the built-in say phrase ``say "[v]"``, the output is "verb be". This extension adds ``say verb <verb>`` which outputs just "be". 

See Verbal Commands by Zed Lopez

Section Changelog
1/211231 added documentation, use "line number 1" instead of a regexp to trim whitespace
1/211213 give verb-meaning more polished output

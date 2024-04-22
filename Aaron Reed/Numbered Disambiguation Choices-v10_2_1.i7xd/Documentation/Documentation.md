This extension is designed to solve two problems with disambiguation questions. First: many newcomers to IF do not realize that they can just type an identifying word to answer the question, causing frustration as they retype their whole command all over again each time this occurs. Second, it's all too easy for a disambiguation question to be triggered that does not provide enough information to differentiate between the two items-- either the author did not supply enough adjectives, or the adjectives are not part of the way the object names are printed. In either case this leads to the dreaded "disambiguation loop," where the question keeps repeating and one or more of the objects cannot be referred to at all.

Numbered Disambiguation Choices addresses both issues by printing (and then understanding) numbers before each object in a disambiguation question. Players can type just the number (or an identifying word or new command, as normal) to continue.

By default, the extension will reset the numbers as soon as the player types a command which does not contain a number. This is because in testing players would often try to refer to other objects in the disambiguation list by their number in subsequent turns. If you want to change this so numbers can only be used immediately after a disambiguation question is asked, add the following to your code:

	Every turn: follow the Numbered Disambiguation Choices reset disambiguables rule.

A final note: if your code involves parsing the closing parenthesis character -- ) -- you'll need to remove or overrule the "Numbered Disambiguation Choices strip closing parenthesis rule". By default, the extension removes this character from input, since some players try to be too literal when answering the disambiguation question.


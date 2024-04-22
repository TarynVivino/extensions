Version 2.0.1 of Unicode Interrogation by Michael Martin begins here.

"Allows an author to verify that an interpreter can support specific Unicode effects."

"With Glulx support code contributed by Matthew Slattery"

[Version 2: Adds Glulx support. Thanks to Matthew Slattery for the code.]

Use authorial modesty.

Section Z (for Z-Machine only)

To decide whether unicode (X - a number) is supported exactly/--: (- (unitest({X}) == 1) -)

Include (-
[ unitest x i;
    ! If we don't support at least standard 1.0, @check_unicode will crash the terp!
    ! Thus, we check version in $32 first.  It's a little inefficient to check this in 
    ! every iteration, but sometimes life is hard.
    if (0->$32 == 0) return 0;
    @check_unicode x -> i;
    return i & 1;
]; -)

Section G (for Glulx only)

[This code comes from a post by Matthew Slattery.]

To decide whether unicode (X - a number) is supported exactly: 
 (- (glk_gestalt(gestalt_CharOutput, {X}) == gestalt_CharOutput_ExactPrint) -) 

To decide whether unicode (X - a number) is supported: 
 (- (glk_gestalt(gestalt_CharOutput, {X}) ~= gestalt_CharOutput_CannotPrint) -) 

Unicode Interrogation ends here.

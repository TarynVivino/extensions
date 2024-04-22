Version 2.0.1 of Bit Ops by Zed Lopez begins here.

"Routines to access bitwise operators."

Use authorial modesty.

Part Bit Ops

Chapter - Bitwise NOT

To decide what number is bit-not (n1 - a number):
  (- (~{n1}) -).

Chapter - Bitwise XOR

To decide what number is (n1 - a number) bit-xor/xor (n2 - a number): (- (({n1} | {n2}) & (~({n1} & {n2}))) -)

Chapter - Bitwise OR

To decide what number is (n1 - a number) bit-or (n2 - a number): (- ({n1}|{n2}) -)

Chapter - Bitwise AND

To decide what number is (n1 - a number) bit-and (n2 - a number): (-({n1} & {n2}) -).

Chapter - Bitwise Shift Left

To decide what number is (n1 - a number) unsigned/logical shifted/shift left by/of/-- (n2 - a number):
  (- shiftl({n1},{n2}) -).

Section - Bitwise Shift Left routine (for Glulx only)

Include (-
[ shiftl n1 n2 result;
  @shiftl n1 n2 result;
  return result;
];
-).

Section - Bitwise Shift Left routine (for Z-Machine only)

Include (-
[ shiftl n1 n2 result;
  @log_shift n1 n2 ->result;
  return result;
];
-).

Chapter - Bitwise Unsigned Shift Right

To decide what number is (n1 - a number) unsigned/logical shift/shifted right by/of/-- (n2 - a number):
  (- ushiftr({n1},{n2}) -).

Section - Bitwise Unsigned Shift Right routine (for Glulx only)

Include (-
[ ushiftr n1 n2 result;
  @ushiftr n1 n2 result;
  return result;
];
-).

Section - Bitwise Unsigned Shift Right routine (for Z-machine only)

Include (-
[ ushiftr n1 n2 result;
  n2 = -n2;
  @log_shift n1 n2 -> result;
  return result;
];
-).

Chapter Arithmetic shift right

To decide what number is (n1 - a number) signed/arithmetic/-- shift/shifted right by/of/-- (n2 - a number):
  (- sshiftr({n1},{n2}) -).

Section - signed Shift Right routine (for Glulx only)

Include (-
[ sshiftr n1 n2 result;
  @sshiftr n1 n2 result;
  return result;
];
-).

Section - signed Shift Right routine (for Z-machine only)

Include (-
[ sshiftr n1 n2 result;
  n2 = -n2;
  @art_shift n1 n2 -> result;
  return result;
];
-).

Bit Ops ends here.

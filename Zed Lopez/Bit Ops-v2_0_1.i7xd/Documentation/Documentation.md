Adds phrases for basic logic operations:

- bit-not
- bit-or
- bit-and
- bit-xor/xor

unsigned shift left:
- unsigned/logical shifted/shift left by/of/--

unsigned shift right:
- unsigned/logical shift/shifted right by/of/--

signed shift right:
- signed/arithmetic/-- shift/shifted right by/of/--

Chapter Changelog

Version 2 replaced most function calls with I6 inline substitutions. Thanks to Otis the Dog for suggesions.

Chapter Examples

	"bitops"
	
	Include Bit Ops by Zed Lopez.
	Include Unit Tests by Zed Lopez.
	
	Lab is a room.
	
	Use test automatically.
	
	not-test is a unit test. "Not".
	
	For testing not-test:
	for "~ 0" assert bit-not 0 is -1;
	for "~ -1" assert bit-not -1 is 0;
	for "~ 1" assert bit-not 1 is -2;
	for "~ 5" assert bit-not 5 is -6;
	
	xor-test is a unit test. "Xor".
	
	For testing xor-test:
	for "0 ^ 1" assert 0 xor 1 is 1;
	for "0 ^ 0" assert 0 xor 1 is 1;
	for "1 ^ 1" assert 0 xor 1 is 1;
	for "5 ^ 3" assert 5 xor 3 is 6;
	for "-3 ^ 8" assert -3 xor 8 is -11;
	
	or-test is a unit test. "Or".
	For testing or-test:
	for "0 | 0" assert 0 bit-or 0 is 0;
	for "0 | 1" assert 0 bit-or 1 is 1;
	for "1 | 0" assert 1 bit-or 0 is 1;
	for "1 | 1" assert 1 bit-or 1 is 1;
	for "-5 | 17" assert -5 bit-or 17 is -5;
	
	and-test is a unit test. "And".
	For testing and-test:
	for "0 & 0" assert 0 bit-and 0 is 0;
	for "0 & 1" assert 0 bit-and 1 is 0;
	for "1 & 0" assert 1 bit-and 0 is 0;
	for "1 & 1" assert 1 bit-and 1 is 1;
	for "15 & 4" assert 15 bit-and 4 is 4;
	for "-3 & 18" assert -3 bit-and 18 is 16;
	
	Chapter Shiftl
	
	shiftl-test is a unit test. "Shift L".
	For testing shiftl-test:
	for "0 << 0" assert 0 shifted left 0 is 0;
	for "0 << 1" assert 0 shifted left 1 is 0;
	for "0 << 2" assert 0 shifted left 2 is 0;
	for "1 << 0" assert 1 shifted left 0 is 1;
	for "2 << 0" assert 2 shifted left 0 is 2;
	for "1 << 1" assert 1 shifted left 1 is 2;
	for "1 << 2" assert 1 shifted left 2 is 4;
	for "2 << 2" assert 2 shifted left 2 is 8;
	for "-1 << 7" assert -1 shifted left 7 is -128;
	for "-2 << 1" assert -2 shifted left 1 is -4;
	for "max << 1" assert max integer shifted left 1 is -2;
	for "max << 2" assert max integer shifted left 2 is -4;
	
	Chapter Shiftr
	
	ushiftr-test is a unit test. "Ushift R".
	For testing ushiftr-test:
	for "0 >>> 0" assert 0 unsigned shifted right 0 is 0;
	for "0 >>> 1" assert 0 unsigned shifted right 1 is 0;
	for "0 >>> 2" assert 0 unsigned shifted right 2 is 0;
	for "1 >>> 0" assert 1 unsigned shifted right 0 is 1;
	for "1 >>> 1" assert 1 unsigned shifted right 1 is 0;
	for "1 >>> 2" assert 1 unsigned shifted right 2 is 0;
	for "2 >>> 1" assert 2 unsigned shifted right 1 is 1;
	for "2 >>> 2" assert 2 unsigned shifted right 2 is 0;
	for "-2 >>> 1" assert -2 unsigned shifted right 1 is max integer;
	for "min >>> 1" assert min negative integer unsigned shifted right 1 is (max integer / 2) + 1;
	for "16 >>> 2" assert 16 unsigned shifted right 2 is 4;
	for "-1 >>> 1" assert -1 unsigned shifted right 1 is max integer;
	for "-4 >>> 1" assert -4 unsigned shifted right 1 is max integer - 1;
	for "-3 >>> 1" assert -3 unsigned shifted right 1 is max integer - 1;
	for "-5 >>> 1" assert -5 unsigned shifted right 1 is max integer - 2;
	
	Chapter signed shift right
	
	sshiftr-test is a unit test. "Sshift R".
	For testing sshiftr-test:
	for "0 >> 0" assert 0 shifted right 0 is 0;
	for "0 >> 1" assert 0 shifted right 1 is 0;
	for "0 >> 2" assert 0 shifted right 2 is 0;
	for "1 >> 0" assert 1 shifted right 0 is 1;
	for "1 >> 1" assert 1 shifted right 1 is 0;
	for "1 >> 2" assert 1 shifted right 2 is 0;
	for "2 >> 1" assert 2 shifted right 1 is 1;
	for "2 >> 2" assert 2 shifted right 2 is 0;
	for "min >> 1" assert min negative integer signed shifted right 1 is min negative integer / 2;
	for "-2 >> 1" assert -2 signed shifted right 1 is -1;
	for "16 >> 2" assert 16 signed shifted right 2 is 4;
	for "-4 >> 2" assert -4 signed shifted right 2 is -1;


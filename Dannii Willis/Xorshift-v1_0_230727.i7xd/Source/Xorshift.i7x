Version 1.0.230727 of Xorshift by Dannii Willis begins here.

"Allows Inform 7's random number generator to be replaced with one that is consistent across all interpreters"

Section - The xorshift random number generator

The xorshift seed is a number variable.
The xorshift seed variable is defined by Inter as "xorshift_seed".

To seed the xorshift generator randomly:
	(- xorshift_seed_randomly(); -).

Include (-

Global xorshift_seed;

! Using @random seed the xorshift generator
[ xorshift_seed_randomly temp;
	.Begin;
	#ifdef TARGET_ZCODE;
		@random 256 -> temp;
		temp--;
		@log_shift temp 8 -> temp;
		@random 256 -> xorshift_seed;
		xorshift_seed--;
		xorshift_seed = xorshift_seed | temp;
	#ifnot;
		@random 0 xorshift_seed;
	#endif;
	if ( xorshift_seed == 0 )
	{
		jump Begin;
	}
];

-)

Include (-
! Replace Inform's default random function with one that will use the xorshift generator (when enabled)

+replacing [ random range result mod temp;
	! Use the VM's @random if xorshift isn't enabled
	if ( xorshift_seed == 0 )
	{
		#ifdef TARGET_ZCODE;
			@random range -> result;
		#ifnot;
			@random range result;
			result++;
		#endif;
		return result;
	}
	! If the number we generate is close to MAX_POSITIVE_NUMBER then the results may be skewed
	mod = MAX_POSITIVE_NUMBER % range;
	! The xorshift generator (xorshift* for Glulx)
	.Begin;
	#ifdef TARGET_ZCODE;
		! This xorshift generator is from http://b2d-f9r.blogspot.com/2010/08/16-bit-xorshift-rng.html
		@log_shift xorshift_seed 4 -> temp;
		! The Z-Machine has no xor opcode! :'(
		xorshift_seed = ( xorshift_seed | temp ) & ( ~( xorshift_seed & temp ) );
		@log_shift xorshift_seed (-3) -> temp;
		xorshift_seed = ( xorshift_seed | temp ) & ( ~( xorshift_seed & temp ) );
		@log_shift xorshift_seed 7 -> temp;
		xorshift_seed = ( xorshift_seed | temp ) & ( ~( xorshift_seed & temp ) );
		result = xorshift_seed & MAX_POSITIVE_NUMBER;
	#ifnot;
		! This xorshift* generator is from https://gist.github.com/Marc-B-Reynolds/0b5f1db5ad7a3e453596
		@shiftl xorshift_seed 13 sp;
		@bitxor xorshift_seed sp xorshift_seed;
		@ushiftr xorshift_seed 17 sp;
		@bitxor xorshift_seed sp xorshift_seed;
		@shiftl xorshift_seed 5 sp;
		@bitxor xorshift_seed sp xorshift_seed;
		result = ( xorshift_seed * 1597334677 ) & MAX_POSITIVE_NUMBER;
	#endif;
	! Check if we're too close to MAX_POSITIVE_NUMBER, and generate a new number if so
	if ( result + mod < 0 )
	{
		jump Begin;
	}
	return ( result % range ) + 1;
];
-)

Xorshift ends here.

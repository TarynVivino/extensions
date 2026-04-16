Version 1/230407 of Type Conversion by Taryn Michelle begins here.

"Version 1 offers only a single type conversion, but it's the one most likely to be needed: converting a numeric value contained in text to a number."

Section - Text to Number Conversion

[ *** Convert text to numeric value ***
            This version is "forgiving" and will convert as much of the leading text as possible to a numeric value.
	If no conversion is possible (leading text cannot be interpreted as numeric) zero is returned.]
To decide which number is (S - text) as a/-- number:
	let is-negative be false;
	let strictly be false; 
	replace the regular expression "\s" in S with "";
	replace the regular expression "^\+" in S with "";
	if character number 1 in S is "-":
		let is-negative be true;
		replace the regular expression "\-" in S with "";
	if strictly is false:
		replace the regular expression "<^0-9>+.*" in S with ""; [If there is any non-digit, truncate the string there]
	let len be the number of characters in S;
	if len is 0:
		decide on 0;
	let result be 0.0;
	repeat with N running from 0 to (len - 1):
		let digit be character number (len - N) in S;
		let multiplier be 10 to the power N;
		if digit is "0":
			next;
		if digit is "1":
			now result is multiplier + result;
			next;
		if digit is "2":
			now result is (multiplier * 2) + result;
			next;
		if digit is "3":
			now result is (multiplier * 3) + result;
			next;
		if digit is "4":
			now result is (multiplier * 4) + result;
			next;
		if digit is "5":
			now result is (multiplier * 5) + result;
			next;
		if digit is "6":
			now result is (multiplier * 6) + result;
			next;
		if digit is "7":
			now result is (multiplier * 7) + result;
			next;
		if digit is "8":
			now result is (multiplier * 8) + result;
			next;
		if digit is "9":
			now result is (multiplier * 9) + result;
			next;
		if strictly is true: [ // A non-numeric character nullifies the conversion]
			decide on 0;
		otherwise: [ // A non-numeric character stops the conversion]
			break;
	if is-negative is true, let result be 0 - result;
	decide on result to the nearest whole number;
	
Type Conversion ends here.

---- DOCUMENTATION ----

Version 1 offers only a single type conversion, but it's the one most likely to be needed: converting a numeric value contained in text to a number.

Section - Usage

	The phrase:
		 "<some text"> as a number (or 'as number') 
	returns the text supplied converted to a numeric (integer) value. 
	
        The expression is "forgiving" -- as long as any portion of the initial part of the supplied text can be converted to a numeric value, the phrase returns that number, stopping at the first character that would make the expression NOT a number. (As only integers are supported at this time, and not real numbers, that includes a decimal point. IN such a case, the phrase will return the integer portion only.)

	If the text does not begin with a numeric value (in text form), zero is returned. 

	*: let N be "123" as a number;
	    let M be "256Kb" as a number;
	    let Q be M + N + "3.1417" as a number;
	    say "N = [N]; M = [M]; Q = [Q]" [ produces the output: N = 123; M = 256; Q = 382 ]
	
	    
	

Example: * Texualize - An exploration of text manipulation

Here we use the selection feature to describe which doors are open out of a group. Different rooms have different numbers of doors that could be open or closed, and we want our description to be as succinct as possible.

	*: "Numbers" by Taryn Michelle
	
	Include Type Conversion by Taryn Michelle. 
	
	Nowhere Important is a room. "See test results above banner." 
	
	To test conversion of (T - text):
		let N be a number; [declared first so that if we don't get a number as expected, Inform will complain]
		now N is T as a number. 
		say "[T] (as text) converted to [N][line break]";

	When play begins:
		let T1 be "4096";
		let T2 be "-[T1]";
		let T3 be "[T1]Kb";
		let T4 be "-[T1].6904[line break]and more";
		Test conversion of T1;
		Test conversion of T2;
		Test conversion of T3;
		Test conversion of T4;
	let N be a number;

	
        
	
	
		


 

	


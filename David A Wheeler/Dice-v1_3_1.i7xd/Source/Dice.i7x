Version 1.3.1 of Dice by David A Wheeler begins here.
"Support conventional X d Y dice notation, e.g., 3 d 6 totals 3 six-sided dice."

[ Released under the terms of the Creative Commons Attribution 4.0 International (CC-BY-4.0) license.  See https://creativecommons.org/licenses/by/4.0/ for license details. You may also use this under the Creative Commons Attribution 3.0 United States (CC-BY-3.0-US) license. See https://creativecommons.org/licenses/by/3.0/us/ for license details. You may also use this under the terms of the MIT license. See https://opensource.org/licenses/MIT for license details.

SPDX-License-Identifier: CC-BY-4.0 OR CC-BY-3.0-US OR MIT

Copyright (C) David A. Wheeler and Dice project contributors.]

To decide which number is (num - number) d (sides - number):
	let result be 0;
	repeat with iteration running from 1 to num:
		increase result by a random number between 1 and sides;
	decide on result.

Dice ends here.

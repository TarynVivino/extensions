
This extension is designed to make it easy to release your Inform 7 work under one of the several types of Creative
Commons Public License (CCPL). It is based on the information found at:

	http://creativecommons.org/about/licenses/meet-the-licenses

as of May 27, 2010.

This extension implements three commands:

	"license" - which displays the terms of the Creative Commons license you have selected
	"deed" - which displays a plain English outline of terms and conditions of the selected license
	"warranty" - which displays only the warranty portions of the terms

It also includes rules to display a copyright notice and a display of the "deed" on startup. The display of the deed
on startup may be suppressed by setting the 'suppress CC deed on startup' truth state provided by this extension
in your source code. If this flag is set, only the copyright notice and a note about how to display the deed will be
shown.

This extension offers customization of its function as follows:

	* The copyright notice displayed automatically includes the copyright year based on either the I7 'story creation
	year' variable (defined as part of bibliographic data) or the 'copyright year string' text provided in this extension.
	If both of these variables are left undefined, the compilation year will be used as the basis for determining the
	copyright year, and a warning will be printed at the start of a non-release build using this extension to notify the
	author. If both variables are defined, the 'copyright year string' will be displayed.

	* The copyright holder of a work may not be the same as the author. This extension includes a variable called
	'copyright holder' that the author may set explicitly, to have entities other than the author shown as the
	copyright holder in the copyright notice. If this variable is left undefined, a rule in the extension will set it to
	the story author by default, and a warning will be printed at the start of a non-release build using this extension
	to remind the author.

	* For authors who don't want to set the above variables but also don't want to see the warnings, a truth state
	variable called 'suppress CC license warnings' is provided by the extension. If the author sets this to true in
	the story source, these warnings will not be shown even in a non-release build.

	* The author may specify what type of CCPL is desired by setting the 'CC license chosen' variable to one of
	six predefined codes: by, by-nc, by-nd, by-sa, by-nc-nd, or by-nc-sa. See the URL at the start of this
	documentation for more information about the terms associated with each license type. If the author does
	not specify a license type, the Attribution-Noncommercial-ShareAlike (by-nc-sa) license will be used, and a
	warning will be printed at the start of a non-release build.

Before using, PLEASE NOTE: Creative Commons does not recommend the use of the CCPL for software.
However, although he is NOT A LAWYER, the writer of this extension believes a work of interactive fiction is
readily distinguishable from typical software due to the creative narrative elements that are essential to the
form. The CCPL is readily applicable to written fiction, and, at the very least, this extension's writer suspects
the license would be interpreted as being appropriate for these narrative elements. This extension's writer
also suspects that authors can extend this license to the programming art component of their work by
choosing to release the source code in a work incorporating the CCPL.

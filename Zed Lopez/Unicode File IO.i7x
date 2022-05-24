Version 2/220219 of Unicode File IO (for Glulx only) by Zed Lopez begins here.

"Experimental support for reading and writing external files that may
 include characters longer than a byte. For 6M62."

Book New Phrases

Part Can we unicode?

To decide if unicode is supported: (- glk_gestalt(gestalt_Unicode, 0) -).

Part Properties

Output-mode-value is a kind of value.
The output-mode-values are latin1-mode and unicode-mode.
An external file has an output-mode-value called output-mode.
The output-mode property translates into I6 as "extf_output_mode".

Part test binary vs text

Chapter I6 test binary vs text

Section ExtfileIsMode

Include (-
[ ExtfileIsMode extf bin struc;
  if ((extf < 1) || (extf > NO_EXTERNAL_FILES))
    return FileIO_Error(extf, "tried to write table to a non-file");
  struc = TableOfExternalFiles-->extf;
  if (bin && struc-->AUXF_BINARY) rtrue;
  if (~~bin && ~~struc-->AUXF_BINARY) rtrue;
  rfalse;
];
-).

Chapter I6 test binary vs text

To decide if (extf - an external file) is in/-- text mode:
  (- ~~(ExtfileIsMode({extf}, false)) -).

To decide if (extf - an external file) is in/-- binary mode:
  (- ~~(ExtfileIsMode({extf}, true)) -).

Book Revising FileIO

Part Readiness

Include (-

[ FileIO_Ready extf  struc fref usage str ch;
if ((extf < 1) || (extf > NO_EXTERNAL_FILES)) rfalse;
	struc = TableOfExternalFiles-->extf;
	if ((struc == 0) || (struc-->AUXF_MAGIC ~= AUXF_MAGIC_VALUE)) rfalse;
	if (struc-->AUXF_BINARY) usage = fileusage_BinaryMode;
	else usage = fileusage_TextMode;
	fref = glk_fileref_create_by_name(fileusage_Data + usage,
		Glulx_ChangeAnyToCString(struc-->AUXF_FILENAME), 0);
	if (glk_fileref_does_file_exist(fref) == false) {
		glk_fileref_destroy(fref);
		rfalse;
	}
    if (GProperty(EXTERNAL_FILE_TY, extf, extf_output_mode) > 1) {
      str = glk_stream_open_file_uni(fref, filemode_Read, 0);
      ch = glk_get_char_stream_uni(str);
    }
    else {
	  str = glk_stream_open_file(fref, filemode_Read, 0);
      ch = glk_get_char_stream(str);
    }
	glk_stream_close(str, 0);
	glk_fileref_destroy(fref);
	if (ch ~= '*') rfalse;
	rtrue;
];

[ FileIO_MarkReady extf readiness  struc fref str ch usage;
	if ((extf < 1) || (extf > NO_EXTERNAL_FILES))
		return FileIO_Error(extf, "tried to open a non-file");
	struc = TableOfExternalFiles-->extf;
	if ((struc == 0) || (struc-->AUXF_MAGIC ~= AUXF_MAGIC_VALUE)) rfalse;
	if (struc-->AUXF_BINARY) usage = fileusage_BinaryMode;
	else usage = fileusage_TextMode;
	fref = glk_fileref_create_by_name(fileusage_Data + usage,
		Glulx_ChangeAnyToCString(struc-->AUXF_FILENAME), 0);
	if (glk_fileref_does_file_exist(fref) == false) {
		glk_fileref_destroy(fref);
		return FileIO_Error(extf, "only existing files can be marked");
	}
	if (struc-->AUXF_STATUS ~= AUXF_STATUS_IS_CLOSED) {
		glk_fileref_destroy(fref);
		return FileIO_Error(extf, "only closed files can be marked");
	}
    if (GProperty(EXTERNAL_FILE_TY, extf, extf_output_mode) > 1) str = glk_stream_open_file_uni(fref, filemode_ReadWrite, 0);
    else str = glk_stream_open_file(fref, filemode_ReadWrite, 0);
	glk_stream_set_position(str, 0, 0); ! seek start
	if (readiness) ch = '*'; else ch = '-';
    if (GProperty(EXTERNAL_FILE_TY, extf, extf_output_mode) > 1) glk_put_char_stream_uni(str, ch); ! mark as complete
    else glk_put_char_stream(str, ch);
	glk_stream_close(str, 0);
	glk_fileref_destroy(fref);
];

-) instead of "Readiness" in "FileIO.i6t".

Part Open File

Include (-

[ FileIO_Open extf write_flag append_flag
	struc fref str mode ix ch not_this_ifid owner force_header usage;
	if ((extf < 1) || (extf > NO_EXTERNAL_FILES))
		return FileIO_Error(extf, "tried to open a non-file");
	struc = TableOfExternalFiles-->extf;
	if ((struc == 0) || (struc-->AUXF_MAGIC ~= AUXF_MAGIC_VALUE)) rfalse;
	if (struc-->AUXF_STATUS ~= AUXF_STATUS_IS_CLOSED)
		return FileIO_Error(extf, "tried to open a file already open");
	if (struc-->AUXF_BINARY) usage = fileusage_BinaryMode;
	else usage = fileusage_TextMode;
	fref = glk_fileref_create_by_name(fileusage_Data + usage,
		Glulx_ChangeAnyToCString(struc-->AUXF_FILENAME), 0);
	if (write_flag) {
		if (append_flag) {
			mode = filemode_WriteAppend;
			if (glk_fileref_does_file_exist(fref) == false)
				force_header = true;
		}
		else mode = filemode_Write;
	} else {
		mode = filemode_Read;
		if (glk_fileref_does_file_exist(fref) == false) {
			glk_fileref_destroy(fref);
			return FileIO_Error(extf, "tried to open a file which does not exist");
		}
	}
    if (GProperty(EXTERNAL_FILE_TY, extf, extf_output_mode) > 1) str = glk_stream_open_file_uni(fref, mode, 0);
    else str = glk_stream_open_file(fref, mode, 0);
	glk_fileref_destroy(fref);
	if (str == 0) return FileIO_Error(extf, "tried to open a file but failed");
	struc-->AUXF_STREAM = str;
	if (write_flag) {
		if (append_flag)
			struc-->AUXF_STATUS = AUXF_STATUS_IS_OPEN_FOR_APPEND;
		else
			struc-->AUXF_STATUS = AUXF_STATUS_IS_OPEN_FOR_WRITE;
		glk_stream_set_current(str);
		if ((append_flag == FALSE) || (force_header)) {
			print "- ";
			for (ix=6: ix <= UUID_ARRAY->0: ix++) print (char) UUID_ARRAY->ix;
			print " ", (string) struc-->AUXF_FILENAME, "^";
		}
	} else {
		struc-->AUXF_STATUS = AUXF_STATUS_IS_OPEN_FOR_READ;
		ch = FileIO_GetC(extf);
		if (ch ~= '-' or '*') { jump BadFile; }
		if (ch == '-')
			return FileIO_Error(extf, "tried to open a file which was incomplete");
		ch = FileIO_GetC(extf);
		if (ch ~= ' ') { jump BadFile; }
		ch = FileIO_GetC(extf);
		if (ch ~= '/') { jump BadFile; }
		ch = FileIO_GetC(extf);
		if (ch ~= '/') { jump BadFile; }
		owner = struc-->AUXF_IFID_OF_OWNER;
		ix = 3;
		if (owner == UUID_ARRAY) ix = 8;
		if (owner ~= NULL) {
			for (: ix <= owner->0: ix++) {
				ch = FileIO_GetC(extf);
				if (ch == -1) { jump BadFile; }
				if (ch ~= owner->ix) not_this_ifid = true;
				if (ch == ' ') break;
			}
			if (not_this_ifid == false) {
				ch = FileIO_GetC(extf);
				if (ch ~= ' ') { jump BadFile; }
			}
		}
		while (ch ~= -1) {
			ch = FileIO_GetC(extf);
			if (ch == 10 or 13) break;
		}
		if (not_this_ifid) {
			struc-->AUXF_STATUS = AUXF_STATUS_IS_CLOSED;
			glk_stream_close(str, 0);
			return FileIO_Error(extf,
				"tried to open a file owned by another project");
		}
	}
	return struc-->AUXF_STREAM;
	.BadFile;
	struc-->AUXF_STATUS = AUXF_STATUS_IS_CLOSED;
	glk_stream_close(str, 0);
	return FileIO_Error(extf, "tried to open a file which seems to be malformed");
];

-) instead of "Open File" in "FileIO.i6t".

Part Close File

Include (-

[ FileIO_Close extf  struc;
	if ((extf < 1) || (extf > NO_EXTERNAL_FILES))
		return FileIO_Error(extf, "tried to open a non-file");
	struc = TableOfExternalFiles-->extf;
	if (struc-->AUXF_STATUS ~=
		AUXF_STATUS_IS_OPEN_FOR_READ or
		AUXF_STATUS_IS_OPEN_FOR_WRITE or
		AUXF_STATUS_IS_OPEN_FOR_APPEND)
		return FileIO_Error(extf, "tried to close a file which is not open");
	if (struc-->AUXF_STATUS ==
		AUXF_STATUS_IS_OPEN_FOR_WRITE or
		AUXF_STATUS_IS_OPEN_FOR_APPEND) {
		glk_stream_set_position(struc-->AUXF_STREAM, 0, 0); ! seek start
    ! mark as complete
    if (GProperty(EXTERNAL_FILE_TY, extf, extf_output_mode) > 1) glk_put_char_stream_uni(struc-->AUXF_STREAM, '*');
    else glk_put_char_stream(struc-->AUXF_STREAM, '*');
	}
	glk_stream_close(struc-->AUXF_STREAM, 0);
	struc-->AUXF_STATUS = AUXF_STATUS_IS_CLOSED;
];

-) instead of "Close File" in "FileIO.i6t".

Part Get Character

Include (-

[ FileIO_GetC extf  struc;
	if ((extf < 1) || (extf > NO_EXTERNAL_FILES)) return -1;
	struc = TableOfExternalFiles-->extf;
	if (struc-->AUXF_STATUS ~= AUXF_STATUS_IS_OPEN_FOR_READ) return -1;
    if (GProperty(EXTERNAL_FILE_TY, extf, extf_output_mode) > 1) return glk_get_char_stream_uni(struc-->AUXF_STREAM);
    return glk_get_char_stream(struc-->AUXF_STREAM);
];

-) instead of "Get Character" in "FileIO.i6t".

Part Put Character

Include (-

[ FileIO_PutC extf char  struc;
	if ((extf < 1) || (extf > NO_EXTERNAL_FILES)) return -1;
		return FileIO_Error(extf, "tried to write to a non-file");
	struc = TableOfExternalFiles-->extf;
	if (struc-->AUXF_STATUS ~=
		AUXF_STATUS_IS_OPEN_FOR_WRITE or
		AUXF_STATUS_IS_OPEN_FOR_APPEND)
		return FileIO_Error(extf,
			"tried to write to a file which is not open for writing");
    if (GProperty(EXTERNAL_FILE_TY, extf, extf_output_mode) > 1) return glk_put_char_stream_uni(struc-->AUXF_STREAM, char);
    return glk_put_char_stream(struc-->AUXF_STREAM, char);
];
-) instead of "Put Character" in "FileIO.i6t".

Part Print Line

Include (-

[ FileIO_PrintLine extf ch  struc;
	if ((extf < 1) || (extf > NO_EXTERNAL_FILES))
		return FileIO_Error(extf, "tried to write to a non-file");
	struc = TableOfExternalFiles-->extf;
	for (::) {
    ch = FileIO_GetC(extf);
		if (ch == -1) rfalse;
		if (ch == 10 or 13) { print "^"; rtrue; }
        if (ch > 65535)
          @streamunichar ch;
        else
          print (char) ch;
	}
];

-) instead of "Print Line" in "FileIO.i6t".

Unicode File IO ends here.

---- Documentation ----

To treat a file as unicode:

  The file of reference is called "ref".
  The output-mode of the file of reference is unicode-mode.

Glk has separate *_uni functions for several file and stream handling calls.

For the non-uni ones, it's definitive that a character is one byte long, and
a byte is the fundamental unit. In text mode, you may only output the values
10, 32 to 126, 160 to 255: linefeed, space, and the printable Latin-1 characters.
(Behavior is undefined, hence implementation dependent, if you try to output
an illegal character). In binary mode, you may output any value 0-255.

With the uni calls, binary mode uses the UTF-32 encoding form: every character
is a 4-byte word. In text mode, version 0.7.5 of the Glk spec calls for UTF-8;
in 0.7.4 and prior versions, the spec defined the behavior as implementation
dependent. (Note that any implementation will be able to read the files it
itself wrote; where there could be an issue is reading a file a different
terp wrote, or wanting some external application to read the file.)

Glk implementations that use UTF-8 for unicode text include:

- Glkote 2.20+
- WindowsGlk 1.47+
- cheapglk 1.05+
- remglk 0.2.5+
- garglk 2022.1+

Glk implementations that use UTF-32 for unicode text include:

- glkterm
- glktermw
- CocoaGlk

The only IDE available that uses UTF-8 for unicode text  is the beta release
of the Windows IDE.

Some interpreters that use UTF-8 for unicode text (which is to say that come
bundled with Glk libraries that do so):

- Gargoyle 2022.1
- Quixe 2.1.3+
- Lectrote (since the earliest)

If you would prefer to test for the Glk library's unicode capabilities
at runtime you could do:

  When play begins:
    if unicode is supported, now the output-mode of the file of reference is unicode-mode.

But if you wanted a Latin-1 fallback if unicode was unavailable, you'd probably
be better off with:

  The file of ref-uni is called "refuni".
  The output-mode of the file of ref-uni is unicode mode.
  The file of ref-latin is called "reflatin".

  The output-file is initially the file of ref-latin.

  When play begins: if unicode is supported, now the output-file is the file of ref-uni.

Beyond the ``if unicode is supported`` phrase, this extension adds:

``if <external file> is in/-- text mode``
``if <external file> is in/-- binary mode``

Otherwise, the extension only modifies functions from FileIO.i6t to use
Glk unicode library functions for files whose output-mode is unicode-mode.

Chapter Changelog

2/220219 updated documentation

2/220218 changed ascii-mode -> latin1-mode, output_mode -> extf_output_mode
added some documentation

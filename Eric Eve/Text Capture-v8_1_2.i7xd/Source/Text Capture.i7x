Version 8.1.2 of Text Capture by Eric Eve begins here.

"Allows the capture of text that would otherwise be sent to the screen, so that the text can be further manipulated, displayed at some other point, or simply discarded. Version 6/120511 allows the use of unicode in Glulx."

"with contributions from Dannii Willis"

Part 1 - Define a Use Option

Use maximum capture buffer length of at least 256 translates as the configuration value CAPTURE_BUFFER_LEN.

Part 2 - Define Our Four Phrases

To decide whether text capturing is active: (- (capture_active > 0) -).

To start capturing text:
	(- StartCapture(); -).

To stop capturing text:
	(- EndCapture(); -).

To say the/-- captured text:
	(- PrintCapture(); -).

Part 3 - I6 Code

Include (-	Global capture_active = 0;	-).

Chapter Z - Z-Machine Version (for Z-Machine Only)

Include (-

Array captured_text -> (CAPTURE_BUFFER_LEN_CFGV + 3);

[ StartCapture;
	if (capture_active ==1)
		return;
	capture_active = 1;
	@output_stream 3 captured_text;
];


[ EndCapture;
	if (capture_active == 0)
		return;
	capture_active = 0;
	@output_stream -3;
	if (captured_text-->0 > CAPTURE_BUFFER_LEN_CFGV)
	{
		print "Error: Overflow in EndCapture.^";
	}
];

[ PrintCapture len i;
	len = captured_text-->0;
	for ( i = 0 : i < len : i++ )
	{
		print (char) captured_text->(i + 2);
	}
];

-).

Chapter G - Glulx (for Glulx Only)

Include (-

Array captured_text --> (CAPTURE_BUFFER_LEN_CFGV + 1);

Global text_capture_old_stream = 0;
Global text_capture_new_stream = 0;

[ StartCapture i;   
	if (capture_active ==1)
		return;
	capture_active = 1;
	text_capture_old_stream = glk_stream_get_current();
	text_capture_new_stream = glk_stream_open_memory_uni(captured_text + WORDSIZE, CAPTURE_BUFFER_LEN_CFGV, 1, 0);
	glk_stream_set_current(text_capture_new_stream);
];

[ EndCapture len;
	if ( capture_active == 0 )
		return;
	capture_active = 0;
	glk_stream_set_current(text_capture_old_stream);
	@copy $ffffffff sp;
	@copy text_capture_new_stream sp;
	@glk $0044 2 0; ! stream_close
	@copy sp len;
	@copy sp 0;
	captured_text-->0 = len;
	if (len > CAPTURE_BUFFER_LEN_CFGV)
	{
		captured_text-->0 = CAPTURE_BUFFER_LEN_CFGV;
	}
];

[ PrintCapture len i;
	len = captured_text-->0;
	for ( i = 0 : i < len : i++ )
	{
		glk_put_char_uni(captured_text-->(i + 1));
	}
];

-).

Text Capture ends here.

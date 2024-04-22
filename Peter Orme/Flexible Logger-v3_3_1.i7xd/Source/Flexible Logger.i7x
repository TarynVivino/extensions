Version 3.3.1 of Flexible Logger by Peter Orme begins here.

"A logging tool for I7 that lets you log to transcript and (with Glulx) to file"

[levels and verbosity comes from Developer Framework]
Include Developer Framework by Peter Orme.

Use Authorial modesty.

Section 1 - The Logger Kind

[
	Since version 3 there is a Logger kind, so we can use more than one and configure them differently. 
 	But don't worry, there's also a default one we can use.
]

A logger is a kind of object. 

[severity is defined in Developer Framework]
A logger has a severity called level.
A logger can be logging to file or not logging to file.
A logger can be logging to console or not logging to console.

The level of a logger is usually debug level.
A logger is usually logging to console.
A logger is usually not logging to file.

Default logger is a logger.
The level of the default logger is debug level.

Section 2 - who logs the loggers? 

[ Verbosity is defined in Developer Framework. ]

logger configuration reporting is a verbosity that varies. 
logger configuration reporting is usually normal verbosity.

Section 3 - Console logging for all 

to console log (message - a text) at (chosen level - a severity) to (chosen logger - a logger):
	unless the chosen level is less than the level of the chosen logger:
		say "([chosen logger], [chosen level], turn [turn count]): [message][line break]";

Section 4 - File Logging (for Glulx only)

The logging file is an external file that varies. 

The File of logging is called "informlog". 

The logging file is the File of logging.

To file log (message - a text) at (chosen level - a severity) to (chosen logger - a logger):
	unless the chosen level is less than the level of the chosen logger:
		append "([chosen logger], [chosen level], turn [turn count]): [message][line break]" to the logging file;
		
Section 5 - Warn about trying to use unavailable file logging (for Z-machine only) 

[
	File logging is not supported for Z-machine, so this prints a warning.
	If we are really bent on trying to log to file with z-machine, but we don't want to be reminded it does not work, 
	we can also mute the warnings: 'now the logger configuration reporting is low verbosity'.
]

To file log (message - a text) at (chosen level - a severity) to (chosen logger - a logger):
	unless the logger configuration reporting is less than normal verbosity:
		say "File logging is not available with z-machine. Disable it with 'now [the chosen logger] is not logging to file.'";

Section 6 - routing the logging to console and/or file

[ Each logger can log to file, or console, or both, or neither. ]

to log (message - a text) at (chosen level - a severity) to (chosen logger - a logger): 
	if the chosen logger is logging to console:
		console log the message at chosen level to the chosen logger;
	if the chosen logger is logging to file:
		file log the message at the chosen level to the chosen logger;
	
Section 8 - shortcuts for logging to a specific logger

[ to make the code a little shorter we can use these shorter versions ]

to debug to (chosen logger - a logger) saying (message - a text): 
	log message at debug level to the chosen logger;

to info to (chosen logger - a logger) saying (message - a text): 
	log message at info level to the chosen logger;

to warn to (chosen logger - a logger) saying (message - a text): 
	log message at warning level to the chosen logger;
	
to error to (chosen logger - a logger) saying (message - a text): 
	log message at error level to the chosen logger;

Section 7 - Shortcuts for logging to default logger 

[ the shortest and simplest way to log is to use these methods which log to the default logger ]

to debug (message - a text):
	log the message at debug level to the default logger;

to info (message - a text):
	log message at info level to default logger;
		
to warn (message - a text):
	log message at warning level to default logger;

to error (message - a text):
	log message at error level to default logger;

to log (message - a text) at (chosen level - a severity): 
	log message at the chosen level to the default logger;


Flexible Logger ends here.


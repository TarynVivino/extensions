Version 6.1.1 of Punctuation Removal by Emily Short begins here.

Use authorial modesty.


Include (-
[ UpdateParserVars;
    VM_Tokenise(buffer, parse);
    num_words = WordCount();
    players_command = 100 + num_words;
];
-)

Section 1 - Wrappers

To remove stray punctuation:
	(- PunctuationStripping(); -)

To remove quotes:
	(- QuoteStripping(); -)

To remove apostrophes:
	(- SingleQuoteStripping(); -)

To remove question marks:
	(- QuestionStripping(); -)
	
To remove exclamation points:
	(- ExclamationStripping(); -)
	
To remove periods:
	(- PeriodStripping(); -)
	
To remove tabs:
	(- TabStripping(); -)
	
To resolve punctuated titles:
	(- DeTitler(); -)

Section 2 (for Z-machine only)

Include (- 

[ DeTitler i j buffer_length flag; 

	VM_Tokenise(buffer, parse);

	buffer_length = buffer->1+(WORDSIZE-1);
	for (i = WORDSIZE : i <= buffer_length: i++)
	{ 
		if ((buffer->i) == '.' && (i > WORDSIZE + 1)) 
		{ 
			! flag if the period follows Mr, Mrs, Ms, Dr, prof, rev, or st
			!
			! This is hackish, but our hearts are pure

            if (i >= 5) {
            if ((i == 5) || (buffer->(i-3)==' ')) {
				 if ((buffer->(i-1)=='r') || (buffer->(i-1)=='R')) {
                	if ((buffer->(i-2)=='m') || (buffer->(i-2)=='M') || (buffer->(i-2)=='d') || (buffer->(i-2)=='D')) {
						buffer->i = ' '; continue;
					}
				}
				if ((buffer->(i-1)=='s') || (buffer->(i-1)=='S')) {
                	if ((buffer->(i-2)=='m') || (buffer->(i-2)=='M')) {
						buffer->i = ' '; continue;
					}
				}
				if ((buffer->(i-1)=='t') || (buffer->(i-1)=='T')) {
                	if ((buffer->(i-2)=='s') || (buffer->(i-2)=='S')) {
						buffer->i = ' '; continue;
					}
				}
			}
}
            if (i >= 6) {
            if ((i == 6) || (buffer->(i-4)==' ')) {
				 if ((buffer->(i-1)=='s') || (buffer->(i-1)=='S')) {
                	if ((buffer->(i-2)=='r') || (buffer->(i-2)=='R')) {
	                	if ((buffer->(i-3)=='m') || (buffer->(i-2)=='M')) {
							buffer->i = ' '; continue;
					}
				}
				 if ((buffer->(i-1)=='v') || (buffer->(i-1)=='V')) {
                	if ((buffer->(i-2)=='e') || (buffer->(i-2)=='E')) {
	                	if ((buffer->(i-3)=='r') || (buffer->(i-2)=='R')) {
							buffer->i = ' '; continue;
					}
				}
}
}
}

            if (i >= 7) {
            if ((i == 7) || (buffer->(i-5)==' ')) {
				 if ((buffer->(i-1)=='f') || (buffer->(i-1)=='F')) {
                	if ((buffer->(i-2)=='o') || (buffer->(i-2)=='O')) {
	                	if ((buffer->(i-3)=='r') || (buffer->(i-2)=='R')) {
		                	if ((buffer->(i-4)=='p') || (buffer->(i-2)=='P')) {
								buffer->i = ' '; continue;
}
					}
				}
}
}
}


			
!			if ((buffer->(i-1)=='r') && (buffer->(i-2)=='m') && ((buffer->(i-3)==' ') || ((i-3) < WORDSIZE))) flag = 1;
!			if ((buffer->(i-1)=='r') && (buffer->(i-2)=='d') && ((buffer->(i-3)==' ') || ((i-3) < WORDSIZE))) flag = 1;
!			if ((buffer->(i-1)=='t') && (buffer->(i-2)=='s') && ((buffer->(i-3)==' ') || ((i-3) < WORDSIZE))) flag = 1;
!			if ((buffer->(i-1)=='s') && (buffer->(i-2)=='r') && (buffer->(i-3)=='m') && ((buffer->(i-4)==' ') || ((i-4) < WORDSIZE))) flag = 1;
!			if ((buffer->(i-1)=='v') && (buffer->(i-2)=='e') && (buffer->(i-3)=='r') && ((buffer->(i-4)==' ') || ((i-4) < WORDSIZE))) flag = 1;
!			if ((buffer->(i-1)=='f') && (buffer->(i-2)=='o') && (buffer->(i-3)=='r') && (buffer->(i-4)=='p') && ((buffer->(i-5)==' ') || ((i-5) < WORDSIZE))) flag = 1;
!			if (flag) buffer->i = ' ';   
		}
	}
	UpdateParserVars();
]; 

[ PunctuationStripping i;
	for (i = 2 : i <= (buffer->1) + 1 : i++)
	{ 
		if ((buffer->i) == '"' or '?' or '!' or 9) 
		{	buffer->i = ' ';  
		}
	}
	UpdateParserVars();
];

[ SingleQuoteStripping i;
	for (i = 2 : i <= (buffer->1) + 1 : i++)
	{ 
		if ((buffer->i) == 39 or 9) 
		{	buffer->i = ' ';  
		}
	}
	UpdateParserVars();
];

[ QuoteStripping i;
	for (i = 2 : i <= (buffer->1) + 1 : i++)
	{ 
		if ((buffer->i) == '"' or 9) 
		{	buffer->i = ' ';  
		}
	}
	UpdateParserVars();
];

[ QuestionStripping i;
	for (i = 2 : i <= (buffer->1) + 1 : i++)
	{ 
		if ((buffer->i) == '?' or 9) 
		{	buffer->i = ' ';  
		}
	}
	UpdateParserVars();
];

[ ExclamationStripping i;
	for (i = 2 : i <= (buffer->1) + 1 : i++)
	{ 
		if ((buffer->i) == '!' or 9) 
		{	buffer->i = ' ';  
		}
	}
	UpdateParserVars();
];

[ PeriodStripping i j;
	for (i = 2 : i <= (buffer->1) + 1 : i++)
	{ 
		if ((buffer->i) == '.' or 9) 
		{	buffer->i = ' ';  
		}
	}
	UpdateParserVars();
];


[ TabStripping i j;
	for (i = 2 : i <= (buffer->1) + 1 : i++)
	{ 
		if ((buffer->i) == 9) 
		{	buffer->i = ' ';  
		}
	}
	UpdateParserVars();
];

-)

Section 3 (for Glulx only) 

Include (- 

[ DeTitler i j buffer_length flag; 

	buffer_length = (buffer-->0)+1;
	for (i = 1 : i <= buffer_length: i++)
	{ 
		if ((buffer-->i) == '.' && (i > 2)) 
		{ 
			! flag if the period follows Mr, Mrs, Dr, prof, rev, or st, Ms
			!
			! This is hackish, but our hearts are pure
            if (i >= 3) {
            if ((i == 3) || (buffer-->(i-3)==' ')) {
				 if ((buffer-->(i-1)=='r') || (buffer-->(i-1)=='R')) {
                	if ((buffer-->(i-2)=='m') || (buffer-->(i-2)=='M') || (buffer-->(i-2)=='d') || (buffer-->(i-2)=='D')) {
						buffer-->i = ' '; continue;
					}
				}
				if ((buffer-->(i-1)=='s') || (buffer-->(i-1)=='S')) {
                	if ((buffer-->(i-2)=='m') || (buffer-->(i-2)=='M')) {
						buffer-->i = ' '; continue;
					}
				}
				if ((buffer-->(i-1)=='t') || (buffer-->(i-1)=='T')) {
                	if ((buffer-->(i-2)=='s') || (buffer-->(i-2)=='S')) {
						buffer-->i = ' '; continue;
					}
				}
			}
}
            if (i >= 4) {
            if ((i == 4) || (buffer-->(i-4)==' ')) {
				 if ((buffer-->(i-1)=='s') || (buffer-->(i-1)=='S')) {
                	if ((buffer-->(i-2)=='r') || (buffer-->(i-2)=='R')) {
	                	if ((buffer-->(i-3)=='m') || (buffer-->(i-2)=='M')) {
							buffer-->i = ' '; continue;
					}
				}
}
}
}

            if (i >= 5) {
            if ((i == 5) || (buffer-->(i-5)==' ')) {
				 if ((buffer-->(i-1)=='f') || (buffer-->(i-1)=='F')) {
                	if ((buffer-->(i-2)=='o') || (buffer-->(i-2)=='O')) {
	                	if ((buffer-->(i-3)=='r') || (buffer-->(i-2)=='R')) {
		                	if ((buffer-->(i-4)=='p') || (buffer-->(i-2)=='P')) {
								buffer-->i = ' '; continue;
}
					}
				}
}
}
}

!			if ((buffer-->(i-1)=='r') && (buffer-->(i-2)=='m') && ((buffer-->(i-3)==' ') || ((i-3) < 1))) flag = 1;
!			if ((buffer-->(i-1)=='r') && (buffer-->(i-2)=='d') && ((buffer-->(i-3)==' ') || ((i-3) < 1))) flag = 1;
!			if ((buffer-->(i-1)=='t') && (buffer-->(i-2)=='s') && ((buffer-->(i-3)==' ') || ((i-3) < 1))) flag = 1;
!			if ((buffer-->(i-1)=='s') && (buffer-->(i-2)=='r') && (buffer-->(i-3)=='m') && ((buffer-->(i-4)==' ') || ((i-4) < 1))) flag = 1;
!			if ((buffer-->(i-1)=='v') && (buffer-->(i-2)=='e') && (buffer-->(i-3)=='r') && ((buffer-->(i-4)==' ') || ((i-4) < 1))) flag = 1;
!			if ((buffer-->(i-1)=='f') && (buffer-->(i-2)=='o') && (buffer-->(i-3)=='r') && (buffer-->(i-4)=='p') && ((buffer-->(i-5)==' ') || ((i-5) < 1))) flag = 1;
!			if (flag) buffer-->i = ' ';   
		}
	}
	UpdateParserVars();
]; 

[ BufferOut i;   
	for (i = 1 : i <= (buffer-->0) : i++)
	{  
		print (char) (buffer-->i);
	} 
];

[ PunctuationStripping i;
	for (i = 1 : i <= (buffer-->0) : i++)
	{ 
		if ((buffer-->i) == '"' or '?' or '!' or 9) 
		{	buffer-->i = ' ';  
		}
	}
	UpdateParserVars();
];

[ SingleQuoteStripping i;
	for (i = 1 : i <= (buffer-->0) : i++)	{ 
		if ((buffer-->i) == 39 or 9) 
		{	buffer-->i = ' ';  
		}
	}
	UpdateParserVars();
];

[ QuoteStripping i;
	for (i = 1 : i <= (buffer-->0) : i++)	{ 
		if ((buffer-->i) == '"' or 9) 
		{	buffer-->i = ' ';  
		}
	}
	UpdateParserVars();
];

[ QuestionStripping i;
	for (i = 1 : i <= (buffer-->0) : i++)
	{ 
		if ((buffer-->i) == '?' or 9) 
		{	buffer-->i = ' ';  
		}
	}
	UpdateParserVars();
];

[ ExclamationStripping i;
	for (i = 1 : i <= (buffer-->0) : i++)
	{ 
		if ((buffer-->i) == '!' or 9) 
		{	buffer-->i = ' ';  
		}
	}
	UpdateParserVars();
];

[ PeriodStripping i j;
	for (i = 1 : i <= (buffer-->0) : i++)
	{ 
		if ((buffer-->i) == '.' or 9) 
		{	buffer-->i = ' ';  
		}
	}
	UpdateParserVars();
];

[ TabStripping i j;
	for (i = 1 : i <= (buffer-->0) : i++)
	{ 
		if ((buffer-->i) == 9) 
		{	buffer-->i = ' ';  
		}
	}
	UpdateParserVars();
];

-)

Punctuation Removal ends here.

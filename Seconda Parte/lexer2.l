%{

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>
#include "y.tab.h"
#include <stdbool.h>

char *getpastr(char *s);

int val = 0;

%}

DIGITS [0-9]+
space [\n\r\t]*

%%

{DIGITS}    {val = atoi(yytext); yylval.dvalue = val; return NUMBER;}
\%        	{yylval.strvalue = getpastr(yytext);return PERC;}
\-          {yylval.strvalue = getpastr(yytext);return MINUS;}
\+          {yylval.strvalue = getpastr(yytext);return PLUS;}
\/          {yylval.strvalue = getpastr(yytext);return DIV;}
\*          {yylval.strvalue = getpastr(yytext);return PROD;}
\(			{yylval.strvalue = getpastr(yytext);return LBRA;}
\)			{yylval.strvalue = getpastr(yytext);return RBRA;}

{space}		;
.           ;


%%

int yywrap(void){return 1;}

char *getpastr(char *s)
{
	return strcpy((char *)malloc(strlen(s)+1),s);
}

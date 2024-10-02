%{

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>
#include"y.tab.h"

char *getpastr(char *s);

%}

DIGITS [0-9]+
space [\r\t\n]*
others [a-zA-Z0-9]+
notOthers [UP|DOWN|LEFT|RIGHT]

%%

UP 		{yylval.strvalue = getpastr(yytext);return UP;}
DOWN		{yylval.strvalue = getpastr(yytext);return DOWN;}
LEFT		{yylval.strvalue = getpastr(yytext);return LEFT;}
RIGHT 	{yylval.strvalue = getpastr(yytext);return RIGHT;}
dest 		{yylval.strvalue = getpastr(yytext);return DEST;}
{DIGITS} 		{yylval.dvalue = atoi(yytext);return NUM;}
space+				;
[others \ notOthers]  printf("Wrong move!\n");
.					;

%%

int yywrap(void){return 1;}

char *getpastr(char *s)
{
	return strcpy((char *)malloc(strlen(s)+1),s);
}


%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

void yyerror(char const* s);
int yyparse();
int yylex();
int x_value = 0;
int y_value = 0;

%}

%union  {

    char* strvalue;
    int dvalue;
}


%token <dvalue> NUM
%token <strvalue> UP
%token <strvalue> DOWN
%token <strvalue> RIGHT
%token <strvalue> LEFT
%token <strvalue> DEST

%type <strvalue> lines line
%type <dvalue> num

%%

lines: lines line | line;

line: move
| DEST          {printf("Reached point : B(%d,%d)\n",x_value,y_value);}
;

move: UP num       {x_value = x_value+$2;}
| DOWN num         {x_value = x_value-$2;}
| RIGHT num        {y_value = y_value+$2;}
| LEFT num         {y_value = y_value-$2;}
;

num: NUM           {$$ = $1;}
;

%%

void main(int argc, char * argv[]){

    extern FILE *yyin;

    yyin = fopen("input", "r");

    yyparse();
}

void yyerror(char const*s) {
  fprintf(stderr,"%s\n",s);
}

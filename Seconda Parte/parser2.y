%{
	#include <stdio.h>
	#include <ctype.h>
	#include <string.h>
	#include <stdbool.h>
	#include <stdlib.h>
	#include <unistd.h>

	typedef struct syntax_tree {
		char* treeValue;
		int how_many_children;
		struct syntax_tree **child;
	} syntax_tree;

	int yylex();
	int yyparse();
	void yyerror(char const *s);

	char *getstr(char *s);
	struct syntax_tree *new_syntax_tree(char *treeValue);
	void add_child(struct syntax_tree *father,struct syntax_tree *child);
	void print_tree(struct syntax_tree *tree,int indent);
	char* itoa(int val);

%}

%union{
    int dvalue;
    char *strvalue;
    struct syntax_tree * tree;
}

%token <dvalue> NUMBER
%token <strvalue> PERC
%token <strvalue> PLUS
%token <strvalue> MINUS
%token <strvalue> DIV
%token <strvalue> PROD
%token <strvalue> RBRA
%token <strvalue> LBRA

%type <tree> expr term factor

%%

expr: expr PLUS term 	{$$ = new_syntax_tree("+");add_child($$,$1);add_child($$,$3);print_tree($$,0);}
	 |expr MINUS term  	{$$ = new_syntax_tree("-");add_child($$,$1);add_child($$,$3);print_tree($$,0);}
	 |term  			{$$ = $1;print_tree($$,0);}
;

term: term PROD factor	{$$ = new_syntax_tree("*");add_child($$,$1);add_child($$,$3);}
	 |term DIV factor	{$$ = new_syntax_tree("/");add_child($$,$1);add_child($$,$3);}
     |term PERC factor	{$$ = new_syntax_tree("%");add_child($$,$1);add_child($$,$3);}
	 |factor			{$$ = $1;}
;
factor: NUMBER					{$$ = new_syntax_tree(itoa($1));}
		|LBRA expr RBRA			{$$ = $2;}
		|MINUS factor			{$$ = new_syntax_tree("(-)");add_child($$,$2);}
		|PLUS factor			{$$ = new_syntax_tree("(+)");add_child($$,$2);}
;

%%

int main(void){

	extern FILE *yyin;

    yyin = fopen("input", "r");

    yyparse();

}


void yyerror (char const *s) {
   fprintf(stderr, "%s\n", s);
 }

char *getstr(char *s) { return strcpy((char *)malloc(strlen(s)+1),s);}

struct syntax_tree* new_syntax_tree(char *treeValue) {

	struct syntax_tree *tree;
	tree =((struct syntax_tree *)malloc(sizeof(struct syntax_tree)));

	tree->treeValue = getstr(treeValue);
	tree->how_many_children = 0;
	tree->child= NULL;
	return tree;
}

void add_child(struct syntax_tree *father, struct syntax_tree *child){

	//struct syntax_tree *child;
	//child = new_syntax_tree(treeValue);

	father->child = (struct syntax_tree **) realloc(father->child, sizeof(struct syntax_tree *)*(father->how_many_children+1));
	father->child[father->how_many_children] = child;
	father->how_many_children++;


}

void print_tree(struct syntax_tree *tree,int indent)	{

	for (int i=0;i<indent;i++) printf(" ");
		printf("%s",tree->treeValue);

	if (tree->how_many_children > 0)
		printf("\n");

	for (int i=0;i<tree->how_many_children;i++)
		print_tree(tree->child[i],indent+1);

	for (int i=0;i<indent;i++) printf(" ");
		printf("\n");
}

char* itoa(int val){

	char * str = (char *)malloc(32);
	int base = 10;

	int i = 0;

	for(; val > 0 ; ++i, val /= base) {
		str[i] = (char)(val%base + 48);
	}

	char tmp;
	char * finalString = (char*)malloc(32);
	int j = 0;

	for(int i = strlen(str)-1;i>=0;i--){
		tmp = str[i];
		finalString[j] = tmp;
		j++;
	}

	finalString[31] = '\0';

	return finalString;
}


